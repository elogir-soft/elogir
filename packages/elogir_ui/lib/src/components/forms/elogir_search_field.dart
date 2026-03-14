import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// A search-optimized text field with a built-in search icon and clear button.
///
/// The clear button appears when the field has text and disappears when empty.
/// The app is responsible for any debouncing of [onChanged].
class ElogirSearchField extends StatefulWidget {
  const ElogirSearchField({
    super.key,
    this.controller,
    this.hint = 'Search…',
    this.onChanged,
    this.onSubmitted,
    this.autofocus = false,
    this.focusNode,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool enabled;

  @override
  State<ElogirSearchField> createState() => _ElogirSearchFieldState();
}

class _ElogirSearchFieldState extends State<ElogirSearchField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  bool _focused = false;

  bool get _hasText => _controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_handleFocusChange);
    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
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
    widget.onChanged?.call(_controller.text);
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final strokes = theme.strokes;

    final borderColor = !widget.enabled
        ? colors.disabled
        : _focused
            ? colors.primary
            : colors.outline;

    final bodyStyle = theme.typography.bodyMedium;

    return AnimatedContainer(
      duration: theme.durations.fast,
      height: 44,
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
        children: [
          // Search icon
          CustomPaint(
            size: const Size(18, 18),
            painter: _SearchIconPainter(
              color: _focused ? colors.primary : colors.onSurfaceVariant,
              strokeWidth: strokes.medium,
            ),
          ),
          SizedBox(width: theme.spacing.sm),
          // Input
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                if (!_hasText)
                  Text(
                    widget.hint,
                    style: bodyStyle.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                EditableText(
                  controller: _controller,
                  focusNode: _focusNode,
                  style: bodyStyle.copyWith(color: colors.onSurface),
                  cursorColor: colors.primary,
                  backgroundCursorColor: const Color(0x00000000),
                  autofocus: widget.autofocus,
                  onSubmitted: widget.onSubmitted,
                  readOnly: !widget.enabled,
                ),
              ],
            ),
          ),
          // Clear button
          if (_hasText)
            Padding(
              padding: EdgeInsets.only(left: theme.spacing.sm),
              child: ElogirPressable(
                onPressed: _clear,
                pressScale: 0.85,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CustomPaint(
                    painter: _ClearIconPainter(
                      color: colors.onSurfaceVariant,
                      strokeWidth: strokes.medium,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Draws a magnifying glass icon.
class _SearchIconPainter extends CustomPainter {
  _SearchIconPainter({required this.color, required this.strokeWidth});
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final circleCenter = Offset(size.width * 0.4, size.height * 0.4);
    final circleRadius = size.width * 0.28;
    canvas.drawCircle(circleCenter, circleRadius, paint);

    // Handle
    final handleStart = Offset(
      circleCenter.dx + circleRadius * 0.7,
      circleCenter.dy + circleRadius * 0.7,
    );
    final handleEnd = Offset(size.width * 0.85, size.height * 0.85);
    canvas.drawLine(handleStart, handleEnd, paint);
  }

  @override
  bool shouldRepaint(_SearchIconPainter old) =>
      color != old.color || strokeWidth != old.strokeWidth;
}

/// Draws an × icon for clearing.
class _ClearIconPainter extends CustomPainter {
  _ClearIconPainter({required this.color, required this.strokeWidth});
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final inset = size.width * 0.25;
    canvas.drawLine(
      Offset(inset, inset),
      Offset(size.width - inset, size.height - inset),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - inset, inset),
      Offset(inset, size.height - inset),
      paint,
    );
  }

  @override
  bool shouldRepaint(_ClearIconPainter old) =>
      color != old.color || strokeWidth != old.strokeWidth;
}
