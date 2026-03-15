import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// Icon button variants that define default styling.
enum ElogirIconButtonVariant { filled, outlined, ghost, tonal }

/// Icon button size presets.
enum ElogirIconButtonSize { sm, md, lg }

/// A circular icon-only button with the Soft Industrial style.
///
/// Circular by default but can be customized via [borderRadius].
class ElogirIconButton extends StatefulWidget {
  const ElogirIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.variant = ElogirIconButtonVariant.ghost,
    this.size = ElogirIconButtonSize.md,
    this.enabled = true,
    this.semanticsLabel,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.autofocus = false,
    this.focusNode,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final ElogirIconButtonVariant variant;
  final ElogirIconButtonSize size;
  final bool enabled;
  final String? semanticsLabel;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderRadius? borderRadius;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  State<ElogirIconButton> createState() => _ElogirIconButtonState();
}

class _ElogirIconButtonState extends State<ElogirIconButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final enabled = widget.enabled && widget.onPressed != null;

    // Size defaults
    final double buttonSize;
    final double iconSize;
    switch (widget.size) {
      case ElogirIconButtonSize.sm:
        buttonSize = 32;
        iconSize = 18;
      case ElogirIconButtonSize.md:
        buttonSize = 44;
        iconSize = 22;
      case ElogirIconButtonSize.lg:
        buttonSize = 56;
        iconSize = 28;
    }

    // Variant colors
    Color bg;
    Color fg;
    BoxBorder? border;

    switch (widget.variant) {
      case ElogirIconButtonVariant.filled:
        if (!enabled) {
          bg = colors.disabled;
          fg = colors.onDisabled;
        } else if (_pressed) {
          bg = Color.lerp(colors.primary, colors.palette.black, 0.12)!;
          fg = colors.onPrimary;
        } else if (_hovered) {
          bg = Color.lerp(colors.primary, colors.palette.white, 0.08)!;
          fg = colors.onPrimary;
        } else {
          bg = colors.primary;
          fg = colors.onPrimary;
        }

      case ElogirIconButtonVariant.outlined:
        fg = enabled ? colors.primary : colors.onDisabled;
        if (!enabled) {
          bg = const Color(0x00000000);
          border = Border.all(
              color: colors.disabled, width: theme.strokes.thick);
        } else if (_pressed) {
          bg = colors.primary.withValues(alpha: 0.12);
          border = Border.all(
              color: colors.primary, width: theme.strokes.thick);
        } else if (_hovered) {
          bg = colors.primary.withValues(alpha: 0.06);
          border = Border.all(
              color: colors.primary, width: theme.strokes.thick);
        } else {
          bg = const Color(0x00000000);
          border = Border.all(
              color: colors.outlineVariant, width: theme.strokes.thick);
        }

      case ElogirIconButtonVariant.ghost:
        fg = enabled ? colors.onSurfaceVariant : colors.onDisabled;
        if (_pressed && enabled) {
          bg = colors.onSurface.withValues(alpha: 0.10);
          fg = colors.onSurface;
        } else if (_hovered && enabled) {
          bg = colors.onSurface.withValues(alpha: 0.06);
          fg = colors.onSurface;
        } else {
          bg = const Color(0x00000000);
        }

      case ElogirIconButtonVariant.tonal:
        if (!enabled) {
          bg = colors.disabled;
          fg = colors.onDisabled;
        } else if (_pressed) {
          bg = Color.lerp(
            colors.primaryContainer,
            colors.palette.black,
            0.08,
          )!;
          fg = colors.onPrimaryContainer;
        } else if (_hovered) {
          bg = Color.lerp(
            colors.primaryContainer,
            colors.palette.white,
            0.06,
          )!;
          fg = colors.onPrimaryContainer;
        } else {
          bg = colors.primaryContainer;
          fg = colors.onPrimaryContainer;
        }
    }

    // Apply overrides
    if (enabled) {
      bg = widget.backgroundColor ?? bg;
      fg = widget.foregroundColor ?? fg;
    }

    return ElogirPressable(
      onPressed: enabled ? widget.onPressed : null,
      enabled: enabled,
      isButton: true,
      semanticsLabel: widget.semanticsLabel,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onHoverChanged: (v) => setState(() => _hovered = v),
      onPressChanged: (v) => setState(() => _pressed = v),
      child: AnimatedContainer(
        duration: theme.durations.fast,
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: widget.borderRadius ??
              (widget.variant == ElogirIconButtonVariant.ghost
                  ? theme.radii.md
                  : theme.radii.full),
          border: border,
        ),
        child: Center(
          child: DefaultTextStyle.merge(
            style: TextStyle(color: fg),
            child: IconTheme(
              data: IconThemeData(color: fg, size: iconSize),
              child: widget.icon,
            ),
          ),
        ),
      ),
    );
  }
}
