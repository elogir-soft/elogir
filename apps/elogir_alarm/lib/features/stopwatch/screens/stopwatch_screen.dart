import 'package:elogir_alarm/features/stopwatch/providers/stopwatch_provider.dart';
import 'package:elogir_alarm/features/stopwatch/widgets/lap_time_list.dart';
import 'package:elogir_alarm/features/stopwatch/widgets/stopwatch_display.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Main stopwatch screen with display, controls, and lap list.
class StopwatchScreen extends ConsumerWidget {
  const StopwatchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ElogirTheme.of(context);
    final state = ref.watch(stopwatchProvider);
    final notifier = ref.read(stopwatchProvider.notifier);

    return ElogirScaffold(
      appBar: const ElogirAppBar(
        title: ElogirText('Stopwatch', variant: ElogirTextVariant.titleLarge),
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
