/// Border width tokens for the Soft Industrial style.
///
/// Borders are the primary depth mechanism in this design system.
/// Strokes provide consistent border widths across all widgets.
class ElogirStrokes {
  const ElogirStrokes({
    this.thin = 1.0,
    this.medium = 1.5,
    this.thick = 2.0,
  });

  final double thin;
  final double medium;
  final double thick;

  ElogirStrokes copyWith({
    double? thin,
    double? medium,
    double? thick,
  }) {
    return ElogirStrokes(
      thin: thin ?? this.thin,
      medium: medium ?? this.medium,
      thick: thick ?? this.thick,
    );
  }
}
