import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// Direction of the trend indicator.
enum ElogirTrendDirection { up, down, neutral }

/// A dashboard stat card with a large number, label, and optional trend indicator.
///
/// Soft Industrial style: thick-bordered card, bold number,
/// muted label, colored trend arrow with percentage.
class ElogirStatCard extends StatefulWidget {
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
  State<ElogirStatCard> createState() => _ElogirStatCardState();
}

class _ElogirStatCardState extends State<ElogirStatCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _countController;
  late Animation<double> _countAnimation;
  double? _parsedValue;
  String _displayFormat = '';

  @override
  void initState() {
    super.initState();
    _countController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _parsedValue = _parseValue(widget.value);
    if (_parsedValue != null) {
      _displayFormat = _detectFormat(widget.value);
      _countAnimation = Tween<double>(begin: 0.0, end: _parsedValue!).animate(
        CurvedAnimation(
          parent: _countController,
          curve: Curves.easeOutCubic,
        ),
      );
      _countController.forward();
    } else {
      _countAnimation = AlwaysStoppedAnimation(0.0);
    }
  }

  @override
  void didUpdateWidget(ElogirStatCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      final newParsed = _parseValue(widget.value);
      final oldParsed = _parsedValue;
      _parsedValue = newParsed;
      if (newParsed != null) {
        _displayFormat = _detectFormat(widget.value);
        _countAnimation = Tween<double>(
          begin: oldParsed ?? 0.0,
          end: newParsed,
        ).animate(
          CurvedAnimation(
            parent: _countController,
            curve: Curves.easeOutCubic,
          ),
        );
        _countController.forward(from: 0);
      }
    }
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  /// Try to parse the value string as a number, stripping commas.
  double? _parseValue(String value) {
    final cleaned = value.replaceAll(',', '').replaceAll(' ', '');
    return double.tryParse(cleaned);
  }

  /// Detect the format of the original string (decimal places, commas).
  String _detectFormat(String value) {
    final hasCommas = value.contains(',');
    final dotIndex = value.indexOf('.');
    final decimals = dotIndex >= 0 ? value.length - dotIndex - 1 : 0;
    return '${hasCommas ? 'c' : ''}$decimals';
  }

  /// Format a number to match the detected format.
  String _formatNumber(double number) {
    final hasCommas = _displayFormat.startsWith('c');
    final formatStr = hasCommas ? _displayFormat.substring(1) : _displayFormat;
    final decimals = int.tryParse(formatStr) ?? 0;

    String result = number.toStringAsFixed(decimals);

    if (hasCommas) {
      // Add commas to the integer part
      final parts = result.split('.');
      final intPart = parts[0];
      final buffer = StringBuffer();
      final startIndex = intPart.startsWith('-') ? 1 : 0;
      final digits = intPart.substring(startIndex);
      for (int i = 0; i < digits.length; i++) {
        if (i > 0 && (digits.length - i) % 3 == 0) {
          buffer.write(',');
        }
        buffer.write(digits[i]);
      }
      result = (startIndex == 1 ? '-' : '') + buffer.toString();
      if (parts.length > 1) {
        result += '.${parts[1]}';
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final effectiveDirection =
        widget.trendDirection ?? (widget.trend != null ? ElogirTrendDirection.neutral : null);

    return Container(
      width: widget.width,
      padding: EdgeInsets.all(theme.spacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: theme.radii.md,
        border: Border.all(
          color: colors.outlineVariant,
          width: theme.strokes.medium,
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
                  widget.label,
                  style: theme.typography.labelLarge.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (widget.icon != null)
                IconTheme(
                  data: IconThemeData(
                    color: colors.onSurfaceVariant,
                    size: 20,
                  ),
                  child: widget.icon!,
                ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          // Value
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              if (widget.prefix != null)
                Text(
                  widget.prefix!,
                  style: theme.typography.headlineSmall.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              Flexible(
                child: _parsedValue != null
                    ? AnimatedBuilder(
                        animation: _countAnimation,
                        builder: (context, _) {
                          return Text(
                            _formatNumber(_countAnimation.value),
                            style: theme.typography.headlineLarge.copyWith(
                              color: colors.onSurface,
                            ),
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      )
                    : Text(
                        widget.value,
                        style: theme.typography.headlineLarge.copyWith(
                          color: colors.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
              if (widget.suffix != null)
                Padding(
                  padding: EdgeInsets.only(left: theme.spacing.xxs),
                  child: Text(
                    widget.suffix!,
                    style: theme.typography.titleMedium.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
          // Trend
          if (widget.trend != null && effectiveDirection != null) ...[
            SizedBox(height: theme.spacing.sm),
            Row(
              children: [
                // Trend arrow
                if (effectiveDirection != ElogirTrendDirection.neutral)
                  Padding(
                    padding: EdgeInsets.only(right: theme.spacing.xs),
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
                  widget.trend!,
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
