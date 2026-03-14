import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// A row of 7 tappable day circles for selecting repeat days.
class DayOfWeekSelector extends StatelessWidget {
  const DayOfWeekSelector({
    required this.selectedDays,
    required this.onChanged,
    super.key,
  });

  /// Indices of selected days (0=Mon, 6=Sun).
  final List<int> selectedDays;
  final ValueChanged<List<int>> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(7, (index) {
        final isSelected = selectedDays.contains(index);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.xs / 2),
          child: ElogirPressable(
            onPressed: () {
              final updated = List<int>.from(selectedDays);
              if (isSelected) {
                updated.remove(index);
              } else {
                updated.add(index);
              }
              updated.sort();
              onChanged(updated);
            },
            pressScale: 0.92,
            child: AnimatedContainer(
              duration: theme.durations.fast,
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? theme.colors.primary
                    : theme.colors.surfaceContainer,
                border: isSelected
                    ? null
                    : Border.all(
                        color: theme.colors.outlineVariant,
                        width: theme.strokes.thick,
                      ),
              ),
              alignment: Alignment.center,
              child: Text(
                Alarm.dayLetters[index],
                style: theme.typography.labelMedium.copyWith(
                  color: isSelected
                      ? theme.colors.onPrimary
                      : theme.colors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
