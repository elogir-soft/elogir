import 'dart:math' show cos, pi, sin;

import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// A pill-shaped toggle for switching between light and dark theme.
///
/// Shows custom-painted sun and moon icons with a sliding indicator.
/// The app is responsible for wiring [onChanged] to the actual theme
/// mode — this widget only provides the visual toggle.
class ElogirThemeModeSwitch extends StatelessWidget {
  const ElogirThemeModeSwitch({
    super.key,
    required this.isDark,
    required this.onChanged,
    this.width = 76,
    this.height = 38,
  });

  final bool isDark;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final innerPad = 4.0;
    final indicatorWidth = (width - innerPad * 2) / 2;

    return ElogirPressable(
      onPressed: () => onChanged(!isDark),
      pressScale: 0.95,
      child: AnimatedContainer(
        duration: theme.durations.normal,
        width: width,
        height: height,
        padding: EdgeInsets.all(innerPad),
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(height / 2),
          border: Border.all(
            color: colors.outline,
            width: theme.strokes.thick,
          ),
        ),
        child: Stack(
          children: [
            // Sliding indicator
            AnimatedPositioned(
              duration: theme.durations.normal,
              curve: Curves.easeOutCubic,
              left: isDark ? indicatorWidth : 0,
              top: 0,
              bottom: 0,
              child: AnimatedContainer(
                duration: theme.durations.normal,
                width: indicatorWidth,
                decoration: BoxDecoration(
                  color: isDark
                      ? colors.palette.primary800
                      : colors.primary,
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
            ),
            // Icons
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: CustomPaint(
                      size: const Size(16, 16),
                      painter: _SunPainter(
                        color: isDark
                            ? colors.onSurfaceVariant
                            : colors.palette.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: CustomPaint(
                      size: const Size(14, 14),
                      painter: _MoonPainter(
                        color: isDark
                            ? colors.palette.white
                            : colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SunPainter extends CustomPainter {
  _SunPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..color = color;

    // Center circle
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, size.width * 0.22, paint);

    // Rays
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.6;
    paint.strokeCap = StrokeCap.round;

    final innerR = size.width * 0.32;
    final outerR = size.width * 0.46;

    for (int i = 0; i < 8; i++) {
      final a = i * (pi / 4);
      canvas.drawLine(
        Offset(center.dx + cos(a) * innerR, center.dy + sin(a) * innerR),
        Offset(center.dx + cos(a) * outerR, center.dy + sin(a) * outerR),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_SunPainter old) => color != old.color;
}

class _MoonPainter extends CustomPainter {
  _MoonPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width * 0.42;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final moon = Path()
      ..addOval(Rect.fromCircle(center: center, radius: r));

    final cutout = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(center.dx + r * 0.55, center.dy - r * 0.25),
        radius: r * 0.8,
      ));

    canvas.drawPath(
      Path.combine(PathOperation.difference, moon, cutout),
      paint,
    );
  }

  @override
  bool shouldRepaint(_MoonPainter old) => color != old.color;
}
