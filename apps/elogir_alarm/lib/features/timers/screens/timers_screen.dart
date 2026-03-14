import 'package:elogir_alarm/features/timers/providers/active_timers_provider.dart';
import 'package:elogir_alarm/features/timers/widgets/duration_input.dart';
import 'package:elogir_alarm/features/timers/widgets/preset_grid.dart';
import 'package:elogir_alarm/features/timers/widgets/timer_card.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Main screen showing timer presets, custom input, and active timers.
class TimersScreen extends ConsumerStatefulWidget {
  const TimersScreen({super.key});

  @override
  ConsumerState<TimersScreen> createState() => _TimersScreenState();
}

class _TimersScreenState extends ConsumerState<TimersScreen> {
  Duration _customDuration = Duration.zero;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final timers = ref.watch(activeTimersProvider);

    return ElogirScaffold(
      appBar: const ElogirAppBar(
        title: ElogirText('Timers', variant: ElogirTextVariant.titleLarge),
      ),
      body: ListView(
        padding: EdgeInsets.all(theme.spacing.md),
        children: [
          // Quick presets
          ElogirText(
            'Quick Start',
            variant: ElogirTextVariant.titleSmall,
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
          SizedBox(height: theme.spacing.sm),
          PresetGrid(
            onPresetSelected: (ms) {
              ref.read(activeTimersProvider.notifier).startNew(durationMs: ms);
            },
          ),
          SizedBox(height: theme.spacing.lg),

          // Custom duration
          ElogirText(
            'Custom',
            variant: ElogirTextVariant.titleSmall,
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
          SizedBox(height: theme.spacing.sm),
          DurationInput(
            onDurationChanged: (d) => _customDuration = d,
          ),
          SizedBox(height: theme.spacing.sm),
          ElogirButton(
            onPressed: () {
              if (_customDuration.inMilliseconds > 0) {
                ref.read(activeTimersProvider.notifier).startNew(
                      durationMs: _customDuration.inMilliseconds,
                    );
              }
            },
            expanded: true,
            child: const Text('Start'),
          ),
          SizedBox(height: theme.spacing.lg),

          // Active timers
          if (timers.isNotEmpty) ...[
            Row(
              children: [
                Expanded(
                  child: ElogirText(
                    'Active Timers',
                    variant: ElogirTextVariant.titleSmall,
                    style: TextStyle(color: theme.colors.onSurfaceVariant),
                  ),
                ),
                if (timers.any((t) => !t.status.isActive))
                  ElogirButton(
                    onPressed: () {
                      ref.read(activeTimersProvider.notifier).clearFinished();
                    },
                    variant: ElogirButtonVariant.ghost,
                    size: ElogirButtonSize.sm,
                    child: const Text('Clear Done'),
                  ),
              ],
            ),
            SizedBox(height: theme.spacing.sm),
            ...timers.map(
              (timer) => Padding(
                padding: EdgeInsets.only(bottom: theme.spacing.sm),
                child: TimerCard(
                  timer: timer,
                  onPause: () =>
                      ref.read(activeTimersProvider.notifier).pause(timer.id),
                  onResume: () =>
                      ref.read(activeTimersProvider.notifier).resume(timer.id),
                  onCancel: () =>
                      ref.read(activeTimersProvider.notifier).cancel(timer.id),
                  onRemove: () =>
                      ref.read(activeTimersProvider.notifier).remove(timer.id),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
