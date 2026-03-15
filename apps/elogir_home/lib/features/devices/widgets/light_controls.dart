import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Controls for a light device: on/off, brightness, mode, color temp, RGB.
///
/// Uses optimistic local state for the power toggle so taps give
/// immediate visual feedback.
class LightControls extends StatefulWidget {
  /// Creates light controls.
  const LightControls({
    required this.state,
    required this.controller,
    super.key,
  });

  /// The current light state from the device.
  final LightState state;

  /// The controller for sending commands.
  final LightController controller;

  @override
  State<LightControls> createState() => _LightControlsState();
}

class _LightControlsState extends State<LightControls> {
  bool? _pendingPower;

  bool get _isOn => _pendingPower ?? widget.state.isOn;

  Future<void> _togglePower({required bool on}) async {
    setState(() => _pendingPower = on);
    try {
      if (on) {
        await widget.controller.turnOn();
      } else {
        await widget.controller.turnOff();
      }
    } on Exception {
      if (mounted) {
        setState(() => _pendingPower = null);
        ElogirToast.show(
          context: context,
          message: 'Failed to toggle light',
          variant: ElogirToastVariant.error,
        );
      }
    }
  }

  @override
  void didUpdateWidget(LightControls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != oldWidget.state) {
      _pendingPower = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Power toggle
        ElogirCard(
          padding: EdgeInsets.zero,
          child: ElogirListTile(
            title: const ElogirText(
              'Power',
              variant: ElogirTextVariant.bodyMedium,
            ),
            trailing: ElogirSwitch(
              value: _isOn,
              onChanged: (on) => _togglePower(on: on),
            ),
          ),
        ),

        SizedBox(height: theme.spacing.md),

        // Brightness
        ElogirCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElogirText(
                'Brightness: ${widget.state.brightness}%',
                variant: ElogirTextVariant.bodyMedium,
              ),
              SizedBox(height: theme.spacing.sm),
              ElogirSlider(
                value: widget.state.brightness.toDouble(),
                min: 1,
                max: 100,
                onChanged: (v) =>
                    widget.controller.setBrightness(v.round()),
              ),
            ],
          ),
        ),

        SizedBox(height: theme.spacing.md),

        // Mode selector
        ElogirCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ElogirText(
                'Mode',
                variant: ElogirTextVariant.bodyMedium,
              ),
              SizedBox(height: theme.spacing.sm),
              ElogirSegmentedControl<LightMode>(
                selected: widget.state.mode,
                segments: const [
                  ElogirSegment(value: LightMode.white, label: 'White'),
                  ElogirSegment(value: LightMode.colour, label: 'Colour'),
                  ElogirSegment(value: LightMode.scene, label: 'Scene'),
                ],
                onChanged: widget.controller.setMode,
              ),
            ],
          ),
        ),

        SizedBox(height: theme.spacing.md),

        // White mode: color temperature
        if (widget.state.mode == LightMode.white)
          ElogirCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElogirText(
                  'Color Temperature: ${widget.state.colorTemp}%',
                  variant: ElogirTextVariant.bodyMedium,
                ),
                SizedBox(height: theme.spacing.sm),
                ElogirSlider(
                  value: widget.state.colorTemp.toDouble(),
                  max: 100,
                  onChanged: (v) =>
                      widget.controller.setColorTemperature(v.round()),
                ),
              ],
            ),
          ),

        // Colour mode: RGB sliders
        if (widget.state.mode == LightMode.colour) ...[
          ElogirCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElogirText(
                  'Red: ${widget.state.r}',
                  variant: ElogirTextVariant.bodyMedium,
                ),
                ElogirSlider(
                  value: widget.state.r.toDouble(),
                  max: 255,
                  onChanged: (v) => widget.controller.setColor(
                    v.round(),
                    widget.state.g,
                    widget.state.b,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                ElogirText(
                  'Green: ${widget.state.g}',
                  variant: ElogirTextVariant.bodyMedium,
                ),
                ElogirSlider(
                  value: widget.state.g.toDouble(),
                  max: 255,
                  onChanged: (v) => widget.controller.setColor(
                    widget.state.r,
                    v.round(),
                    widget.state.b,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
                ElogirText(
                  'Blue: ${widget.state.b}',
                  variant: ElogirTextVariant.bodyMedium,
                ),
                ElogirSlider(
                  value: widget.state.b.toDouble(),
                  max: 255,
                  onChanged: (v) => widget.controller.setColor(
                    widget.state.r,
                    widget.state.g,
                    v.round(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
