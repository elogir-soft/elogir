import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A divider line, horizontal or vertical, with an optional label in the middle.
///
/// Soft Industrial style: uses thick strokes for visual weight.
class ElogirDivider extends StatelessWidget {
  const ElogirDivider({
    super.key,
    this.label,
    this.direction = Axis.horizontal,
    this.color,
    this.thickness,
    this.indent = 0,
    this.endIndent = 0,
  });

  final Widget? label;
  final Axis direction;
  final Color? color;
  final double? thickness;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final lineColor = color ?? theme.colors.outlineVariant;
    final lineThickness = thickness ?? theme.strokes.medium;

    if (direction == Axis.vertical) {
      return Padding(
        padding: EdgeInsets.only(top: indent, bottom: endIndent),
        child: SizedBox(
          width: lineThickness,
          child: DecoratedBox(
            decoration: BoxDecoration(color: lineColor),
            child: const SizedBox.expand(),
          ),
        ),
      );
    }

    if (label == null) {
      return Padding(
        padding: EdgeInsets.only(left: indent, right: endIndent),
        child: SizedBox(
          height: lineThickness,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(color: lineColor),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: indent, right: endIndent),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: lineThickness,
              child: DecoratedBox(
                decoration: BoxDecoration(color: lineColor),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
            child: DefaultTextStyle.merge(
              style: theme.typography.caption.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
              child: label!,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: lineThickness,
              child: DecoratedBox(
                decoration: BoxDecoration(color: lineColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
