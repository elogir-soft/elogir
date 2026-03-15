import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Shared decorative background used across elogir_calc.
class AppBackdrop extends StatelessWidget {
  const AppBackdrop({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(colors.background, colors.primaryContainer, 0.38)!,
            colors.background,
            Color.lerp(colors.background, colors.surface, 0.72)!,
          ],
          stops: const [0, 0.48, 1],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -72,
            right: -48,
            child: _GlowOrb(
              color: colors.primary.withOpacity(0.18),
              size: 260,
            ),
          ),
          Positioned(
            top: 180,
            left: -96,
            child: _GlowOrb(
              color: colors.primaryContainer.withOpacity(0.26),
              size: 220,
            ),
          ),
          Positioned(
            bottom: -120,
            right: -36,
            child: _GlowOrb(
              color: colors.surface.withOpacity(0.5),
              size: 280,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              const Color(0x00000000),
            ],
          ),
        ),
        child: SizedBox.square(dimension: size),
      ),
    );
  }
}
