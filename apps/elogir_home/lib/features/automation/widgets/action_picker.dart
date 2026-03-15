import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/automation/models/automation_action.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Presents available actions for a given [DeviceType] and lets the user
/// pick one. For actions with parameters (brightness, color, etc.) a
/// secondary input is shown.
class ActionPicker extends StatefulWidget {
  const ActionPicker({
    required this.device,
    required this.onActionSelected,
    super.key,
  });

  final SmartDevice device;
  final ValueChanged<AutomationAction> onActionSelected;

  @override
  State<ActionPicker> createState() => _ActionPickerState();
}

class _ActionPickerState extends State<ActionPicker> {
  int _brightnessValue = 50;
  int _colorTempValue = 50;

  List<_ActionOption> get _options {
    return switch (widget.device.type) {
      DeviceType.light => [
          _ActionOption(
            label: 'Turn on',
            icon: FontAwesomeIcons.lightbulb,
            onTap: () => widget.onActionSelected(
              AutomationAction.turnOn(deviceId: widget.device.id),
            ),
          ),
          _ActionOption(
            label: 'Turn off',
            icon: FontAwesomeIcons.powerOff,
            onTap: () => widget.onActionSelected(
              AutomationAction.turnOff(deviceId: widget.device.id),
            ),
          ),
          const _ActionOption(
            label: 'Set brightness',
            icon: FontAwesomeIcons.sun,
            hasSlider: true,
          ),
          const _ActionOption(
            label: 'Set color temperature',
            icon: FontAwesomeIcons.temperatureHalf,
            hasColorTempSlider: true,
          ),
        ],
      DeviceType.switchDevice => [
          _ActionOption(
            label: 'Switch on',
            icon: FontAwesomeIcons.toggleOn,
            onTap: () => widget.onActionSelected(
              AutomationAction.switchOn(deviceId: widget.device.id),
            ),
          ),
          _ActionOption(
            label: 'Switch off',
            icon: FontAwesomeIcons.toggleOff,
            onTap: () => widget.onActionSelected(
              AutomationAction.switchOff(deviceId: widget.device.id),
            ),
          ),
        ],
      DeviceType.cover => [
          _ActionOption(
            label: 'Open',
            icon: FontAwesomeIcons.arrowUp,
            onTap: () => widget.onActionSelected(
              AutomationAction.openCover(deviceId: widget.device.id),
            ),
          ),
          _ActionOption(
            label: 'Close',
            icon: FontAwesomeIcons.arrowDown,
            onTap: () => widget.onActionSelected(
              AutomationAction.closeCover(deviceId: widget.device.id),
            ),
          ),
        ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final options = _options;

    return ListView.separated(
      shrinkWrap: true,
      itemCount: options.length,
      separatorBuilder: (_, _) => SizedBox(height: theme.spacing.sm),
      itemBuilder: (context, index) {
        final option = options[index];

        if (option.hasSlider) {
          return ElogirCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FaIcon(option.icon, size: 16, color: theme.colors.primary),
                    SizedBox(width: theme.spacing.sm),
                    ElogirText(
                      '${option.label} ($_brightnessValue%)',
                    ),
                  ],
                ),
                SizedBox(height: theme.spacing.sm),
                ElogirSlider(
                  value: _brightnessValue.toDouble(),
                  min: 1,
                  max: 100,
                  onChanged: (v) =>
                      setState(() => _brightnessValue = v.round()),
                ),
                SizedBox(height: theme.spacing.sm),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElogirButton(
                    size: ElogirButtonSize.sm,
                    onPressed: () => widget.onActionSelected(
                      AutomationAction.setBrightness(
                        deviceId: widget.device.id,
                        percentage: _brightnessValue,
                      ),
                    ),
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          );
        }

        if (option.hasColorTempSlider) {
          return ElogirCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FaIcon(option.icon, size: 16, color: theme.colors.primary),
                    SizedBox(width: theme.spacing.sm),
                    ElogirText(
                      '${option.label} ($_colorTempValue%)',
                    ),
                  ],
                ),
                SizedBox(height: theme.spacing.sm),
                ElogirSlider(
                  value: _colorTempValue.toDouble(),
                  max: 100,
                  onChanged: (v) =>
                      setState(() => _colorTempValue = v.round()),
                ),
                SizedBox(height: theme.spacing.sm),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElogirButton(
                    size: ElogirButtonSize.sm,
                    onPressed: () => widget.onActionSelected(
                      AutomationAction.setColorTemperature(
                        deviceId: widget.device.id,
                        percentage: _colorTempValue,
                      ),
                    ),
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          );
        }

        return ElogirPressable(
          onPressed: option.onTap,
          pressScale: 0.98,
          child: ElogirCard(
            child: Row(
              children: [
                FaIcon(option.icon, size: 16, color: theme.colors.primary),
                SizedBox(width: theme.spacing.sm),
                ElogirText(option.label),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ActionOption {
  const _ActionOption({
    required this.label,
    required this.icon,
    this.onTap,
    this.hasSlider = false,
    this.hasColorTempSlider = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool hasSlider;
  final bool hasColorTempSlider;
}
