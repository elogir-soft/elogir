/// Base class for consumer-defined theme extensions.
///
/// Apps can subclass this to attach arbitrary tokens to the theme:
///
/// ```dart
/// class BrandTokens extends ElogirThemeExtension<BrandTokens> {
///   const BrandTokens({required this.accentGradient});
///   final LinearGradient accentGradient;
///
///   @override
///   BrandTokens copyWith({LinearGradient? accentGradient}) =>
///       BrandTokens(accentGradient: accentGradient ?? this.accentGradient);
/// }
/// ```
///
/// Then retrieve it via `ElogirTheme.of(context).extension<BrandTokens>()`.
abstract class ElogirThemeExtension<T extends ElogirThemeExtension<T>> {
  const ElogirThemeExtension();

  T copyWith();
}
