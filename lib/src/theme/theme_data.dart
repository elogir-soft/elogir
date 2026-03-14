import 'dart:ui' show Brightness;

import 'color_system.dart';
import 'durations.dart';
import 'radii.dart';
import 'shadows.dart';
import 'spacing.dart';
import 'strokes.dart';
import 'theme_extension.dart';
import 'typography.dart';

/// Immutable bundle of all design tokens.
///
/// Consumer apps create an instance (or use the [light] / [dark] factories)
/// and hand it to [ElogirTheme] at the top of their widget tree.
class ElogirThemeData {
  const ElogirThemeData({
    required this.brightness,
    required this.colors,
    required this.typography,
    this.spacing = const ElogirSpacing(),
    this.radii = const ElogirRadii(),
    this.shadows = const ElogirShadows(),
    this.strokes = const ElogirStrokes(),
    this.durations = const ElogirDurations(),
    this.extensions = const {},
  });

  /// Sensible light-mode defaults.
  factory ElogirThemeData.light({
    ElogirColorPalette palette = const ElogirColorPalette(),
    ElogirTypography? typography,
  }) {
    return ElogirThemeData(
      brightness: Brightness.light,
      colors: ElogirColors.light(palette: palette),
      typography: typography ?? ElogirTypography.standard(),
    );
  }

  /// Sensible dark-mode defaults.
  factory ElogirThemeData.dark({
    ElogirColorPalette palette = const ElogirColorPalette(),
    ElogirTypography? typography,
  }) {
    return ElogirThemeData(
      brightness: Brightness.dark,
      colors: ElogirColors.dark(palette: palette),
      typography: typography ?? ElogirTypography.standard(),
    );
  }

  final Brightness brightness;
  final ElogirColors colors;
  final ElogirTypography typography;
  final ElogirSpacing spacing;
  final ElogirRadii radii;
  final ElogirShadows shadows;
  final ElogirStrokes strokes;
  final ElogirDurations durations;

  /// Consumer-provided theme extensions keyed by their runtime type.
  final Map<Type, ElogirThemeExtension> extensions;

  /// Retrieves a previously registered extension of type [T].
  T? extension<T extends ElogirThemeExtension<T>>() => extensions[T] as T?;

  ElogirThemeData copyWith({
    Brightness? brightness,
    ElogirColors? colors,
    ElogirTypography? typography,
    ElogirSpacing? spacing,
    ElogirRadii? radii,
    ElogirShadows? shadows,
    ElogirStrokes? strokes,
    ElogirDurations? durations,
    Map<Type, ElogirThemeExtension>? extensions,
  }) {
    return ElogirThemeData(
      brightness: brightness ?? this.brightness,
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      radii: radii ?? this.radii,
      shadows: shadows ?? this.shadows,
      strokes: strokes ?? this.strokes,
      durations: durations ?? this.durations,
      extensions: extensions ?? this.extensions,
    );
  }
}
