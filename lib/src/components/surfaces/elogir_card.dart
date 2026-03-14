import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A surface container with rounded corners and thick border.
///
/// In the Soft Industrial style, cards use borders for depth
/// instead of heavy shadows.
class ElogirCard extends StatelessWidget {
  const ElogirCard({
    super.key,
    this.child,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.shadow,
    this.padding,
    this.margin,
    this.semanticsLabel,
  });

  final Widget? child;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    Widget card = Container(
      margin: margin,
      padding: padding ?? EdgeInsets.all(theme.spacing.md),
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colors.surface,
        borderRadius: borderRadius ?? theme.radii.lg,
        border: border ??
            Border.all(
              color: theme.colors.outlineVariant,
              width: theme.strokes.medium,
            ),
        boxShadow: shadow ?? theme.shadows.none,
      ),
      child: child,
    );

    if (semanticsLabel != null) {
      card = Semantics(label: semanticsLabel, container: true, child: card);
    }

    return card;
  }
}
