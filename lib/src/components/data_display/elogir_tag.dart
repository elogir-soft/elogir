import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// Color variants for tags.
enum ElogirTagVariant { neutral, primary, success, warning, error }

/// A small label chip, optionally removable or selectable.
///
/// All tags render at a consistent height regardless of whether
/// a remove button is present.
class ElogirTag extends StatelessWidget {
  const ElogirTag({
    super.key,
    required this.label,
    this.variant = ElogirTagVariant.neutral,
    this.onRemoved,
    this.onPressed,
    this.selected = false,
    this.icon,
  });

  final String label;
  final ElogirTagVariant variant;
  final VoidCallback? onRemoved;
  final VoidCallback? onPressed;
  final bool selected;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    final Color bg;
    final Color fg;
    final Color borderColor;

    switch (variant) {
      case ElogirTagVariant.neutral:
        bg = selected ? colors.onBackground : colors.surfaceContainer;
        fg = selected ? colors.background : colors.onSurface;
        borderColor = selected ? colors.onBackground : colors.outline;
      case ElogirTagVariant.primary:
        bg = selected ? colors.primary : colors.primaryContainer;
        fg = selected ? colors.onPrimary : colors.onPrimaryContainer;
        borderColor = selected ? colors.primary : colors.primary;
      case ElogirTagVariant.success:
        bg = selected
            ? colors.success
            : colors.success.withValues(alpha: 0.12);
        fg = selected ? colors.palette.white : colors.success;
        borderColor = colors.success;
      case ElogirTagVariant.warning:
        bg = selected
            ? colors.warning
            : colors.warning.withValues(alpha: 0.12);
        fg = selected ? colors.palette.black : colors.warning;
        borderColor = colors.warning;
      case ElogirTagVariant.error:
        bg = selected ? colors.error : colors.error.withValues(alpha: 0.12);
        fg = selected ? colors.onError : colors.error;
        borderColor = colors.error;
    }

    final labelStyle = theme.typography.labelSmall.copyWith(
      color: fg,
      height: 1.0,
    );

    Widget content = Container(
      constraints: const BoxConstraints(minHeight: 28),
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.sm + theme.spacing.xxs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: theme.radii.full,
        border: Border.all(color: borderColor, width: theme.strokes.medium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(color: fg, size: 14),
              child: icon!,
            ),
            SizedBox(width: theme.spacing.xs),
          ],
          Text(label, style: labelStyle),
          if (onRemoved != null) ...[
            SizedBox(width: theme.spacing.xs),
            ElogirPressable(
              onPressed: onRemoved,
              pressScale: 0.9,
              child: SizedBox(
                width: 16,
                height: 16,
                child: Center(
                  child: Text(
                    '\u00D7',
                    style: TextStyle(
                      color: fg,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );

    if (onPressed != null) {
      return ElogirPressable(
        onPressed: onPressed,
        pressScale: 0.95,
        child: content,
      );
    }

    return content;
  }
}
