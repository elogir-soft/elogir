import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/features/alarms/screens/sound_picker_screen.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Tappable row showing the current alarm sound. Opens [SoundPickerScreen]
/// for selection.
class SoundSelector extends StatelessWidget {
  const SoundSelector({
    required this.selectedSoundId,
    required this.onChanged,
    super.key,
  });

  final String selectedSoundId;
  final ValueChanged<String> onChanged;

  String get _label =>
      AppConstants.alarmSounds[selectedSoundId] ?? selectedSoundId;

  Future<void> _openPicker(BuildContext context) async {
    final result = await Navigator.of(context, rootNavigator: true)
        .push<String>(
      PageRouteBuilder<String>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SoundPickerScreen(selectedSoundId: selectedSoundId),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
      ),
    );
    if (result != null) {
      onChanged(result);
    }
  }

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
        ElogirPressable(
          onPressed: () => _openPicker(context),
          child: Container(
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
            decoration: BoxDecoration(
              color: theme.colors.surface,
              borderRadius: theme.radii.md,
              border: Border.all(
                color: theme.colors.outline,
                width: theme.strokes.thick,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElogirText(
                    _label,
                    variant: ElogirTextVariant.bodyMedium,
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: 12,
                  color: theme.colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
