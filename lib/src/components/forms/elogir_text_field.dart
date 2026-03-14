import 'dart:math' show sin, pi;

import 'package:flutter/services.dart' show TextInputAction;
import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A text input with label, hint, error/helper text, and thick-bordered
/// Soft Industrial styling.
///
/// The label sits above the input container and changes color on focus.
/// Hint text appears inside the input when empty.
class ElogirTextField extends StatefulWidget {
  const ElogirTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.showCounter = false,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final bool showCounter;
  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  State<ElogirTextField> createState() => _ElogirTextFieldState();
}

class _ElogirTextFieldState extends State<ElogirTextField>
    with SingleTickerProviderStateMixin {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;
  bool _focused = false;

  bool get _hasText => _controller.text.isNotEmpty;
  bool get _hasError => widget.errorText != null;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeOut),
    );
    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);
  }

  @override
  void didUpdateWidget(ElogirTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != null && oldWidget.errorText == null) {
      _shakeController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _controller.removeListener(_handleTextChange);
    if (widget.focusNode == null) _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() => _focused = _focusNode.hasFocus);
  }

  void _handleTextChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final strokes = theme.strokes;

    final Color borderColor;
    if (!widget.enabled) {
      borderColor = colors.disabled;
    } else if (_hasError) {
      borderColor = colors.error;
    } else if (_focused) {
      borderColor = colors.primary;
    } else {
      borderColor = colors.outline;
    }

    final Color labelColor;
    if (_hasError) {
      labelColor = colors.error;
    } else if (_focused) {
      labelColor = colors.primary;
    } else {
      labelColor = colors.onSurfaceVariant;
    }

    final counterText = widget.showCounter && widget.maxLength != null
        ? '${_controller.text.length}/${widget.maxLength}'
        : null;

    final bodyStyle = theme.typography.bodyMedium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label above the input
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: theme.spacing.xs,
              left: 2,
            ),
            child: AnimatedDefaultTextStyle(
              duration: theme.durations.fast,
              style: theme.typography.labelMedium.copyWith(
                color: labelColor,
              ),
              child: Text(widget.label!),
            ),
          ),

        // Input container
        AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) {
            final shakeOffset = sin(_shakeAnimation.value * pi * 3) *
                6 *
                (1 - _shakeAnimation.value);
            return Transform.translate(
              offset: Offset(shakeOffset, 0),
              child: child,
            );
          },
          child: AnimatedContainer(
          duration: theme.durations.fast,
          decoration: BoxDecoration(
            borderRadius: theme.radii.md,
            border: Border.all(
              color: borderColor,
              width: _focused ? strokes.thick : strokes.medium,
            ),
            color: widget.enabled
                ? colors.surface
                : colors.disabled.withValues(alpha: 0.3),
          ),
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.prefixIcon != null)
                Padding(
                  padding: EdgeInsets.only(right: theme.spacing.sm),
                  child: IconTheme(
                    data: IconThemeData(
                      color:
                          _focused ? colors.primary : colors.onSurfaceVariant,
                      size: 20,
                    ),
                    child: widget.prefixIcon!,
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      // Hint text
                      if (!_hasText && widget.hint != null)
                        Text(
                          widget.hint!,
                          style: bodyStyle.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      // Editable text
                      EditableText(
                        controller: _controller,
                        focusNode: _focusNode,
                        style: bodyStyle.copyWith(
                          color: widget.enabled
                              ? colors.onSurface
                              : colors.onDisabled,
                        ),
                        cursorColor: colors.primary,
                        backgroundCursorColor: const Color(0x00000000),
                        obscureText: widget.obscureText,
                        maxLines: widget.maxLines,
                        autofocus: widget.autofocus,
                        keyboardType: widget.keyboardType,
                        textInputAction: widget.textInputAction,
                        onChanged: widget.onChanged,
                        onSubmitted: widget.onSubmitted,
                        readOnly: !widget.enabled,
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.suffixIcon != null)
                Padding(
                  padding: EdgeInsets.only(left: theme.spacing.sm),
                  child: IconTheme(
                    data: IconThemeData(
                      color:
                          _focused ? colors.primary : colors.onSurfaceVariant,
                      size: 20,
                    ),
                    child: widget.suffixIcon!,
                  ),
                ),
            ],
          ),
        ),
        ),

        // Helper / error / counter
        if (widget.errorText != null ||
            widget.helperText != null ||
            counterText != null)
          Padding(
            padding: EdgeInsets.only(
              top: theme.spacing.xs,
              left: 2,
              right: 2,
            ),
            child: Row(
              children: [
                if (_hasError)
                  Expanded(
                    child: Text(
                      widget.errorText!,
                      style: theme.typography.caption.copyWith(
                        color: colors.error,
                      ),
                    ),
                  )
                else if (widget.helperText != null)
                  Expanded(
                    child: Text(
                      widget.helperText!,
                      style: theme.typography.caption.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  )
                else
                  const Spacer(),
                if (counterText != null)
                  Text(
                    counterText,
                    style: theme.typography.caption.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
