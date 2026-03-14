import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// A single radio option value/label pair.
class ElogirRadioOption<T> {
  const ElogirRadioOption({
    required this.value,
    required this.label,
    this.enabled = true,
  });

  final T value;
  final Widget label;
  final bool enabled;
}

/// Orientation for the radio group layout.
enum ElogirRadioGroupOrientation { vertical, horizontal }

/// A group of custom-drawn radio buttons with animated selection.
///
/// Soft Industrial style: thick outer ring, filled inner circle on selection.
class ElogirRadioGroup<T> extends StatelessWidget {
  const ElogirRadioGroup({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.orientation = ElogirRadioGroupOrientation.vertical,
    this.spacing,
    this.radioSize = 22.0,
  });

  final List<ElogirRadioOption<T>> options;
  final T? value;
  final ValueChanged<T>? onChanged;
  final ElogirRadioGroupOrientation orientation;
  final double? spacing;
  final double radioSize;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final gap = spacing ?? theme.spacing.sm;

    final children = <Widget>[
      for (int i = 0; i < options.length; i++) ...[
        if (i > 0)
          orientation == ElogirRadioGroupOrientation.vertical
              ? SizedBox(height: gap)
              : SizedBox(width: gap),
        _ElogirRadioItem<T>(
          option: options[i],
          selected: value == options[i].value,
          onChanged: onChanged,
          size: radioSize,
        ),
      ],
    ];

    if (orientation == ElogirRadioGroupOrientation.vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class _ElogirRadioItem<T> extends StatefulWidget {
  const _ElogirRadioItem({
    required this.option,
    required this.selected,
    required this.onChanged,
    required this.size,
  });

  final ElogirRadioOption<T> option;
  final bool selected;
  final ValueChanged<T>? onChanged;
  final double size;

  @override
  State<_ElogirRadioItem<T>> createState() => _ElogirRadioItemState<T>();
}

class _ElogirRadioItemState<T> extends State<_ElogirRadioItem<T>>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
      value: widget.selected ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(_ElogirRadioItem<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      if (widget.selected) {
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
    final enabled = widget.option.enabled && widget.onChanged != null;

    final radio = AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return CustomPaint(
          size: Size.square(widget.size),
          painter: _RadioPainter(
            progress: _animation.value,
            borderColor: enabled
                ? (_hovered || widget.selected ? colors.primary : colors.outline)
                : colors.disabled,
            fillColor: colors.primary,
            strokeWidth: theme.strokes.thick,
          ),
        );
      },
    );

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: widget.selected,
      enabled: enabled,
      child: ElogirPressable(
        enabled: enabled,
        onPressed: enabled
            ? () => widget.onChanged?.call(widget.option.value)
            : null,
        onHoverChanged: (v) => setState(() => _hovered = v),
        pressScale: 0.95,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            radio,
            SizedBox(width: theme.spacing.sm),
            DefaultTextStyle.merge(
              style: theme.typography.bodyMedium.copyWith(
                color: enabled ? colors.onBackground : colors.onDisabled,
              ),
              child: widget.option.label,
            ),
          ],
        ),
      ),
    );
  }
}

/// Draws a radio circle: thick outer ring + animated inner dot.
class _RadioPainter extends CustomPainter {
  _RadioPainter({
    required this.progress,
    required this.borderColor,
    required this.fillColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color borderColor;
  final Color fillColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outerRadius = (size.width - strokeWidth) / 2;

    // Outer ring
    final borderPaint = Paint()
      ..color = progress > 0 ? fillColor : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, outerRadius, borderPaint);

    // Inner dot (animated)
    if (progress > 0) {
      final innerRadius = outerRadius * 0.45 * progress;
      final dotPaint = Paint()..color = fillColor;
      canvas.drawCircle(center, innerRadius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_RadioPainter old) =>
      progress != old.progress ||
      borderColor != old.borderColor ||
      fillColor != old.fillColor;
}
