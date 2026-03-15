import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// A reusable elevated surface for elogir_calc.
class AppPanel extends StatelessWidget {
  const AppPanel({
    required this.child,
    this.padding,
    this.radius = 28,
    this.prominent = false,
    this.borderColor,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final bool prominent;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final surfaceTop =
        backgroundColor ??
        Color.lerp(
          colors.surface,
          prominent ? colors.primaryContainer : colors.surfaceContainer,
          prominent ? 0.55 : 0.32,
        )!;
    final surfaceBottom = Color.lerp(
      colors.surface,
      colors.background,
      prominent ? 0.18 : 0.36,
    )!;
    final strokeColor =
        borderColor ??
        Color.lerp(
          colors.outlineVariant,
          prominent ? colors.primary : colors.outline,
          prominent ? 0.45 : 0.18,
        )!;
    final effectivePadding =
        padding ?? EdgeInsets.all(theme.spacing.md + theme.spacing.xs);
    final borderRadius = BorderRadius.circular(radius);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: strokeColor,
          width: prominent ? 2 : 1.4,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            surfaceTop,
            surfaceBottom,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            Positioned(
              top: -64,
              right: -32,
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color.lerp(
                          colors.primaryContainer,
                          colors.primary,
                          0.24,
                        )!.withOpacity(prominent ? 0.42 : 0.22),
                        const Color(0x00000000),
                      ],
                    ),
                  ),
                  child: const SizedBox(width: 180, height: 180),
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFFFFFFF).withOpacity(0.08),
                        const Color(0x00000000),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: effectivePadding,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
