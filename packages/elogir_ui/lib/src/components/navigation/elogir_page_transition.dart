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
///
/// For declarative routing (go_router), use [ElogirPage] instead.
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

/// A [Page] with configurable Soft Industrial transitions.
///
/// Use this with declarative routers like `go_router`:
///
/// ```dart
/// GoRoute(
///   path: '/detail',
///   pageBuilder: (context, state) => ElogirPage(
///     key: state.pageKey,
///     child: DetailScreen(),
///     type: ElogirTransitionType.slideRight,
///   ),
/// )
/// ```
class ElogirPage<T> extends Page<T> {
  const ElogirPage({
    required this.child,
    this.type = ElogirTransitionType.fadeScale,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 250),
    this.curve = Curves.easeOutCubic,
    this.reverseCurve = Curves.easeInCubic,
    this.opaque = true,
    this.fullscreenDialog = false,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;
  final ElogirTransitionType type;
  final Duration duration;
  final Duration reverseDuration;
  final Curve curve;
  final Curve reverseCurve;
  final bool opaque;
  final bool fullscreenDialog;

  @override
  Route<T> createRoute(BuildContext context) {
    return _ElogirPageRoute<T>(page: this);
  }
}

class _ElogirPageRoute<T> extends PageRoute<T> {
  _ElogirPageRoute({required ElogirPage<T> page}) : super(settings: page);

  ElogirPage<T> get _page => settings as ElogirPage<T>;

  @override
  bool get opaque => _page.opaque;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  Duration get transitionDuration => _page.duration;

  @override
  Duration get reverseTransitionDuration => _page.reverseDuration;

  @override
  bool get maintainState => true;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return _page.child;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: _page.curve,
      reverseCurve: _page.reverseCurve,
    );

    switch (_page.type) {
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
  }
}
