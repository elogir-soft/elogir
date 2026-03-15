import 'dart:async';

import 'package:alarm/alarm.dart' as native;
import 'package:alarm/utils/alarm_set.dart';
import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/alarms/providers/alarm_repository_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/alarm_scheduler_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/alarms_provider.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-screen ringing alarm overlay shown when an alarm fires.
///
/// Looks up the alarm model by [alarmId] and offers Snooze / Dismiss actions.
/// Auto-dismisses when the alarm is stopped externally (e.g. from the
/// notification action).
class AlarmRingingScreen extends ConsumerStatefulWidget {
  const AlarmRingingScreen({required this.alarmId, super.key});

  final String alarmId;

  @override
  ConsumerState<AlarmRingingScreen> createState() => _AlarmRingingScreenState();
}

class _AlarmRingingScreenState extends ConsumerState<AlarmRingingScreen> {
  StreamSubscription<AlarmSet>? _ringingSub;
  bool _navigating = false;

  int get _nativeId =>
      widget.alarmId.hashCode.abs().clamp(1, 0x7FFFFFFF);

  @override
  void initState() {
    super.initState();
    _ringingSub = native.Alarm.ringing.listen(_onRingingUpdate);
  }

  @override
  void dispose() {
    _ringingSub?.cancel();
    super.dispose();
  }

  void _onRingingUpdate(AlarmSet alarmSet) {
    if (_navigating) return;
    if (!alarmSet.containsId(_nativeId)) {
      _navigating = true;
      if (mounted) context.go('/alarms');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final alarmsAsync = ref.watch(alarmsProvider);

    Alarm? alarm;
    for (final a in alarmsAsync.value ?? <Alarm>[]) {
      if (a.id == widget.alarmId) {
        alarm = a;
        break;
      }
    }

    // Alarm not found (e.g. deleted while ringing) — navigate back.
    if (alarm == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_navigating && mounted) {
          _navigating = true;
          context.go('/alarms');
        }
      });
      return const SizedBox.shrink();
    }

    final a = alarm;

    return ElogirScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.xl),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Pulsing time ring
              ElogirFadeIn(
                child: ElogirPulse(
                  mode: ElogirPulseMode.scale,
                  minScale: 0.96,
                  maxScale: 1.04,
                  child: _TimeRing(text: a.timeFormatted),
                ),
              ),
              SizedBox(height: theme.spacing.lg),

              // Label
              if (a.label.isNotEmpty) ...[
                ElogirFadeIn(
                  delay: const Duration(milliseconds: 100),
                  child: ElogirText(
                    a.label,
                    variant: ElogirTextVariant.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: theme.spacing.xs),
              ],

              // Subtitle
              ElogirFadeIn(
                delay: const Duration(milliseconds: 150),
                child: ElogirText(
                  'Alarm',
                  variant: ElogirTextVariant.bodyLarge,
                  style: TextStyle(color: theme.colors.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
              ),

              const Spacer(flex: 3),

              // Actions
              ElogirFadeIn(
                delay: const Duration(milliseconds: 200),
                direction: ElogirFadeInDirection.up,
                child: Column(
                  children: [
                    ElogirButton(
                      onPressed: () => _dismiss(context, ref, a),
                      expanded: true,
                      size: ElogirButtonSize.lg,
                      child: const Text('Dismiss'),
                    ),
                    SizedBox(height: theme.spacing.md),
                    ElogirButton(
                      onPressed: () => _snooze(context, ref, a),
                      variant: ElogirButtonVariant.outlined,
                      expanded: true,
                      size: ElogirButtonSize.lg,
                      child: Text('Snooze ${a.snoozeDurationMinutes} min'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: theme.spacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _snooze(
    BuildContext context,
    WidgetRef ref,
    Alarm alarm,
  ) async {
    _navigating = true;
    await native.Alarm.stop(_nativeId);
    final snoozeTime =
        DateTime.now().add(Duration(minutes: alarm.snoozeDurationMinutes));
    await ref
        .read(alarmRepositoryProvider)
        .updateSnoozedUntil(alarm.id, snoozeTime);
    await native.Alarm.set(
      alarmSettings: native.AlarmSettings(
        id: _nativeId,
        dateTime: snoozeTime,
        volumeSettings: const native.VolumeSettings.fixed(),
        notificationSettings: native.NotificationSettings(
          title: alarm.label.isEmpty ? 'Alarm' : alarm.label,
          body: alarm.timeFormatted,
          stopButton: 'Dismiss',
          snoozeButton: 'Snooze',
          snoozeDurationMinutes: alarm.snoozeDurationMinutes,
        ),
        assetAudioPath: AppConstants.soundAssetPath(alarm.soundId),
        loopAudio: true,
        vibrate: true,
        androidFullScreenIntent: true,
        warningNotificationOnKill: false,
      ),
    );
    if (mounted) context.go('/alarms');
  }

  Future<void> _dismiss(
    BuildContext context,
    WidgetRef ref,
    Alarm alarm,
  ) async {
    _navigating = true;
    await native.Alarm.stop(_nativeId);
    await ref.read(alarmRepositoryProvider).updateSnoozedUntil(alarm.id, null);
    // Repeating alarms: schedule the next occurrence after dismissal.
    if (alarm.repeatDays.isNotEmpty) {
      await ref.read(alarmSchedulerProvider).schedule(alarm);
    }
    if (mounted) context.go('/alarms');
  }
}

class _TimeRing extends StatelessWidget {
  const _TimeRing({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    const size = 220.0;
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colors.primaryContainer,
          border: Border.all(
            color: theme.colors.primary,
            width: theme.strokes.thick,
          ),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: EdgeInsets.all(theme.spacing.xl),
              child: Text(
                text,
                style: theme.typography.displayLarge.copyWith(
                  color: theme.colors.onSurface,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
