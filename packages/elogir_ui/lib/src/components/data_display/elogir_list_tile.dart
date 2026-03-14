import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// A row with leading, title, subtitle, and trailing widgets.
///
/// Soft Industrial style: generous padding, clear typography hierarchy,
/// and subtle hover/press states.
class ElogirListTile extends StatefulWidget {
  const ElogirListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onPressed,
    this.onLongPress,
    this.enabled = true,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final bool enabled;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;

  @override
  State<ElogirListTile> createState() => _ElogirListTileState();
}

class _ElogirListTileState extends State<ElogirListTile> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;

    final effectivePadding = widget.padding ??
        EdgeInsets.symmetric(
          horizontal: theme.spacing.md,
          vertical: theme.spacing.sm,
        );

    final effectiveBorderRadius = widget.borderRadius ?? theme.radii.md;

    Color? bg = widget.backgroundColor;
    if (widget.onPressed != null && widget.enabled) {
      if (_pressed) {
        bg = colors.palette.neutral200.withValues(alpha: 0.5);
      } else if (_hovered) {
        bg = colors.palette.neutral100.withValues(alpha: 0.5);
      }
    }

    final content = Row(
      children: [
        if (widget.leading != null) ...[
          IconTheme.merge(
            data: IconThemeData(
              color: widget.enabled ? colors.onSurface : colors.onDisabled,
              size: 24,
            ),
            child: widget.leading!,
          ),
          SizedBox(width: theme.spacing.md),
        ],
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle.merge(
                style: theme.typography.labelLarge.copyWith(
                  color: widget.enabled ? colors.onSurface : colors.onDisabled,
                  fontWeight: FontWeight.w700,
                ),
                child: widget.title,
              ),
              if (widget.subtitle != null) ...[
                SizedBox(height: theme.spacing.xxs),
                DefaultTextStyle.merge(
                  style: theme.typography.bodySmall.copyWith(
                    color: widget.enabled
                        ? colors.onSurfaceVariant
                        : colors.onDisabled,
                  ),
                  child: widget.subtitle!,
                ),
              ],
            ],
          ),
        ),
        if (widget.trailing != null) ...[
          SizedBox(width: theme.spacing.md),
          IconTheme.merge(
            data: IconThemeData(
              color: widget.enabled
                  ? colors.onSurfaceVariant
                  : colors.onDisabled,
              size: 20,
            ),
            child: widget.trailing!,
          ),
        ],
      ],
    );

    return ElogirPressable(
      onPressed: widget.enabled ? widget.onPressed : null,
      onLongPress: widget.enabled ? widget.onLongPress : null,
      enabled: widget.enabled,
      onHoverChanged: (v) => setState(() => _hovered = v),
      onPressChanged: (v) => setState(() => _pressed = v),
      pressScale: 0.98,
      child: AnimatedContainer(
        duration: theme.durations.fast,
        padding: effectivePadding,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: effectiveBorderRadius,
        ),
        child: content,
      ),
    );
  }
}
