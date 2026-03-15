import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Custom-painted navigation icons for the alarm app.
///
/// Since `uses-material-design: false`, we draw all icons with
/// [CustomPainter] using stroke style to match Soft Industrial.

/// Gear/cog icon for settings — 6 teeth drawn with strokes.
class SettingsIcon extends StatelessWidget {
  const SettingsIcon({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return CustomPaint(
      size: Size(size, size),
      painter: _SettingsIconPainter(
        color: color ?? iconTheme.color ?? const Color(0xFF1D1B20),
      ),
    );
  }
}

class _SettingsIconPainter extends CustomPainter {
  _SettingsIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width * 0.42;
    final innerRadius = size.width * 0.28;
    final toothHalfAngle = math.pi / 18; // 10° half-width per tooth
    const teethCount = 6;
    const angleStep = 2 * math.pi / teethCount;

    // Draw the gear outline as a closed path.
    final path = Path();
    for (var i = 0; i < teethCount; i++) {
      final baseAngle = i * angleStep - math.pi / 2;

      // Rising inner → outer edge of tooth
      final innerStart = Offset(
        center.dx + innerRadius * math.cos(baseAngle - toothHalfAngle),
        center.dy + innerRadius * math.sin(baseAngle - toothHalfAngle),
      );
      final outerLeft = Offset(
        center.dx + outerRadius * math.cos(baseAngle - toothHalfAngle),
        center.dy + outerRadius * math.sin(baseAngle - toothHalfAngle),
      );
      final outerRight = Offset(
        center.dx + outerRadius * math.cos(baseAngle + toothHalfAngle),
        center.dy + outerRadius * math.sin(baseAngle + toothHalfAngle),
      );
      final innerEnd = Offset(
        center.dx + innerRadius * math.cos(baseAngle + toothHalfAngle),
        center.dy + innerRadius * math.sin(baseAngle + toothHalfAngle),
      );

      if (i == 0) {
        path.moveTo(innerStart.dx, innerStart.dy);
      } else {
        path.lineTo(innerStart.dx, innerStart.dy);
      }
      path
        ..lineTo(outerLeft.dx, outerLeft.dy)
        ..lineTo(outerRight.dx, outerRight.dy)
        ..lineTo(innerEnd.dx, innerEnd.dy);

      // Arc along inner rim to next tooth
      final nextBaseAngle = (i + 1) * angleStep - math.pi / 2;
      final nextInnerStart = Offset(
        center.dx +
            innerRadius * math.cos(nextBaseAngle - toothHalfAngle),
        center.dy +
            innerRadius * math.sin(nextBaseAngle - toothHalfAngle),
      );
      path.lineTo(nextInnerStart.dx, nextInnerStart.dy);
    }
    path.close();
    canvas.drawPath(path, paint);

    // Centre hole
    canvas.drawCircle(center, size.width * 0.1, paint);
  }

  @override
  bool shouldRepaint(_SettingsIconPainter oldDelegate) =>
      color != oldDelegate.color;
}

/// Alarm clock icon: circle with two ears and clock hands.
class AlarmIcon extends StatelessWidget {
  const AlarmIcon({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return CustomPaint(
      size: Size(size, size),
      painter: _AlarmIconPainter(
        color: color ?? iconTheme.color ?? const Color(0xFF1D1B20),
      ),
    );
  }
}

class _AlarmIconPainter extends CustomPainter {
  _AlarmIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height * 0.55);
    final radius = size.width * 0.32;

    // Clock face
    canvas.drawCircle(center, radius, paint);

    // Hour hand (pointing to 10)
    final hourAngle = -math.pi / 3;
    canvas.drawLine(
      center,
      center + Offset(math.cos(hourAngle), math.sin(hourAngle)) * radius * 0.5,
      paint,
    );

    // Minute hand (pointing to 12)
    const minuteAngle = -math.pi / 2;
    canvas.drawLine(
      center,
      center +
          Offset(math.cos(minuteAngle), math.sin(minuteAngle)) * radius * 0.7,
      paint,
    );

    // Left ear
    canvas.drawLine(
      Offset(size.width * 0.18, size.height * 0.18),
      Offset(size.width * 0.28, size.height * 0.28),
      paint,
    );

    // Right ear
    canvas.drawLine(
      Offset(size.width * 0.82, size.height * 0.18),
      Offset(size.width * 0.72, size.height * 0.28),
      paint,
    );

    // Feet / stand lines
    canvas.drawLine(
      Offset(size.width * 0.32, size.height * 0.88),
      Offset(size.width * 0.22, size.height * 0.95),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.68, size.height * 0.88),
      Offset(size.width * 0.78, size.height * 0.95),
      paint,
    );
  }

  @override
  bool shouldRepaint(_AlarmIconPainter oldDelegate) =>
      color != oldDelegate.color;
}

/// Hourglass icon for timers.
class TimerIcon extends StatelessWidget {
  const TimerIcon({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return CustomPaint(
      size: Size(size, size),
      painter: _TimerIconPainter(
        color: color ?? iconTheme.color ?? const Color(0xFF1D1B20),
      ),
    );
  }
}

class _TimerIconPainter extends CustomPainter {
  _TimerIconPainter({required this.color});

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

    // Top horizontal bar
    canvas.drawLine(
      Offset(w * 0.2, h * 0.1),
      Offset(w * 0.8, h * 0.1),
      paint,
    );

    // Bottom horizontal bar
    canvas.drawLine(
      Offset(w * 0.2, h * 0.9),
      Offset(w * 0.8, h * 0.9),
      paint,
    );

    // Hourglass body
    final path = Path()
      ..moveTo(w * 0.25, h * 0.1)
      ..lineTo(w * 0.25, h * 0.3)
      ..lineTo(w * 0.5, h * 0.5)
      ..lineTo(w * 0.25, h * 0.7)
      ..lineTo(w * 0.25, h * 0.9)
      ..moveTo(w * 0.75, h * 0.1)
      ..lineTo(w * 0.75, h * 0.3)
      ..lineTo(w * 0.5, h * 0.5)
      ..lineTo(w * 0.75, h * 0.7)
      ..lineTo(w * 0.75, h * 0.9);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TimerIconPainter oldDelegate) =>
      color != oldDelegate.color;
}

/// Stopwatch icon: circle with crown button and single hand.
class StopwatchIcon extends StatelessWidget {
  const StopwatchIcon({super.key, this.size = 24, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return CustomPaint(
      size: Size(size, size),
      painter: _StopwatchIconPainter(
        color: color ?? iconTheme.color ?? const Color(0xFF1D1B20),
      ),
    );
  }
}

class _StopwatchIconPainter extends CustomPainter {
  _StopwatchIconPainter({required this.color});

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

    final center = Offset(w / 2, h * 0.55);
    final radius = w * 0.34;

    // Circle body
    canvas.drawCircle(center, radius, paint);

    // Crown button (top center)
    canvas.drawLine(
      Offset(w / 2, h * 0.08),
      Offset(w / 2, h * 0.2),
      paint,
    );

    // Button cap
    canvas.drawLine(
      Offset(w * 0.42, h * 0.08),
      Offset(w * 0.58, h * 0.08),
      paint,
    );

    // Side button (top right)
    canvas.drawLine(
      Offset(w * 0.72, h * 0.28),
      Offset(w * 0.82, h * 0.18),
      paint,
    );

    // Hand pointing to 2 o'clock
    final handAngle = -math.pi / 6;
    canvas.drawLine(
      center,
      center +
          Offset(math.cos(handAngle), math.sin(handAngle)) * radius * 0.65,
      paint,
    );
  }

  @override
  bool shouldRepaint(_StopwatchIconPainter oldDelegate) =>
      color != oldDelegate.color;
}
