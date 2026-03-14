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
    final hasHours = remaining.inHours > 0;

    // Pick font size based on ring size and whether hours are shown.
    final TextStyle timeStyle;
    if (size > 150) {
      timeStyle = hasHours
          ? theme.typography.headlineLarge
          : theme.typography.displayMedium;
    } else if (size > 100) {
      timeStyle = hasHours
          ? theme.typography.titleMedium
          : theme.typography.titleLarge;
    } else {
      timeStyle = hasHours
          ? theme.typography.labelMedium
          : theme.typography.titleSmall;
    }

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
          // Time text — constrained to ring interior.
          Padding(
            padding: EdgeInsets.all(size * 0.12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    remaining.formatted,
                    style: timeStyle.copyWith(
                      color: theme.colors.onSurface,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                    maxLines: 1,
                  ),
                ),
                if (label != null && label!.isNotEmpty) ...[
                  SizedBox(height: theme.spacing.xxs),
                  Text(
                    label!,
                    style: theme.typography.bodySmall.copyWith(
                      color: theme.colors.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ],
            ),
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

    // Fill arc (sweeps from top)
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
