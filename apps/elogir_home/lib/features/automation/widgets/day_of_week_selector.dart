import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// A row of 7 toggle buttons for selecting days of the week.
///
/// Days use ISO numbering: 1 = Monday … 7 = Sunday.
/// Display order respects [weekStartsOnMonday].
class DayOfWeekSelector extends StatelessWidget {
  /// Creates a day of week selector.
  const DayOfWeekSelector({
    required this.selectedDays,
    required this.onChanged,
    required this.weekStartsOnMonday,
    super.key,
  });

  /// Currently selected days (ISO: 1=Mon … 7=Sun).
  final List<int> selectedDays;

  /// Called with the updated list when a day is toggled.
  final ValueChanged<List<int>> onChanged;

  /// Whether the row starts on Monday or Sunday.
  final bool weekStartsOnMonday;

  // Labels indexed by ISO weekday.
  static const _labels = {
    1: 'M', 2: 'T', 3: 'W', 4: 'T',
    5: 'F', 6: 'S', 7: 'S',
  };

  /// Maps display position to ISO weekday.
  int _displayToDay(int displayIndex) {
    if (weekStartsOnMonday) return displayIndex + 1;
    return displayIndex == 0 ? 7 : displayIndex;
  }

  void _toggle(int day) {
    final updated = List.of(selectedDays);
    if (updated.contains(day)) {
      updated.remove(day);
    } else {
      updated.add(day);
    }
    updated.sort();
    onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final day = _displayToDay(index);
        final isSelected = selectedDays.contains(day);

        return ElogirPressable(
          onPressed: () => _toggle(day),
          pressScale: 0.9,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colors.primary
                  : theme.colors.surfaceContainer,
              borderRadius: theme.radii.full,
              border: Border.all(
                color: isSelected
                    ? theme.colors.primary
                    : theme.colors.outlineVariant,
                width: theme.strokes.medium,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              _labels[day]!,
              style: theme.typography.labelMedium.copyWith(
                color: isSelected
                    ? theme.colors.onPrimary
                    : theme.colors.onSurfaceVariant,
                fontWeight: isSelected
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ),
        );
      }),
    );
  }
}
