import 'dart:ui' show ImageFilter;
import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A container with glassmorphism effect (BackdropFilter blur).
///
/// Soft Industrial style: Subtle blur, translucent background, and
/// themed border.
class ElogirGlass extends StatelessWidget {
  const ElogirGlass({
    super.key,
    required this.child,
    this.blur = 12.0,
    this.opacity = 0.8,
    this.borderRadius,
    this.border,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    final effectiveRadius = borderRadius ?? theme.radii.lg;
    final effectiveBorder = border ??
        Border.all(
          color: colors.outlineVariant,
          width: theme.strokes.thick,
        );

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: (backgroundColor ?? colors.surface).withOpacity(opacity),
              borderRadius: effectiveRadius,
              border: effectiveBorder,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
