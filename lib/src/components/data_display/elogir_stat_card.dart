import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// Direction of the trend indicator.
enum ElogirTrendDirection { up, down, neutral }

/// A dashboard stat card with a large number, label, and optional trend indicator.
///
/// Soft Industrial style: thick-bordered card, bold number,
/// muted label, colored trend arrow with percentage.
class ElogirStatCard extends StatelessWidget {
  const ElogirStatCard({
    super.key,
    required this.value,
    required this.label,
    this.trend,
    this.trendDirection,
    this.prefix,
    this.suffix,
    this.icon,
    this.width,
  });

  /// The primary large value (e.g., "1,234", "89%").
  final String value;

  /// Label below the value (e.g., "Active Users").
  final String label;

  /// Optional trend text (e.g., "+12.5%").
  final String? trend;

  /// Direction of the trend for coloring.
  /// Defaults to [ElogirTrendDirection.neutral] if [trend] is set.
  final ElogirTrendDirection? trendDirection;

  /// Text before the value (e.g., "$").
  final String? prefix;

  /// Text after the value (e.g., "ms").
  final String? suffix;

  /// Optional icon displayed in the top-right corner.
  final Widget? icon;

  /// Fixed width. If null, expands to parent.
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final effectiveDirection =
        trendDirection ?? (trend != null ? ElogirTrendDirection.neutral : null);

    return Container(
      width: width,
      padding: EdgeInsets.all(theme.spacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: theme.radii.md,
        border: Border.all(
          color: colors.outline,
          width: theme.strokes.thick,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top row: label + icon
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: theme.typography.labelMedium.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
              if (icon != null)
                IconTheme(
                  data: IconThemeData(
                    color: colors.onSurfaceVariant,
                    size: 20,
                  ),
                  child: icon!,
                ),
            ],
          ),
          SizedBox(height: theme.spacing.sm),
          // Value
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              if (prefix != null)
                Text(
                  prefix!,
                  style: theme.typography.headlineSmall.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              Text(
                value,
                style: theme.typography.headlineLarge.copyWith(
                  color: colors.onSurface,
                ),
              ),
              if (suffix != null)
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    suffix!,
                    style: theme.typography.titleMedium.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
          // Trend
          if (trend != null && effectiveDirection != null) ...[
            SizedBox(height: theme.spacing.sm),
            Row(
              children: [
                // Trend arrow
                if (effectiveDirection != ElogirTrendDirection.neutral)
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: CustomPaint(
                      size: const Size(10, 10),
                      painter: _TrendArrowPainter(
                        direction: effectiveDirection,
                        color: effectiveDirection == ElogirTrendDirection.up
                            ? colors.success
                            : colors.error,
                        strokeWidth: theme.strokes.thick,
                      ),
                    ),
                  ),
                Text(
                  trend!,
                  style: theme.typography.labelSmall.copyWith(
                    color: effectiveDirection == ElogirTrendDirection.up
                        ? colors.success
                        : effectiveDirection == ElogirTrendDirection.down
                            ? colors.error
                            : colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _TrendArrowPainter extends CustomPainter {
  _TrendArrowPainter({
    required this.direction,
    required this.color,
    required this.strokeWidth,
  });

  final ElogirTrendDirection direction;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    if (direction == ElogirTrendDirection.up) {
      // Arrow pointing up-right
      path.moveTo(0, size.height);
      path.lineTo(size.width, 0);
      // Arrowhead
      path.moveTo(size.width * 0.5, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height * 0.5);
    } else {
      // Arrow pointing down-right
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height);
      // Arrowhead
      path.moveTo(size.width * 0.5, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, size.height * 0.5);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TrendArrowPainter old) =>
      direction != old.direction || color != old.color;
}
