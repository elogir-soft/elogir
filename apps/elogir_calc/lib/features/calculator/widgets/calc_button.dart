import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Visual variant for calculator buttons.
enum CalcButtonVariant {
  /// Number buttons — surface color.
  number,

  /// Operator buttons (+, -, *, /) — primary container.
  operator,

  /// Equals button — primary.
  equals,

  /// Clear/AC button — error tint.
  clear,

  /// Scientific function buttons — surface container.
  scientific,
}

/// A grid-friendly calculator button built on [ElogirPressable].
///
/// Designed for use inside Expanded within Row/Column layouts,
/// not GridView. Uses thick borders to match Soft Industrial.
class CalcButton extends StatelessWidget {
  const CalcButton({
    required this.label,
    required this.onPressed,
    this.variant = CalcButtonVariant.number,
    this.flex = 1,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final CalcButtonVariant variant;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = _resolveColors(theme);

    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.xxs),
        child: ElogirPressable(
          onPressed: onPressed,
          pressScale: 0.95,
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: colors.$1,
              borderRadius: theme.radii.md,
              border: Border.all(
                color: colors.$3,
                width: theme.strokes.thick,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: theme.typography.titleMedium.copyWith(
                color: colors.$2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  (Color bg, Color fg, Color border) _resolveColors(ElogirThemeData theme) {
    return switch (variant) {
      CalcButtonVariant.number => (
          theme.colors.surface,
          theme.colors.onSurface,
          theme.colors.outlineVariant,
        ),
      CalcButtonVariant.operator => (
          theme.colors.primaryContainer,
          theme.colors.onPrimaryContainer,
          theme.colors.outline,
        ),
      CalcButtonVariant.equals => (
          theme.colors.primary,
          theme.colors.onPrimary,
          theme.colors.primary,
        ),
      CalcButtonVariant.clear => (
          theme.colors.surface,
          theme.colors.error,
          theme.colors.error,
        ),
      CalcButtonVariant.scientific => (
          theme.colors.surfaceContainer,
          theme.colors.onSurface,
          theme.colors.outlineVariant,
        ),
    };
  }
}
