import 'package:flutter/widgets.dart';

/// Transition types for page navigation.
enum ElogirTransitionType {
  /// Simple fade in/out.
  fade,

  /// Slide in from right, slide out to right.
  slideRight,

  /// Slide up from bottom.
  slideUp,

  /// Scale from 0 to 1.
  scale,

  /// Fade + subtle scale (0.95 → 1.0). The default Soft Industrial style.
  fadeScale,
}

/// A custom page route with configurable transition animations.
///
/// Soft Industrial style: smooth, measured transitions with no bounce
/// or overshoot. The default [ElogirTransitionType.fadeScale] gives a
/// subtle scale + fade that feels grounded.
///
/// ```dart
/// Navigator.of(context).push(
///   ElogirPageTransition(
///     page: DetailPage(),
///     type: ElogirTransitionType.slideRight,
///   ),
/// );
/// ```
class ElogirPageTransition<T> extends PageRouteBuilder<T> {
  ElogirPageTransition({
    required Widget page,
    ElogirTransitionType type = ElogirTransitionType.fadeScale,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 250),
    Curve curve = Curves.easeOutCubic,
    Curve reverseCurve = Curves.easeInCubic,
    super.opaque,
    super.fullscreenDialog,
    super.settings,
  }) : super(
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          pageBuilder: (_, a, b) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );

            switch (type) {
              case ElogirTransitionType.fade:
                return FadeTransition(opacity: curved, child: child);

              case ElogirTransitionType.slideRight:
                return SlideTransition(
                  position: Tween(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(curved),
                  child: child,
                );

              case ElogirTransitionType.slideUp:
                return SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(curved),
                  child: child,
                );

              case ElogirTransitionType.scale:
                return ScaleTransition(scale: curved, child: child);

              case ElogirTransitionType.fadeScale:
                return FadeTransition(
                  opacity: curved,
                  child: ScaleTransition(
                    scale: Tween(begin: 0.95, end: 1.0).animate(curved),
                    child: child,
                  ),
                );
            }
          },
        );
}
