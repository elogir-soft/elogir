import 'package:flutter/widgets.dart';

import 'curves.dart';

/// Smoothly transitions between gradient values.
///
/// ```dart
/// ElogirAnimatedGradient(
///   gradient: LinearGradient(
///     colors: _active
///       ? [Colors.blue, Colors.purple]
///       : [Colors.grey, Colors.blueGrey],
///   ),
///   child: SizedBox(height: 200),
/// )
/// ```
class ElogirAnimatedGradient extends StatefulWidget {
  const ElogirAnimatedGradient({
    super.key,
    required this.gradient,
    this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = ElogirCurves.gentle,
    this.borderRadius,
  });

  final Gradient gradient;
  final Widget? child;
  final Duration duration;
  final Curve curve;
  final BorderRadius? borderRadius;

  @override
  State<ElogirAnimatedGradient> createState() => _ElogirAnimatedGradientState();
}

class _ElogirAnimatedGradientState extends State<ElogirAnimatedGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Gradient? _oldGradient;
  late Gradient _currentGradient;

  @override
  void initState() {
    super.initState();
    _currentGradient = widget.gradient;
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
  }

  @override
  void didUpdateWidget(ElogirAnimatedGradient oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.gradient != oldWidget.gradient) {
      _oldGradient = _currentGradient;
      _currentGradient = widget.gradient;
      _controller
        ..reset()
        ..forward();
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
      animation: _animation,
      builder: (context, child) {
        final gradient = _oldGradient != null
            ? Gradient.lerp(_oldGradient, _currentGradient, _animation.value)!
            : _currentGradient;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: widget.borderRadius,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
