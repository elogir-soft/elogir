import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Custom-painted navigation icons for the calculator app.
///
/// Since `uses-material-design: false`, we draw all icons with
/// [CustomPainter] using stroke style to match Soft Industrial.

/// Calculator icon: grid of buttons inside a rounded rectangle.
class CalculatorIcon extends StatelessWidget {
  const CalculatorIcon({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return CustomPaint(
      size: Size(size, size),
      painter: _CalculatorIconPainter(
        color: color ?? iconTheme.color ?? const Color(0xFF1D1B20),
      ),
    );
  }
}

class _CalculatorIconPainter extends CustomPainter {
  _CalculatorIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
    final r = w * 0.08;

    // Outer rounded rectangle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.12, h * 0.08, w * 0.76, h * 0.84),
        Radius.circular(r),
      ),
      paint,
    );

    // Display bar at top
    canvas.drawRect(
      Rect.fromLTWH(w * 0.22, h * 0.18, w * 0.56, h * 0.14),
      paint,
    );

    // Button dots (3x3 grid)
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final dotRadius = w * 0.04;

    for (var row = 0; row < 3; row++) {
      for (var col = 0; col < 3; col++) {
        final cx = w * (0.32 + col * 0.18);
        final cy = h * (0.46 + row * 0.14);
        canvas.drawCircle(Offset(cx, cy), dotRadius, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_CalculatorIconPainter oldDelegate) =>
      color != oldDelegate.color;
}

/// Clock with counter-clockwise arrow for history.
class HistoryIcon extends StatelessWidget {
  const HistoryIcon({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return CustomPaint(
      size: Size(size, size),
      painter: _HistoryIconPainter(
        color: color ?? iconTheme.color ?? const Color(0xFF1D1B20),
      ),
    );
  }
}

class _HistoryIconPainter extends CustomPainter {
  _HistoryIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    final center = Offset(w * 0.55, h / 2);
    final radius = w * 0.32;

    // Clock circle (partial arc, ~300 degrees)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi * 5 / 6, // start
      math.pi * 5 / 3, // sweep (~300°)
      false,
      paint,
    );

    // Hour hand (pointing up-left)
    canvas.drawLine(
      center,
      center + Offset(-radius * 0.35, -radius * 0.45),
      paint,
    );

    // Minute hand (pointing up)
    canvas.drawLine(
      center,
      center + Offset(0, -radius * 0.6),
      paint,
    );

    // Arrow at the open end of the arc (counter-clockwise arrow)
    final arrowTip = Offset(
      center.dx + radius * math.cos(-math.pi * 5 / 6),
      center.dy + radius * math.sin(-math.pi * 5 / 6),
    );
    canvas
      ..drawLine(
        arrowTip,
        arrowTip + Offset(-w * 0.08, -h * 0.02),
        paint,
      )
      ..drawLine(
        arrowTip,
        arrowTip + Offset(w * 0.02, -h * 0.08),
        paint,
      );
  }

  @override
  bool shouldRepaint(_HistoryIconPainter oldDelegate) =>
      color != oldDelegate.color;
}
