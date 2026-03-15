import 'package:alarm/alarm.dart' as native;
import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/alarms/providers/alarm_repository_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/alarm_scheduler_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/alarms_provider.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-screen ringing alarm overlay shown on Android when an alarm fires.
///
/// Looks up the alarm model by [alarmId] and offers Snooze / Dismiss actions.
class AlarmRingingScreen extends ConsumerWidget {
  const AlarmRingingScreen({required this.alarmId, super.key});

  final String alarmId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ElogirTheme.of(context);
    final alarmsAsync = ref.watch(alarmsProvider);

    Alarm? alarm;
    for (final a in alarmsAsync.value ?? <Alarm>[]) {
      if (a.id == alarmId) {
        alarm = a;
        break;
      }
    }

    // Alarm not found (e.g. deleted while ringing) — navigate back.
    if (alarm == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go('/alarms');
      });
      return const SizedBox.shrink();
    }

    final a = alarm;

    return ElogirScaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElogirText(
                a.timeFormatted,
                variant: ElogirTextVariant.displayLarge,
                textAlign: TextAlign.center,
              ),
              if (a.label.isNotEmpty) ...[
                SizedBox(height: theme.spacing.sm),
                ElogirText(
                  a.label,
                  variant: ElogirTextVariant.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ],
              SizedBox(height: theme.spacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElogirButton(
                    onPressed: () => _snooze(context, ref, a),
                    variant: ElogirButtonVariant.outlined,
                    child: Text('Snooze ${a.snoozeDurationMinutes} min'),
                  ),
                  SizedBox(width: theme.spacing.md),
                  ElogirButton(
                    onPressed: () => _dismiss(context, ref, a),
                    child: const Text('Dismiss'),
                  ),
                ],
              ),
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
    final nativeId = alarm.id.hashCode.abs().clamp(1, 0x7FFFFFFF);
    await native.Alarm.stop(nativeId);
    final snoozeTime =
        DateTime.now().add(Duration(minutes: alarm.snoozeDurationMinutes));
    await ref
        .read(alarmRepositoryProvider)
        .updateSnoozedUntil(alarm.id, snoozeTime);
    await native.Alarm.set(
      alarmSettings: native.AlarmSettings(
        id: nativeId,
        dateTime: snoozeTime,
        volumeSettings: const native.VolumeSettings.fixed(),
        notificationSettings: native.NotificationSettings(
          title: alarm.label.isEmpty ? 'Alarm' : alarm.label,
          body: alarm.timeFormatted,
          stopButton: 'Dismiss',
        ),
        assetAudioPath: AppConstants.soundAssetPath(alarm.soundId),
        loopAudio: true,
        vibrate: true,
        androidFullScreenIntent: true,
        warningNotificationOnKill: false,
      ),
    );
    if (context.mounted) context.go('/alarms');
  }

  Future<void> _dismiss(
    BuildContext context,
    WidgetRef ref,
    Alarm alarm,
  ) async {
    final nativeId = alarm.id.hashCode.abs().clamp(1, 0x7FFFFFFF);
    await native.Alarm.stop(nativeId);
    await ref.read(alarmRepositoryProvider).updateSnoozedUntil(alarm.id, null);
    // Repeating alarms: schedule the next occurrence after dismissal.
    if (alarm.repeatDays.isNotEmpty) {
      await ref.read(alarmSchedulerProvider).schedule(alarm);
    }
    if (context.mounted) context.go('/alarms');
  }
}
