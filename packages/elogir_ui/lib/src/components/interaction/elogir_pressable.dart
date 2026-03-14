import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// Base interaction widget with scale-down press animation.
///
/// Wraps any child to make it tappable with a subtle iOS-like scale
/// effect on press. All interactive elogir widgets use this internally.
///
/// Uses [Listener] for the visual press state so the scale feedback is
/// immediate even when [onLongPress] is set (no gesture disambiguation
/// delay).
class ElogirPressable extends StatefulWidget {
  const ElogirPressable({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.onHoverChanged,
    this.onPressChanged,
    this.onFocusChanged,
    this.enabled = true,
    this.pressScale = 0.97,
    this.cursor,
    this.autofocus = false,
    this.focusNode,
    this.semanticsLabel,
    this.isButton = false,
    this.hitTestBehavior = HitTestBehavior.opaque,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHoverChanged;
  final ValueChanged<bool>? onPressChanged;
  final ValueChanged<bool>? onFocusChanged;
  final bool enabled;
  final double pressScale;
  final MouseCursor? cursor;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? semanticsLabel;
  final bool isButton;
  final HitTestBehavior hitTestBehavior;

  @override
  State<ElogirPressable> createState() => _ElogirPressableState();
}

class _ElogirPressableState extends State<ElogirPressable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.pressScale,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handlePointerDown(PointerDownEvent _) {
    if (!widget.enabled) return;
    _scaleController.forward();
    widget.onPressChanged?.call(true);
  }

  void _handlePointerUp(PointerUpEvent _) {
    if (!widget.enabled) return;
    _scaleController.reverse();
    widget.onPressChanged?.call(false);
  }

  void _handlePointerCancel(PointerCancelEvent _) {
    if (!widget.enabled) return;
    _scaleController.reverse();
    widget.onPressChanged?.call(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.maybeOf(context);
    final duration = theme?.durations.fast ?? const Duration(milliseconds: 100);

    if (_scaleController.duration != duration) {
      _scaleController.duration = duration;
    }

    return Semantics(
      button: widget.isButton,
      enabled: widget.enabled,
      label: widget.semanticsLabel,
      child: FocusableActionDetector(
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        focusNode: widget.focusNode,
        mouseCursor: widget.enabled
            ? (widget.cursor ?? SystemMouseCursors.click)
            : SystemMouseCursors.basic,
        onShowHoverHighlight: (v) => widget.onHoverChanged?.call(v),
        onShowFocusHighlight: (v) => widget.onFocusChanged?.call(v),
        child: Listener(
          onPointerDown: widget.enabled ? _handlePointerDown : null,
          onPointerUp: widget.enabled ? _handlePointerUp : null,
          onPointerCancel: widget.enabled ? _handlePointerCancel : null,
          child: GestureDetector(
            behavior: widget.hitTestBehavior,
            onTap: widget.enabled ? widget.onPressed : null,
            onLongPress: widget.enabled ? widget.onLongPress : null,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
