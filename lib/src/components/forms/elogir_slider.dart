import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A slider with an optional value tooltip.
///
/// Soft Industrial style: thick track with rounded ends, bold thumb
/// with thick border, smooth tooltip that appears on drag.
class ElogirSlider extends StatefulWidget {
  const ElogirSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.showTooltip = true,
    this.enabled = true,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;

  /// Number of discrete divisions. If null, the slider is continuous.
  final int? divisions;

  /// Format function for the tooltip label.
  /// If null and [showTooltip] is true, displays the value rounded to 1 decimal.
  final String Function(double value)? label;
  final bool showTooltip;
  final bool enabled;

  @override
  State<ElogirSlider> createState() => _ElogirSliderState();
}

class _ElogirSliderState extends State<ElogirSlider>
    with SingleTickerProviderStateMixin {
  late final AnimationController _tooltipController;
  bool _dragging = false;

  static const _trackHeight = 6.0;
  static const _thumbSize = 22.0;
  static const _totalHeight = 44.0;

  double get _fraction =>
      ((widget.value - widget.min) / (widget.max - widget.min))
          .clamp(0.0, 1.0);

  @override
  void initState() {
    super.initState();
    _tooltipController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tooltipController.dispose();
    super.dispose();
  }

  void _updateValue(double localX, double trackWidth) {
    if (!_effectiveEnabled) return;
    var fraction = (localX / trackWidth).clamp(0.0, 1.0);

    if (widget.divisions != null && widget.divisions! > 0) {
      fraction = (fraction * widget.divisions!).round() / widget.divisions!;
    }

    final newValue = widget.min + fraction * (widget.max - widget.min);
    widget.onChanged?.call(newValue);
  }

  bool get _effectiveEnabled => widget.enabled && widget.onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final enabled = _effectiveEnabled;

    return Semantics(
      slider: true,
      value: widget.label?.call(widget.value) ??
          widget.value.toStringAsFixed(1),
      enabled: enabled,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final trackWidth = constraints.maxWidth;
          final thumbLeft = (_fraction * trackWidth) - _thumbSize / 2;
          final trackTop = (_totalHeight - _trackHeight) / 2;
          final thumbTop = (_totalHeight - _thumbSize) / 2;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: enabled
                ? (details) {
                    setState(() => _dragging = true);
                    _tooltipController.forward();
                    _updateValue(details.localPosition.dx, trackWidth);
                  }
                : null,
            onHorizontalDragUpdate: enabled
                ? (details) {
                    _updateValue(details.localPosition.dx, trackWidth);
                  }
                : null,
            onHorizontalDragEnd: enabled
                ? (_) {
                    setState(() => _dragging = false);
                    _tooltipController.reverse();
                  }
                : null,
            onTapDown: enabled
                ? (details) {
                    _updateValue(details.localPosition.dx, trackWidth);
                    _tooltipController.forward();
                  }
                : null,
            onTapUp: enabled
                ? (_) {
                    _tooltipController.reverse();
                  }
                : null,
            child: SizedBox(
              height: _totalHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Track background
                  Positioned(
                    left: 0,
                    right: 0,
                    top: trackTop,
                    height: _trackHeight,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: enabled
                            ? colors.outlineVariant
                            : colors.disabled,
                        borderRadius: theme.radii.full,
                      ),
                    ),
                  ),
                  // Active track
                  Positioned(
                    left: 0,
                    top: trackTop,
                    height: _trackHeight,
                    width: trackWidth * _fraction,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: enabled ? colors.primary : colors.onDisabled,
                        borderRadius: theme.radii.full,
                      ),
                    ),
                  ),
                  // Division marks
                  if (widget.divisions != null && widget.divisions! > 0)
                    Positioned(
                      left: 0,
                      right: 0,
                      top: trackTop,
                      height: _trackHeight,
                      child: CustomPaint(
                        painter: _DivisionPainter(
                          divisions: widget.divisions!,
                          color: colors.surface.withValues(alpha: 0.6),
                          trackHeight: _trackHeight,
                        ),
                      ),
                    ),
                  // Tooltip — positioned above the thumb via negative top
                  if (widget.showTooltip)
                    Positioned(
                      left: thumbLeft + _thumbSize / 2,
                      top: thumbTop - 8,
                      child: FractionalTranslation(
                        translation: const Offset(-0.5, -1.0),
                        child: FadeTransition(
                          opacity: CurvedAnimation(
                            parent: _tooltipController,
                            curve: Curves.easeOut,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: theme.spacing.sm,
                              vertical: theme.spacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: colors.onSurface,
                              borderRadius: theme.radii.sm,
                            ),
                            child: Text(
                              widget.label?.call(widget.value) ??
                                  widget.value.toStringAsFixed(1),
                              style: theme.typography.labelSmall.copyWith(
                                color: colors.surface,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Thumb circle
                  Positioned(
                    left: thumbLeft,
                    top: thumbTop,
                    width: _thumbSize,
                    height: _thumbSize,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: enabled ? colors.surface : colors.disabled,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: enabled
                              ? colors.primary
                              : colors.onDisabled,
                          width: _dragging
                              ? theme.strokes.thick + 1
                              : theme.strokes.thick,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DivisionPainter extends CustomPainter {
  _DivisionPainter({
    required this.divisions,
    required this.color,
    required this.trackHeight,
  });

  final int divisions;
  final Color color;
  final double trackHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (int i = 1; i < divisions; i++) {
      final x = (i / divisions) * size.width;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, trackHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DivisionPainter old) =>
      divisions != old.divisions || color != old.color;
}
