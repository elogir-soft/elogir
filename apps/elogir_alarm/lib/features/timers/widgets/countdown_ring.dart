import 'dart:math' as math;
import 'dart:ui';

import 'package:elogir_alarm/shared/extensions/duration_extensions.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Circular countdown ring with progress arc and centered time display.
class CountdownRing extends StatelessWidget {
  const CountdownRing({
    required this.progress,
    required this.remaining,
    this.label,
    this.size = 200,
    super.key,
  });

  /// Progress from 0.0 (just started) to 1.0 (done).
  final double progress;

  /// Remaining duration to display.
  final Duration remaining;

  /// Optional label below the time.
  final String? label;

  /// Diameter of the ring.
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ring
          CustomPaint(
            size: Size(size, size),
            painter: _CountdownRingPainter(
              progress: progress,
              trackColor: theme.colors.outlineVariant,
              fillColor: theme.colors.primary,
              strokeWidth: size * 0.04,
            ),
          ),
          // Time text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                remaining.formatted,
                style: (size > 150
                        ? theme.typography.displayMedium
                        : theme.typography.titleLarge)
                    .copyWith(
                  color: theme.colors.onSurface,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              if (label != null && label!.isNotEmpty) ...[
                SizedBox(height: theme.spacing.xxs),
                Text(
                  label!,
                  style: theme.typography.bodySmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _CountdownRingPainter extends CustomPainter {
  _CountdownRingPainter({
    required this.progress,
    required this.trackColor,
    required this.fillColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color trackColor;
  final Color fillColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track (full circle)
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Fill arc (sweeps counter-clockwise from top)
    if (progress > 0) {
      final fillPaint = Paint()
        ..color = fillColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * math.pi * progress.clamp(0, 1);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, // Start from top (12 o'clock)
        sweepAngle,
        false,
        fillPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_CountdownRingPainter oldDelegate) =>
      progress != oldDelegate.progress ||
      trackColor != oldDelegate.trackColor ||
      fillColor != oldDelegate.fillColor;
}
