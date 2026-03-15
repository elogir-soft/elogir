import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// A large circular power button with animated ON/OFF state.
class PowerButton extends StatefulWidget {
  const PowerButton({
    required this.isOn,
    required this.onChanged,
    this.loading = false,
    this.size = 120.0,
    super.key,
  });

  final bool isOn;
  final ValueChanged<bool> onChanged;
  final bool loading;
  final double size;

  @override
  State<PowerButton> createState() => _PowerButtonState();
}

class _PowerButtonState extends State<PowerButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
      value: widget.isOn ? 1.0 : 0.0,
    );
    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didUpdateWidget(PowerButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOn != oldWidget.isOn) {
      if (widget.isOn) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirPressable(
      onPressed: widget.loading ? null : () => widget.onChanged(!widget.isOn),
      pressScale: 0.93,
      child: AnimatedBuilder(
        animation: _curve,
        builder: (context, _) {
          final t = _curve.value;
          final fillColor = Color.lerp(
            theme.colors.surface,
            theme.colors.primary,
            t,
          )!;
          final borderColor = Color.lerp(
            theme.colors.outlineVariant,
            theme.colors.primary,
            t,
          )!;
          final iconColor = Color.lerp(
            theme.colors.onSurfaceVariant,
            theme.colors.onPrimary,
            t,
          )!;

          return Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: fillColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor,
                width: theme.strokes.thick,
              ),
            ),
            child: Center(
              child: widget.loading
                  ? ElogirSpinner(
                      size: widget.size * 0.3,
                      color: iconColor,
                    )
                  : FaIcon(
                      FontAwesomeIcons.powerOff,
                      size: widget.size * 0.35,
                      color: iconColor,
                    ),
            ),
          );
        },
      ),
    );
  }
}
