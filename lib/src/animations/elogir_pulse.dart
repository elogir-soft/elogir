import 'package:flutter/widgets.dart';

/// Mode of the pulse animation.
enum ElogirPulseMode { scale, opacity, both }

/// A repeating pulse animation for drawing attention to a widget.
///
/// ```dart
/// ElogirPulse(
///   child: ElogirBadge(showDot: true, child: icon),
/// )
/// ```
class ElogirPulse extends StatefulWidget {
  const ElogirPulse({
    super.key,
    required this.child,
    this.mode = ElogirPulseMode.scale,
    this.duration = const Duration(milliseconds: 1200),
    this.minScale = 0.95,
    this.maxScale = 1.05,
    this.minOpacity = 0.6,
    this.maxOpacity = 1.0,
    this.enabled = true,
  });

  final Widget child;
  final ElogirPulseMode mode;
  final Duration duration;
  final double minScale;
  final double maxScale;
  final double minOpacity;
  final double maxOpacity;

  /// Set to false to stop the animation while keeping the child visible.
  final bool enabled;

  @override
  State<ElogirPulse> createState() => _ElogirPulseState();
}

class _ElogirPulseState extends State<ElogirPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    if (widget.enabled) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(ElogirPulse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (widget.enabled) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.value = 0;
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
    if (!widget.enabled) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        Widget result = child!;

        if (widget.mode == ElogirPulseMode.scale ||
            widget.mode == ElogirPulseMode.both) {
          final scale = widget.minScale +
              (widget.maxScale - widget.minScale) * t;
          result = Transform.scale(scale: scale, child: result);
        }

        if (widget.mode == ElogirPulseMode.opacity ||
            widget.mode == ElogirPulseMode.both) {
          final opacity = widget.minOpacity +
              (widget.maxOpacity - widget.minOpacity) * t;
          result = Opacity(opacity: opacity, child: result);
        }

        return result;
      },
      child: widget.child,
    );
  }
}
