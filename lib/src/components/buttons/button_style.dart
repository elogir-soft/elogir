import 'package:flutter/widgets.dart';

/// Visual configuration for [ElogirButton].
///
/// All properties are optional — the button computes defaults from
/// its variant and size. Provide overrides only for customization.
class ElogirButtonStyle {
  const ElogirButtonStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.border,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.height,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final double? height;

  ElogirButtonStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    BoxBorder? border,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? height,
  }) {
    return ElogirButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      height: height ?? this.height,
    );
  }
}
