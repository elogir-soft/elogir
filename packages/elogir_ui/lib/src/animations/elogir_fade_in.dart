import 'package:flutter/widgets.dart';

import 'curves.dart';

/// Direction from which the widget slides in during the fade.
enum ElogirFadeInDirection { up, down, left, right, none }

/// Fades (and optionally slides) a child into view on first build.
///
/// ```dart
/// ElogirFadeIn(
///   direction: ElogirFadeInDirection.up,
///   child: ElogirCard(child: Text('Hello')),
/// )
/// ```
class ElogirFadeIn extends StatefulWidget {
  const ElogirFadeIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.delay = Duration.zero,
    this.direction = ElogirFadeInDirection.up,
    this.offset = 20.0,
    this.curve = ElogirCurves.decelerate,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;
  final ElogirFadeInDirection direction;

  /// Distance in logical pixels to slide from.
  final double offset;
  final Curve curve;

  @override
  State<ElogirFadeIn> createState() => _ElogirFadeInState();
}

class _ElogirFadeInState extends State<ElogirFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(curved);
    _slide = Tween<Offset>(begin: _beginOffset, end: Offset.zero).animate(curved);

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  Offset get _beginOffset {
    switch (widget.direction) {
      case ElogirFadeInDirection.up:
        return Offset(0, widget.offset);
      case ElogirFadeInDirection.down:
        return Offset(0, -widget.offset);
      case ElogirFadeInDirection.left:
        return Offset(widget.offset, 0);
      case ElogirFadeInDirection.right:
        return Offset(-widget.offset, 0);
      case ElogirFadeInDirection.none:
        return Offset.zero;
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
        return Transform.translate(
          offset: _slide.value,
          child: Opacity(
            opacity: _opacity.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
