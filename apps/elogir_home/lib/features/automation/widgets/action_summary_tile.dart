import 'package:elogir_home/features/automation/models/automation_action.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Displays a configured [AutomationAction] with a remove button.
class ActionSummaryTile extends StatelessWidget {
  const ActionSummaryTile({
    required this.action,
    required this.onRemove,
    super.key,
  });

  final AutomationAction action;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirCard(
      child: Row(
        children: [
          FaIcon(_iconFor(action), size: 16, color: theme.colors.primary),
          SizedBox(width: theme.spacing.sm),
          Expanded(
            child: ElogirText(_labelFor(action)),
          ),
          ElogirIconButton(
            icon: FaIcon(
              FontAwesomeIcons.xmark,
              size: 14,
              color: theme.colors.onSurfaceVariant,
            ),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }

  IconData _iconFor(AutomationAction action) {
    return switch (action) {
      TurnOnAction() => FontAwesomeIcons.lightbulb,
      TurnOffAction() => FontAwesomeIcons.powerOff,
      SetBrightnessAction() => FontAwesomeIcons.sun,
      SetColorAction() => FontAwesomeIcons.palette,
      SetColorTemperatureAction() => FontAwesomeIcons.temperatureHalf,
      OpenCoverAction() => FontAwesomeIcons.arrowUp,
      CloseCoverAction() => FontAwesomeIcons.arrowDown,
      SwitchOnAction() => FontAwesomeIcons.toggleOn,
      SwitchOffAction() => FontAwesomeIcons.toggleOff,
      _ => FontAwesomeIcons.question,
    };
  }

  String _labelFor(AutomationAction action) {
    return switch (action) {
      TurnOnAction() => 'Turn on light',
      TurnOffAction() => 'Turn off light',
      SetBrightnessAction(:final percentage) => 'Brightness $percentage%',
      SetColorAction(:final r, :final g, :final b) => 'Color ($r, $g, $b)',
      SetColorTemperatureAction(:final percentage) => 'Color temp $percentage%',
      OpenCoverAction() => 'Open cover',
      CloseCoverAction() => 'Close cover',
      SwitchOnAction() => 'Switch on',
      SwitchOffAction() => 'Switch off',
      _ => 'Unknown action',
    };
  }
}
