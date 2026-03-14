import 'package:flutter/widgets.dart';

/// Elevation / shadow tokens.
///
/// In the Soft Industrial style, shadows are very subtle. Depth is
/// primarily communicated through borders and layering, not elevation.
class ElogirShadows {
  const ElogirShadows({
    this.none = const [],
    this.sm = const [
      BoxShadow(
        color: Color(0x0A000000),
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
    this.md = const [
      BoxShadow(
        color: Color(0x0F000000),
        blurRadius: 4,
        offset: Offset(0, 1),
      ),
    ],
    this.lg = const [
      BoxShadow(
        color: Color(0x0F000000),
        blurRadius: 8,
        offset: Offset(0, 2),
      ),
    ],
    this.xl = const [
      BoxShadow(
        color: Color(0x14000000),
        blurRadius: 16,
        offset: Offset(0, 4),
      ),
    ],
  });

  final List<BoxShadow> none;
  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;
  final List<BoxShadow> xl;

  ElogirShadows copyWith({
    List<BoxShadow>? none,
    List<BoxShadow>? sm,
    List<BoxShadow>? md,
    List<BoxShadow>? lg,
    List<BoxShadow>? xl,
  }) {
    return ElogirShadows(
      none: none ?? this.none,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }
}
