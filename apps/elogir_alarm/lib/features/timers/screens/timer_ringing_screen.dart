import 'package:alarm/alarm.dart' as native;
import 'package:elogir_alarm/features/timers/models/app_timer.dart';
import 'package:elogir_alarm/features/timers/providers/active_timers_provider.dart';
import 'package:elogir_alarm/shared/extensions/duration_extensions.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-screen ringing overlay shown when a timer completes.
///
/// Offers Dismiss and Restart actions.
class TimerRingingScreen extends ConsumerWidget {
  const TimerRingingScreen({required this.timerId, super.key});

  final String timerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ElogirTheme.of(context);
    final timers = ref.watch(activeTimersProvider);

    AppTimer? timer;
    for (final t in timers) {
      if (t.id == timerId) {
        timer = t;
        break;
      }
    }

    // Timer not found (e.g. removed while ringing) — navigate back.
    if (timer == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go('/timers');
      });
      return const SizedBox.shrink();
    }

    final t = timer;

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
                  child: _TimeRing(text: t.remaining.formatted),
                ),
              ),
              SizedBox(height: theme.spacing.lg),

              // Label
              if (t.label.isNotEmpty) ...[
                ElogirFadeIn(
                  delay: const Duration(milliseconds: 100),
                  child: ElogirText(
                    t.label,
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
                  'Timer',
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
                      onPressed: () => _dismiss(context, ref, t),
                      expanded: true,
                      size: ElogirButtonSize.lg,
                      child: const Text('Dismiss'),
                    ),
                    SizedBox(height: theme.spacing.md),
                    ElogirButton(
                      onPressed: () => _restart(context, ref, t),
                      variant: ElogirButtonVariant.outlined,
                      expanded: true,
                      size: ElogirButtonSize.lg,
                      child: const Text('Restart'),
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

  Future<void> _dismiss(
    BuildContext context,
    WidgetRef ref,
    AppTimer timer,
  ) async {
    final nativeId = timer.id.hashCode.abs().clamp(1, 0x7FFFFFFF);
    await native.Alarm.stop(nativeId);
    if (context.mounted) context.go('/timers');
  }

  Future<void> _restart(
    BuildContext context,
    WidgetRef ref,
    AppTimer timer,
  ) async {
    final nativeId = timer.id.hashCode.abs().clamp(1, 0x7FFFFFFF);
    await native.Alarm.stop(nativeId);
    ref.read(activeTimersProvider.notifier).restart(timer.id);
    if (context.mounted) context.go('/timers');
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
