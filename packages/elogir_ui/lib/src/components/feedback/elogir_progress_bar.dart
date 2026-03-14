import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A progress bar with determinate or indeterminate modes.
///
/// Set [value] to a number between 0.0 and 1.0 for determinate mode,
/// or leave it null for an indeterminate animated shimmer.
class ElogirProgressBar extends StatefulWidget {
  const ElogirProgressBar({
    super.key,
    this.value,
    this.height = 8,
    this.color,
    this.trackColor,
    this.borderRadius,
    this.label,
    this.showPercentage = false,
  });

  /// Progress value between 0.0 and 1.0. Null for indeterminate.
  final double? value;
  final double height;
  final Color? color;
  final Color? trackColor;
  final BorderRadius? borderRadius;
  final Widget? label;
  final bool showPercentage;

  @override
  State<ElogirProgressBar> createState() => _ElogirProgressBarState();
}

class _ElogirProgressBarState extends State<ElogirProgressBar>
    with TickerProviderStateMixin {
  AnimationController? _indeterminateController;
  AnimationController? _shineController;

  bool get _isDeterminate => widget.value != null;

  @override
  void initState() {
    super.initState();
    if (!_isDeterminate) _startIndeterminate();
  }

  @override
  void didUpdateWidget(ElogirProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isDeterminate && _indeterminateController != null) {
      _indeterminateController!.dispose();
      _indeterminateController = null;
    } else if (!_isDeterminate && _indeterminateController == null) {
      _startIndeterminate();
    }

    // Trigger shine when value reaches 1.0
    final oldValue = oldWidget.value ?? 0.0;
    final newValue = widget.value ?? 0.0;
    if (newValue >= 1.0 && oldValue < 1.0) {
      _shineController?.dispose();
      _shineController = AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      )..forward();
    }
  }

  void _startIndeterminate() {
    _indeterminateController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _indeterminateController?.dispose();
    _shineController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final fillColor = widget.color ?? colors.primary;
    final track = widget.trackColor ?? colors.surfaceContainer;
    final radius = widget.borderRadius ?? theme.radii.full;

    Widget bar = Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: track,
        borderRadius: radius,
        border: Border.all(
          color: colors.outlineVariant,
          width: theme.strokes.thin,
        ),
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: _isDeterminate
            ? _DeterminateFill(
                value: widget.value!.clamp(0.0, 1.0),
                color: fillColor,
                duration: theme.durations.normal,
                shineAnimation: _shineController,
              )
            : AnimatedBuilder(
                animation: _indeterminateController!,
                builder: (context, _) {
                  return CustomPaint(
                    size: Size.infinite,
                    painter: _IndeterminatePainter(
                      progress: _indeterminateController!.value,
                      color: fillColor,
                    ),
                  );
                },
              ),
      ),
    );

    if (widget.label != null || widget.showPercentage) {
      bar = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null || widget.showPercentage)
            Padding(
              padding: EdgeInsets.only(bottom: theme.spacing.xs),
              child: Row(
                children: [
                  if (widget.label != null)
                    Expanded(
                      child: DefaultTextStyle.merge(
                        style: theme.typography.labelMedium.copyWith(
                          color: colors.onBackground,
                        ),
                        child: widget.label!,
                      ),
                    ),
                  if (widget.showPercentage && _isDeterminate)
                    Text(
                      '${(widget.value! * 100).round()}%',
                      style: theme.typography.labelMedium.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          bar,
        ],
      );
    }

    return bar;
  }
}

class _DeterminateFill extends StatelessWidget {
  const _DeterminateFill({
    required this.value,
    required this.color,
    required this.duration,
    this.shineAnimation,
  });

  final double value;
  final Color color;
  final Duration duration;
  final Animation<double>? shineAnimation;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedFractionallySizedBox(
        duration: duration,
        curve: Curves.easeOutCubic,
        widthFactor: value,
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: color)),
            if (shineAnimation != null)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: shineAnimation!,
                  builder: (context, _) {
                    final progress = shineAnimation!.value;
                    if (progress <= 0.0 || progress >= 1.0) {
                      return const SizedBox.shrink();
                    }
                    return _ShineOverlay(progress: progress);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ShineOverlay extends StatelessWidget {
  const _ShineOverlay({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    // The shine band is 30% of the bar width; it sweeps left to right.
    const bandWidth = 0.3;
    final center = -bandWidth + progress * (1.0 + 2 * bandWidth);

    return ClipRect(
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: 1.0,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color(0x00FFFFFF),
                Color(0x4DFFFFFF),
                Color(0x00FFFFFF),
              ],
              stops: [
                (center - bandWidth / 2).clamp(0.0, 1.0),
                center.clamp(0.0, 1.0),
                (center + bandWidth / 2).clamp(0.0, 1.0),
              ],
            ),
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _IndeterminatePainter extends CustomPainter {
  _IndeterminatePainter({required this.progress, required this.color});
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final barWidth = size.width * 0.35;
    // Slide from left to right with easing
    final t = Curves.easeInOut.transform(progress);
    final left = t * (size.width + barWidth) - barWidth;
    canvas.drawRect(
      Rect.fromLTWH(left, 0, barWidth, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(_IndeterminatePainter old) => progress != old.progress;
}
