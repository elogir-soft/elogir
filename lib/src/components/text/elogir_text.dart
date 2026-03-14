import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../../theme/typography.dart';

/// Named text style variants that map to [ElogirTypography] fields.
enum ElogirTextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
  caption,
}

/// Themed text widget.
///
/// Selects a style from the theme's [ElogirTypography] via [variant],
/// and optionally merges a per-instance [style] override on top.
class ElogirText extends StatelessWidget {
  const ElogirText(
    this.data, {
    super.key,
    this.variant = ElogirTextVariant.bodyMedium,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.semanticsLabel,
  });

  final String data;
  final ElogirTextVariant variant;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final String? semanticsLabel;

  TextStyle _resolveVariant(ElogirTypography t) {
    switch (variant) {
      case ElogirTextVariant.displayLarge:
        return t.displayLarge;
      case ElogirTextVariant.displayMedium:
        return t.displayMedium;
      case ElogirTextVariant.displaySmall:
        return t.displaySmall;
      case ElogirTextVariant.headlineLarge:
        return t.headlineLarge;
      case ElogirTextVariant.headlineMedium:
        return t.headlineMedium;
      case ElogirTextVariant.headlineSmall:
        return t.headlineSmall;
      case ElogirTextVariant.titleLarge:
        return t.titleLarge;
      case ElogirTextVariant.titleMedium:
        return t.titleMedium;
      case ElogirTextVariant.titleSmall:
        return t.titleSmall;
      case ElogirTextVariant.bodyLarge:
        return t.bodyLarge;
      case ElogirTextVariant.bodyMedium:
        return t.bodyMedium;
      case ElogirTextVariant.bodySmall:
        return t.bodySmall;
      case ElogirTextVariant.labelLarge:
        return t.labelLarge;
      case ElogirTextVariant.labelMedium:
        return t.labelMedium;
      case ElogirTextVariant.labelSmall:
        return t.labelSmall;
      case ElogirTextVariant.caption:
        return t.caption;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final baseStyle = _resolveVariant(theme.typography);
    final mergedStyle = style != null ? baseStyle.merge(style) : baseStyle;
    final effectiveStyle = mergedStyle.color != null
        ? mergedStyle
        : mergedStyle.copyWith(color: theme.colors.onBackground);

    Widget text = Text(
      data,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );

    if (semanticsLabel != null) {
      text = Semantics(label: semanticsLabel, child: text);
    }

    return text;
  }
}
