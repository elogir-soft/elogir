import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Dropdown selector for alarm sound type.
class SoundSelector extends StatelessWidget {
  const SoundSelector({
    required this.selectedSoundId,
    required this.onChanged,
    super.key,
  });

  final String selectedSoundId;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: theme.spacing.xs),
          child: ElogirText(
            'Sound',
            variant: ElogirTextVariant.labelMedium,
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
        ),
        ElogirDropdown<String>(
          value: selectedSoundId,
          options: AppConstants.alarmSounds.entries
              .map(
                (e) => ElogirDropdownOption(value: e.key, label: e.value),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
