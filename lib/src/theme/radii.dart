import 'package:flutter/widgets.dart';

/// Border radius tokens.
class ElogirRadii {
  const ElogirRadii({
    this.xs = const BorderRadius.all(Radius.circular(2)),
    this.sm = const BorderRadius.all(Radius.circular(4)),
    this.md = const BorderRadius.all(Radius.circular(8)),
    this.lg = const BorderRadius.all(Radius.circular(12)),
    this.xl = const BorderRadius.all(Radius.circular(16)),
    this.full = const BorderRadius.all(Radius.circular(9999)),
  });

  final BorderRadius xs;
  final BorderRadius sm;
  final BorderRadius md;
  final BorderRadius lg;
  final BorderRadius xl;
  final BorderRadius full;

  ElogirRadii copyWith({
    BorderRadius? xs,
    BorderRadius? sm,
    BorderRadius? md,
    BorderRadius? lg,
    BorderRadius? xl,
    BorderRadius? full,
  }) {
    return ElogirRadii(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      full: full ?? this.full,
    );
  }
}
