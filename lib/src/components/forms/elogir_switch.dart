import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../interaction/elogir_pressable.dart';

/// A toggle switch with animated thumb and thick-bordered track.
///
/// Soft Industrial style: visible track border, solid thumb,
/// smooth slide animation.
class ElogirSwitch extends StatefulWidget {
  const ElogirSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.width = 52.0,
    this.height = 30.0,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? label;
  final bool enabled;
  final double width;
  final double height;

  @override
  State<ElogirSwitch> createState() => _ElogirSwitchState();
}

class _ElogirSwitchState extends State<ElogirSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(ElogirSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animation.forward();
      } else {
        _animation.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final colors = theme.colors;
    final enabled = widget.enabled && widget.onChanged != null;

    final thumbSize = widget.height - 8;
    final travel = widget.width - thumbSize - 8;

    final switchWidget = AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final t = _animation.value;
        final trackColor = Color.lerp(
          enabled ? colors.outline : colors.disabled,
          enabled ? colors.primary : colors.disabled,
          t,
        )!;
        final thumbColor = Color.lerp(
          enabled ? colors.surface : colors.onDisabled,
          enabled ? colors.onPrimary : colors.onDisabled,
          t,
        )!;

        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(widget.height / 2),
            border: Border.all(
              color: _hovered && enabled
                  ? colors.primary
                  : trackColor,
              width: theme.strokes.thick,
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Transform.translate(
                offset: Offset(travel * t, 0),
                child: Container(
                  width: thumbSize,
                  height: thumbSize,
                  decoration: BoxDecoration(
                    color: thumbColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x1A000000),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    final content = widget.label != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              switchWidget,
              SizedBox(width: theme.spacing.sm),
              DefaultTextStyle.merge(
                style: theme.typography.bodyMedium.copyWith(
                  color: enabled ? colors.onBackground : colors.onDisabled,
                ),
                child: widget.label!,
              ),
            ],
          )
        : switchWidget;

    return Semantics(
      toggled: widget.value,
      enabled: enabled,
      child: ElogirPressable(
        enabled: enabled,
        onPressed: enabled ? () => widget.onChanged?.call(!widget.value) : null,
        onHoverChanged: (v) => setState(() => _hovered = v),
        pressScale: 0.95,
        child: content,
      ),
    );
  }
}
