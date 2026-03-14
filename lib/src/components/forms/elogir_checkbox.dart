import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// A custom-drawn checkbox with animated check mark.
///
/// Thick-bordered Soft Industrial style with a smooth check animation.
class ElogirCheckbox extends StatefulWidget {
  const ElogirCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.size = 22.0,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? label;
  final bool enabled;
  final double size;

  @override
  State<ElogirCheckbox> createState() => _ElogirCheckboxState();
}

class _ElogirCheckboxState extends State<ElogirCheckbox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(ElogirCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animation.forward();
      } else {
        _animation.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final enabled = widget.enabled && widget.onChanged != null;

    final box = AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final t = _animation.value;
        return CustomPaint(
          size: Size.square(widget.size),
          painter: _CheckboxPainter(
            progress: t,
            checked: widget.value,
            borderColor: enabled
                ? (_hovered ? colors.primary : colors.outline)
                : colors.disabled,
            fillColor: colors.primary,
            checkColor: colors.onPrimary,
            strokeWidth: theme.strokes.thick,
            borderRadius: 4.0,
          ),
        );
      },
    );

    final content = widget.label != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              box,
              SizedBox(width: theme.spacing.sm),
              DefaultTextStyle.merge(
                style: theme.typography.bodyMedium.copyWith(
                  color: enabled ? colors.onBackground : colors.onDisabled,
                ),
                child: widget.label!,
              ),
            ],
          )
        : box;

    return Semantics(
      checked: widget.value,
      enabled: enabled,
      child: ElogirPressable(
        enabled: enabled,
        onPressed: enabled ? () => widget.onChanged?.call(!widget.value) : null,
        onHoverChanged: (v) => setState(() => _hovered = v),
        pressScale: 0.95,
        child: content,
      ),
    );
  }
}

class _CheckboxPainter extends CustomPainter {
  _CheckboxPainter({
    required this.progress,
    required this.checked,
    required this.borderColor,
    required this.fillColor,
    required this.checkColor,
    required this.strokeWidth,
    required this.borderRadius,
  });

  final double progress;
  final bool checked;
  final Color borderColor;
  final Color fillColor;
  final Color checkColor;
  final double strokeWidth;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final insetRect = rect.deflate(strokeWidth / 2);
    final insetRRect =
        RRect.fromRectAndRadius(insetRect, Radius.circular(borderRadius));

    // Background fill (animated)
    if (progress > 0) {
      final fillPaint = Paint()..color = fillColor;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: rect.center,
            width: size.width * progress,
            height: size.height * progress,
          ),
          Radius.circular(borderRadius),
        ),
        fillPaint,
      );
    }

    // Border
    final borderPaint = Paint()
      ..color = progress > 0 ? fillColor : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawRRect(insetRRect, borderPaint);

    // Check mark
    if (progress > 0.3) {
      final checkProgress = ((progress - 0.3) / 0.7).clamp(0.0, 1.0);
      final checkPaint = Paint()
        ..color = checkColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final path = Path();
      final cx = size.width / 2;
      final cy = size.height / 2;
      final unit = size.width * 0.15;

      // First leg of check
      final p1 = Offset(cx - unit * 1.2, cy);
      final p2 = Offset(cx - unit * 0.2, cy + unit);
      // Second leg
      final p3 = Offset(cx + unit * 1.5, cy - unit * 1.2);

      if (checkProgress <= 0.5) {
        final t = checkProgress / 0.5;
        path.moveTo(p1.dx, p1.dy);
        path.lineTo(
          p1.dx + (p2.dx - p1.dx) * t,
          p1.dy + (p2.dy - p1.dy) * t,
        );
      } else {
        final t = (checkProgress - 0.5) / 0.5;
        path.moveTo(p1.dx, p1.dy);
        path.lineTo(p2.dx, p2.dy);
        path.lineTo(
          p2.dx + (p3.dx - p2.dx) * t,
          p2.dy + (p3.dy - p2.dy) * t,
        );
      }

      canvas.drawPath(path, checkPaint);
    }
  }

  @override
  bool shouldRepaint(_CheckboxPainter old) =>
      progress != old.progress ||
      borderColor != old.borderColor ||
      fillColor != old.fillColor;
}
