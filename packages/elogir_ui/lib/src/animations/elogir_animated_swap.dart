import 'package:flutter/widgets.dart';

import 'curves.dart';

/// Transition style for swapping between children.
enum ElogirSwapTransition { fade, slideUp, slideDown, scale }

/// Cross-fades or slides between widget changes.
///
/// An opinionated wrapper around [AnimatedSwitcher] with
/// Soft Industrial defaults.
///
/// ```dart
/// ElogirAnimatedSwap(
///   child: _showA ? widgetA : widgetB,
/// )
/// ```
class ElogirAnimatedSwap extends StatelessWidget {
  const ElogirAnimatedSwap({
    super.key,
    required this.child,
    this.transition = ElogirSwapTransition.fade,
    this.duration = const Duration(milliseconds: 200),
    this.curve = ElogirCurves.gentle,
  });

  /// The current child widget. Must have a unique [Key] to trigger the swap.
  final Widget child;

  final ElogirSwapTransition transition;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: curve,
      switchOutCurve: curve,
      transitionBuilder: (child, animation) {
        switch (transition) {
          case ElogirSwapTransition.fade:
            return FadeTransition(opacity: animation, child: child);

          case ElogirSwapTransition.slideUp:
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.15),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );

          case ElogirSwapTransition.slideDown:
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.15),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );

          case ElogirSwapTransition.scale:
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
                child: child,
              ),
            );
        }
      },
      child: child,
    );
  }
}
