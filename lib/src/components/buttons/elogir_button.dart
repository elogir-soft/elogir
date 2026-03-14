import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../feedback/elogir_spinner.dart';
import '../interaction/elogir_pressable.dart';
import 'button_style.dart';

/// Button variants that define default styling.
enum ElogirButtonVariant { filled, outlined, ghost }

/// Button size presets.
enum ElogirButtonSize { sm, md, lg }

/// A fully accessible button with the Soft Industrial style.
///
/// Uses [ElogirPressable] for the scale-down press effect. Colors
/// for hover/press/disabled states are derived automatically from
/// the variant so you only set base colors when customizing.
class ElogirButton extends StatefulWidget {
  const ElogirButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = ElogirButtonVariant.filled,
    this.size = ElogirButtonSize.md,
    this.style,
    this.enabled = true,
    this.loading = false,
    this.expanded = false,
    this.icon,
    this.semanticsLabel,
    this.autofocus = false,
    this.focusNode,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final ElogirButtonVariant variant;
  final ElogirButtonSize size;
  final ElogirButtonStyle? style;
  final bool enabled;
  final bool loading;
  final bool expanded;
  final Widget? icon;
  final String? semanticsLabel;
  final bool autofocus;
  final FocusNode? focusNode;

  bool get _effectiveEnabled => enabled && !loading && onPressed != null;

  @override
  State<ElogirButton> createState() => _ElogirButtonState();
}

class _ElogirButtonState extends State<ElogirButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final enabled = widget._effectiveEnabled;

    // Size defaults
    final double defaultHeight;
    final EdgeInsets defaultPadding;
    final TextStyle defaultTextStyle;
    switch (widget.size) {
      case ElogirButtonSize.sm:
        defaultHeight = 36;
        defaultPadding = const EdgeInsets.symmetric(horizontal: 16);
        defaultTextStyle = theme.typography.labelMedium;
      case ElogirButtonSize.md:
        defaultHeight = 44;
        defaultPadding = const EdgeInsets.symmetric(horizontal: 24);
        defaultTextStyle = theme.typography.labelLarge;
      case ElogirButtonSize.lg:
        defaultHeight = 52;
        defaultPadding = const EdgeInsets.symmetric(horizontal: 32);
        defaultTextStyle = theme.typography.titleSmall;
    }

    final height = widget.style?.height ?? defaultHeight;
    final padding = widget.style?.padding ?? defaultPadding;
    final textStyle = widget.style?.textStyle ?? defaultTextStyle;
    final borderRadius = widget.style?.borderRadius ?? theme.radii.md;

    // Variant colors
    Color bg;
    Color fg;
    BoxBorder? border;

    switch (widget.variant) {
      case ElogirButtonVariant.filled:
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

      case ElogirButtonVariant.outlined:
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
              color: colors.outline, width: theme.strokes.thick);
        }

      case ElogirButtonVariant.ghost:
        fg = enabled ? colors.primary : colors.onDisabled;
        if (_pressed && enabled) {
          bg = colors.primary.withValues(alpha: 0.12);
        } else if (_hovered && enabled) {
          bg = colors.primary.withValues(alpha: 0.06);
        } else {
          bg = const Color(0x00000000);
        }
    }

    // Apply style overrides (only when enabled, to preserve disabled look)
    if (widget.style != null && enabled) {
      bg = widget.style!.backgroundColor ?? bg;
      fg = widget.style!.foregroundColor ?? fg;
      border = widget.style!.border ?? border;
    }

    // Spinner size proportional to button height
    final double spinnerSize;
    switch (widget.size) {
      case ElogirButtonSize.sm:
        spinnerSize = 14;
      case ElogirButtonSize.md:
        spinnerSize = 18;
      case ElogirButtonSize.lg:
        spinnerSize = 22;
    }

    final normalContent = Row(
      mainAxisSize:
          widget.expanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          widget.icon!,
          SizedBox(width: theme.spacing.sm),
        ],
        widget.child,
      ],
    );

    // Stack keeps both children laid out so the button never changes
    // width when swapping between label and spinner.
    final content = DefaultTextStyle.merge(
      style: textStyle.copyWith(color: fg),
      child: IconTheme(
        data: IconThemeData(color: fg, size: 18),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // The label is always laid out to hold the button width,
            // but invisible when loading.
            Opacity(
              opacity: widget.loading ? 0.0 : 1.0,
              child: normalContent,
            ),
            // Spinner fades in on top when loading.
            if (widget.loading)
              ElogirSpinner(size: spinnerSize, color: fg),
          ],
        ),
      ),
    );

    Widget result = ElogirPressable(
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
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: borderRadius,
          border: border,
        ),
        child: Align(
          alignment: Alignment.center,
          widthFactor: widget.expanded ? null : 1.0,
          child: content,
        ),
      ),
    );

    if (widget.expanded) {
      result = SizedBox(width: double.infinity, child: result);
    }

    return result;
  }
}
