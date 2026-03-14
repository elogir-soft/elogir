/// Animation timing tokens.
class ElogirDurations {
  const ElogirDurations({
    this.fast = const Duration(milliseconds: 100),
    this.normal = const Duration(milliseconds: 200),
    this.slow = const Duration(milliseconds: 300),
    this.xSlow = const Duration(milliseconds: 500),
  });

  final Duration fast;
  final Duration normal;
  final Duration slow;
  final Duration xSlow;

  ElogirDurations copyWith({
    Duration? fast,
    Duration? normal,
    Duration? slow,
    Duration? xSlow,
  }) {
    return ElogirDurations(
      fast: fast ?? this.fast,
      normal: normal ?? this.normal,
      slow: slow ?? this.slow,
      xSlow: xSlow ?? this.xSlow,
    );
  }
}
