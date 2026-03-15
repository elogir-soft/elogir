import 'package:elogir_alarm/features/settings/providers/settings_provider.dart';
import 'package:elogir_alarm/features/stopwatch/providers/stopwatch_provider.dart';
import 'package:elogir_alarm/features/stopwatch/widgets/lap_time_list.dart';
import 'package:elogir_alarm/features/stopwatch/widgets/stopwatch_display.dart';
import 'package:elogir_alarm/shared/widgets/overflow_menu.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Main stopwatch screen with display, controls, and lap list.
class StopwatchScreen extends ConsumerStatefulWidget {
  const StopwatchScreen({super.key});

  @override
  ConsumerState<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends ConsumerState<StopwatchScreen> {
  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  void _updateWakelock({
    required bool isRunning,
    required bool keepScreenOn,
  }) {
    if (isRunning && keepScreenOn) {
      WakelockPlus.enable();
    } else {
      WakelockPlus.disable();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final state = ref.watch(stopwatchProvider);
    final notifier = ref.read(stopwatchProvider.notifier);
    final keepScreenOn = ref.watch(
      settingsProvider
          .select((s) => s.value?.keepScreenOnStopwatch ?? false),
    );

    ref.listen(
      stopwatchProvider.select((s) => s.isRunning),
      (_, isRunning) =>
          _updateWakelock(isRunning: isRunning, keepScreenOn: keepScreenOn),
    );

    ref.listen(
      settingsProvider
          .select((s) => s.value?.keepScreenOnStopwatch ?? false),
      (_, keepOn) =>
          _updateWakelock(isRunning: state.isRunning, keepScreenOn: keepOn),
    );

    return ElogirScaffold(
      appBar: const ElogirAppBar(
        title: ElogirText('Stopwatch', variant: ElogirTextVariant.titleLarge),
        trailing: AppOverflowMenu(),
      ),
      body: Column(
        children: [
          SizedBox(height: theme.spacing.xl),
          // Stopwatch display
          StopwatchDisplay(
            elapsed: state.elapsed,
            isRunning: state.isRunning,
          ),
          SizedBox(height: theme.spacing.xl),
          // Control buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.isRunning) ...[
                  // Lap button
                  ElogirButton(
                    onPressed: notifier.lap,
                    variant: ElogirButtonVariant.outlined,
                    size: ElogirButtonSize.lg,
                    child: const Text('Lap'),
                  ),
                  SizedBox(width: theme.spacing.md),
                  // Stop button
                  ElogirButton(
                    onPressed: notifier.stop,
                    size: ElogirButtonSize.lg,
                    child: const Text('Stop'),
                  ),
                ] else ...[
                  // Reset button (only if has started)
                  if (state.hasStarted) ...[
                    ElogirButton(
                      onPressed: notifier.reset,
                      variant: ElogirButtonVariant.outlined,
                      size: ElogirButtonSize.lg,
                      child: const Text('Reset'),
                    ),
                    SizedBox(width: theme.spacing.md),
                  ],
                  // Start button
                  ElogirButton(
                    onPressed: notifier.start,
                    size: ElogirButtonSize.lg,
                    child: Text(state.hasStarted ? 'Resume' : 'Start'),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: theme.spacing.lg),
          // Lap list
          if (state.laps.isNotEmpty)
            Expanded(
              child: LapTimeList(laps: state.laps),
            )
          else
            const Spacer(),
        ],
      ),
    );
  }
}
