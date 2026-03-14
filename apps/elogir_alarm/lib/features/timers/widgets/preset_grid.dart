import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/shared/extensions/duration_extensions.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Grid of quick-start timer preset chips.
class PresetGrid extends StatelessWidget {
  const PresetGrid({required this.onPresetSelected, super.key});

  /// Called with the preset duration in milliseconds.
  final ValueChanged<int> onPresetSelected;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Wrap(
      spacing: theme.spacing.sm,
      runSpacing: theme.spacing.sm,
      children: AppConstants.timerPresetSeconds.map((seconds) {
        final duration = Duration(seconds: seconds);
        return ElogirTag(
          label: duration.presetLabel,
          variant: ElogirTagVariant.primary,
          onPressed: () => onPresetSelected(seconds * 1000),
        );
      }).toList(),
    );
  }
}
