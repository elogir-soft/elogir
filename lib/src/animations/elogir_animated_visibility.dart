import 'package:flutter/widgets.dart';

import 'curves.dart';

/// Transition type for enter/exit animations.
enum ElogirVisibilityTransition { fade, slideUp, slideDown, scale, fadeScale }

/// Animates a child's entrance and exit when [visible] changes.
///
/// Unlike [AnimatedSwitcher], this is purpose-built for show/hide
/// toggling with opinionated Soft Industrial defaults.
///
/// ```dart
/// ElogirAnimatedVisibility(
///   visible: _showPanel,
///   child: ElogirCard(child: Text('Details')),
/// )
/// ```
class ElogirAnimatedVisibility extends StatefulWidget {
  const ElogirAnimatedVisibility({
    super.key,
    required this.child,
    required this.visible,
    this.transition = ElogirVisibilityTransition.fade,
    this.duration = const Duration(milliseconds: 200),
    this.reverseDuration,
    this.curve = ElogirCurves.decelerate,
    this.reverseCurve,
    this.maintainState = false,
  });

  final Widget child;
  final bool visible;
  final ElogirVisibilityTransition transition;
  final Duration duration;
  final Duration? reverseDuration;
  final Curve curve;
  final Curve? reverseCurve;

  /// If true, the child is kept in the tree (but invisible) when hidden.
  final bool maintainState;

  @override
  State<ElogirAnimatedVisibility> createState() =>
      _ElogirAnimatedVisibilityState();
}

class _ElogirAnimatedVisibilityState extends State<ElogirAnimatedVisibility>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      reverseDuration: widget.reverseDuration ?? widget.duration,
      vsync: this,
      value: widget.visible ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(ElogirAnimatedVisibility oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      if (widget.visible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_controller.isDismissed && !widget.maintainState) {
          return const SizedBox.shrink();
        }

        final curved = widget.curve.transform(_controller.value);

        Widget result = child!;

        switch (widget.transition) {
          case ElogirVisibilityTransition.fade:
            result = Opacity(opacity: curved, child: result);

          case ElogirVisibilityTransition.slideUp:
            result = Opacity(
              opacity: curved,
              child: Transform.translate(
                offset: Offset(0, 16 * (1 - curved)),
                child: result,
              ),
            );

          case ElogirVisibilityTransition.slideDown:
            result = Opacity(
              opacity: curved,
              child: Transform.translate(
                offset: Offset(0, -16 * (1 - curved)),
                child: result,
              ),
            );

          case ElogirVisibilityTransition.scale:
            result = Opacity(
              opacity: curved,
              child: Transform.scale(
                scale: 0.9 + 0.1 * curved,
                child: result,
              ),
            );

          case ElogirVisibilityTransition.fadeScale:
            result = Opacity(
              opacity: curved,
              child: Transform.scale(
                scale: 0.95 + 0.05 * curved,
                child: result,
              ),
            );
        }

        if (_controller.isDismissed && widget.maintainState) {
          return Visibility(visible: false, maintainState: true, child: result);
        }

        return result;
      },
      child: widget.child,
    );
  }
}
