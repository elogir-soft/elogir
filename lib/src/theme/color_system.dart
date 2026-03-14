import 'dart:ui' show Brightness, Color;

/// Raw color palette — the source colors an app provides.
///
/// Apps override these to brand their theme. Semantic colors are
/// derived from the palette so a single palette swap recolors everything.
class ElogirColorPalette {
  const ElogirColorPalette({
    this.primary50 = const Color(0xFFEEF2FF),
    this.primary100 = const Color(0xFFE0E7FF),
    this.primary200 = const Color(0xFFC7D2FE),
    this.primary300 = const Color(0xFFA5B4FC),
    this.primary400 = const Color(0xFF818CF8),
    this.primary500 = const Color(0xFF6366F1),
    this.primary600 = const Color(0xFF4F46E5),
    this.primary700 = const Color(0xFF4338CA),
    this.primary800 = const Color(0xFF3730A3),
    this.primary900 = const Color(0xFF312E81),
    this.neutral50 = const Color(0xFFFAF9F7),
    this.neutral100 = const Color(0xFFF4F3F0),
    this.neutral200 = const Color(0xFFE8E6E1),
    this.neutral300 = const Color(0xFFD5D3CD),
    this.neutral400 = const Color(0xFFA8A49E),
    this.neutral500 = const Color(0xFF787470),
    this.neutral600 = const Color(0xFF565350),
    this.neutral700 = const Color(0xFF3D3B38),
    this.neutral800 = const Color(0xFF282624),
    this.neutral900 = const Color(0xFF1A1917),
    this.error50 = const Color(0xFFFEF2F2),
    this.error400 = const Color(0xFFF87171),
    this.error500 = const Color(0xFFEF4444),
    this.error600 = const Color(0xFFDC2626),
    this.success50 = const Color(0xFFF0FDF4),
    this.success400 = const Color(0xFF4ADE80),
    this.success500 = const Color(0xFF22C55E),
    this.success600 = const Color(0xFF16A34A),
    this.warning50 = const Color(0xFFFFFBEB),
    this.warning400 = const Color(0xFFFBBF24),
    this.warning500 = const Color(0xFFF59E0B),
    this.warning600 = const Color(0xFFD97706),
    this.white = const Color(0xFFFFFFFF),
    this.black = const Color(0xFF000000),
  });

  // Primary
  final Color primary50;
  final Color primary100;
  final Color primary200;
  final Color primary300;
  final Color primary400;
  final Color primary500;
  final Color primary600;
  final Color primary700;
  final Color primary800;
  final Color primary900;

  // Neutral
  final Color neutral50;
  final Color neutral100;
  final Color neutral200;
  final Color neutral300;
  final Color neutral400;
  final Color neutral500;
  final Color neutral600;
  final Color neutral700;
  final Color neutral800;
  final Color neutral900;

  // Error
  final Color error50;
  final Color error400;
  final Color error500;
  final Color error600;

  // Success
  final Color success50;
  final Color success400;
  final Color success500;
  final Color success600;

  // Warning
  final Color warning50;
  final Color warning400;
  final Color warning500;
  final Color warning600;

  // Base
  final Color white;
  final Color black;

  ElogirColorPalette copyWith({
    Color? primary50,
    Color? primary100,
    Color? primary200,
    Color? primary300,
    Color? primary400,
    Color? primary500,
    Color? primary600,
    Color? primary700,
    Color? primary800,
    Color? primary900,
    Color? neutral50,
    Color? neutral100,
    Color? neutral200,
    Color? neutral300,
    Color? neutral400,
    Color? neutral500,
    Color? neutral600,
    Color? neutral700,
    Color? neutral800,
    Color? neutral900,
    Color? error50,
    Color? error400,
    Color? error500,
    Color? error600,
    Color? success50,
    Color? success400,
    Color? success500,
    Color? success600,
    Color? warning50,
    Color? warning400,
    Color? warning500,
    Color? warning600,
    Color? white,
    Color? black,
  }) {
    return ElogirColorPalette(
      primary50: primary50 ?? this.primary50,
      primary100: primary100 ?? this.primary100,
      primary200: primary200 ?? this.primary200,
      primary300: primary300 ?? this.primary300,
      primary400: primary400 ?? this.primary400,
      primary500: primary500 ?? this.primary500,
      primary600: primary600 ?? this.primary600,
      primary700: primary700 ?? this.primary700,
      primary800: primary800 ?? this.primary800,
      primary900: primary900 ?? this.primary900,
      neutral50: neutral50 ?? this.neutral50,
      neutral100: neutral100 ?? this.neutral100,
      neutral200: neutral200 ?? this.neutral200,
      neutral300: neutral300 ?? this.neutral300,
      neutral400: neutral400 ?? this.neutral400,
      neutral500: neutral500 ?? this.neutral500,
      neutral600: neutral600 ?? this.neutral600,
      neutral700: neutral700 ?? this.neutral700,
      neutral800: neutral800 ?? this.neutral800,
      neutral900: neutral900 ?? this.neutral900,
      error50: error50 ?? this.error50,
      error400: error400 ?? this.error400,
      error500: error500 ?? this.error500,
      error600: error600 ?? this.error600,
      success50: success50 ?? this.success50,
      success400: success400 ?? this.success400,
      success500: success500 ?? this.success500,
      success600: success600 ?? this.success600,
      warning50: warning50 ?? this.warning50,
      warning400: warning400 ?? this.warning400,
      warning500: warning500 ?? this.warning500,
      warning600: warning600 ?? this.warning600,
      white: white ?? this.white,
      black: black ?? this.black,
    );
  }
}

/// Semantic colors derived from [ElogirColorPalette].
///
/// These are the colors widgets actually consume. The mapping from
/// palette → semantic changes between light and dark brightness.
class ElogirColors {
  const ElogirColors({
    required this.palette,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.surface,
    required this.onSurface,
    required this.surfaceContainer,
    required this.onSurfaceVariant,
    required this.background,
    required this.onBackground,
    required this.error,
    required this.onError,
    required this.success,
    required this.warning,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.disabled,
    required this.onDisabled,
  });

  /// Creates semantic colors for light mode from the given [palette].
  factory ElogirColors.light({ElogirColorPalette palette = const ElogirColorPalette()}) {
    return ElogirColors(
      palette: palette,
      primary: palette.primary600,
      onPrimary: palette.white,
      primaryContainer: palette.primary100,
      onPrimaryContainer: palette.primary800,
      surface: palette.white,
      onSurface: palette.neutral900,
      surfaceContainer: palette.neutral100,
      onSurfaceVariant: palette.neutral600,
      background: palette.neutral50,
      onBackground: palette.neutral900,
      error: palette.error500,
      onError: palette.white,
      success: palette.success500,
      warning: palette.warning500,
      outline: palette.neutral400,
      outlineVariant: palette.neutral300,
      shadow: palette.black,
      disabled: palette.neutral200,
      onDisabled: palette.neutral400,
    );
  }

  /// Creates semantic colors for dark mode from the given [palette].
  factory ElogirColors.dark({ElogirColorPalette palette = const ElogirColorPalette()}) {
    return ElogirColors(
      palette: palette,
      primary: palette.primary400,
      onPrimary: palette.primary900,
      primaryContainer: palette.primary800,
      onPrimaryContainer: palette.primary200,
      surface: palette.neutral800,
      onSurface: palette.neutral100,
      surfaceContainer: palette.neutral700,
      onSurfaceVariant: palette.neutral400,
      background: palette.neutral900,
      onBackground: palette.neutral100,
      error: palette.error400,
      onError: palette.error50,
      success: palette.success400,
      warning: palette.warning400,
      outline: palette.neutral500,
      outlineVariant: palette.neutral600,
      shadow: palette.black,
      disabled: palette.neutral700,
      onDisabled: palette.neutral500,
    );
  }

  /// Convenience factory — picks light or dark based on [brightness].
  factory ElogirColors.fromPalette({
    ElogirColorPalette palette = const ElogirColorPalette(),
    required Brightness brightness,
  }) {
    return brightness == Brightness.light
        ? ElogirColors.light(palette: palette)
        : ElogirColors.dark(palette: palette);
  }

  final ElogirColorPalette palette;

  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;

  final Color surface;
  final Color onSurface;
  final Color surfaceContainer;
  final Color onSurfaceVariant;

  final Color background;
  final Color onBackground;

  final Color error;
  final Color onError;
  final Color success;
  final Color warning;

  final Color outline;
  final Color outlineVariant;
  final Color shadow;

  final Color disabled;
  final Color onDisabled;

  ElogirColors copyWith({
    ElogirColorPalette? palette,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? surface,
    Color? onSurface,
    Color? surfaceContainer,
    Color? onSurfaceVariant,
    Color? background,
    Color? onBackground,
    Color? error,
    Color? onError,
    Color? success,
    Color? warning,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? disabled,
    Color? onDisabled,
  }) {
    return ElogirColors(
      palette: palette ?? this.palette,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      shadow: shadow ?? this.shadow,
      disabled: disabled ?? this.disabled,
      onDisabled: onDisabled ?? this.onDisabled,
    );
  }
}
