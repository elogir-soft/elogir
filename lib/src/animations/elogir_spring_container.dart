import 'package:flutter/widgets.dart';

import 'curves.dart';

/// A container that animates decoration and size changes with a spring curve.
///
/// Drop-in replacement for [AnimatedContainer] with physics-tuned defaults.
///
/// ```dart
/// ElogirSpringContainer(
///   width: _expanded ? 300 : 100,
///   decoration: BoxDecoration(
///     color: _active ? colors.primary : colors.surface,
///   ),
///   child: content,
/// )
/// ```
class ElogirSpringContainer extends StatelessWidget {
  const ElogirSpringContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
    this.constraints,
    this.clipBehavior = Clip.none,
    this.duration = const Duration(milliseconds: 400),
    this.curve = ElogirCurves.spring,
  });

  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final Clip clipBehavior;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      curve: curve,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration,
      alignment: alignment,
      constraints: constraints,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}
