import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Large stopwatch time display with MM:SS.cc format.
class StopwatchDisplay extends StatelessWidget {
  const StopwatchDisplay({
    required this.elapsed,
    this.isRunning = false,
    super.key,
  });

  final Duration elapsed;
  final bool isRunning;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final minutes = elapsed.inMinutes.remainder(60);
    final seconds = elapsed.inSeconds.remainder(60);
    final centiseconds = elapsed.inMilliseconds.remainder(1000) ~/ 10;

    final mainStyle = theme.typography.displayLarge.copyWith(
      fontSize: 72,
      color: theme.colors.onBackground,
      fontFeatures: const [FontFeature.tabularFigures()],
      fontWeight: FontWeight.w300,
    );

    final centiStyle = theme.typography.headlineMedium.copyWith(
      color: theme.colors.onSurfaceVariant,
      fontFeatures: const [FontFeature.tabularFigures()],
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        ElogirAnimatedCounter(
          value: minutes,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
          style: mainStyle,
          prefix: '',
          suffix: ':',
          fractionDigits: 0,
          padding: 2,
        ),
        ElogirAnimatedCounter(
          value: seconds,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
          style: mainStyle,
          prefix: '',
          suffix: '.',
          fractionDigits: 0,
          padding: 2,
        ),
        ElogirAnimatedCounter(
          value: centiseconds,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
          style: centiStyle,
          prefix: '',
          suffix: '',
          fractionDigits: 0,
          padding: 2,
        ),
      ],
    );
  }
}
