import 'package:flutter/widgets.dart';

/// Custom easing curves tuned for the Soft Industrial design system.
///
/// These curves complement the theme duration tokens. Pair them
/// together for consistent motion across the library:
///
/// ```dart
/// AnimatedContainer(
///   duration: theme.durations.normal,
///   curve: ElogirCurves.snappy,
///   // ...
/// )
/// ```
class ElogirCurves {
  ElogirCurves._();

  /// Fast start, firm stop — the main interaction curve.
  ///
  /// Use for button presses, toggles, and direct responses to user input.
  static const Curve snappy = Cubic(0.2, 0, 0, 1);

  /// Slow ease-in-out for ambient or background motion.
  ///
  /// Use for color transitions, background shifts, and subtle state changes.
  static const Curve gentle = Cubic(0.4, 0, 0.2, 1);

  /// Light overshoot for playful feedback.
  ///
  /// Use sparingly for confirmations (checkmarks, badge pops, success states).
  static const Curve spring = Cubic(0.175, 0.885, 0.32, 1.275);

  /// Fast entry, long settle — overlays appearing.
  ///
  /// Use for dropdowns, tooltips, popovers, and other surfaces entering view.
  static const Curve decelerate = Cubic(0, 0, 0.2, 1);
}
