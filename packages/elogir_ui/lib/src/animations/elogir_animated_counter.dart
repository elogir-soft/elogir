import 'package:flutter/widgets.dart';

import 'curves.dart';

/// Animates between numeric values with a smooth rolling transition.
///
/// ```dart
/// ElogirAnimatedCounter(
///   value: _count,
///   style: theme.typography.headlineLarge,
/// )
/// ```
class ElogirAnimatedCounter extends StatefulWidget {
  const ElogirAnimatedCounter({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 600),
    this.curve = ElogirCurves.snappy,
    this.style,
    this.prefix,
    this.suffix,
    this.fractionDigits = 0,
    this.separator,
  });

  /// The target numeric value.
  final num value;

  final Duration duration;
  final Curve curve;
  final TextStyle? style;

  /// Text displayed before the number (e.g., "$").
  final String? prefix;

  /// Text displayed after the number (e.g., "%").
  final String? suffix;

  /// Decimal places to display.
  final int fractionDigits;

  /// Thousands separator (e.g., ",").
  final String? separator;

  @override
  State<ElogirAnimatedCounter> createState() => _ElogirAnimatedCounterState();
}

class _ElogirAnimatedCounterState extends State<ElogirAnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _begin = 0;
  double _end = 0;

  @override
  void initState() {
    super.initState();
    _begin = widget.value.toDouble();
    _end = widget.value.toDouble();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: _begin, end: _end).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
  }

  @override
  void didUpdateWidget(ElogirAnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _begin = _animation.value;
      _end = widget.value.toDouble();
      _animation = Tween<double>(begin: _begin, end: _end).animate(
        CurvedAnimation(parent: _controller, curve: widget.curve),
      );
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

  String _format(double value) {
    String formatted;
    if (widget.fractionDigits == 0) {
      formatted = value.round().toString();
    } else {
      formatted = value.toStringAsFixed(widget.fractionDigits);
    }

    if (widget.separator != null) {
      final parts = formatted.split('.');
      final intPart = parts[0];
      final buffer = StringBuffer();
      final negative = intPart.startsWith('-');
      final digits = negative ? intPart.substring(1) : intPart;

      for (int i = 0; i < digits.length; i++) {
        if (i > 0 && (digits.length - i) % 3 == 0) {
          buffer.write(widget.separator);
        }
        buffer.write(digits[i]);
      }

      formatted = (negative ? '-' : '') +
          buffer.toString() +
          (parts.length > 1 ? '.${parts[1]}' : '');
    }

    return '${widget.prefix ?? ''}$formatted${widget.suffix ?? ''}';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Text(
          _format(_animation.value),
          style: widget.style,
        );
      },
    );
  }
}
