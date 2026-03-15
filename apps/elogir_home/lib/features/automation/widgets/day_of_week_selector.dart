import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// A row of 7 toggle buttons for selecting days of the week.
///
/// Days use ISO numbering: 1 = Monday … 7 = Sunday.
class DayOfWeekSelector extends StatelessWidget {
  const DayOfWeekSelector({
    required this.selectedDays,
    required this.onChanged,
    super.key,
  });

  final List<int> selectedDays;
  final ValueChanged<List<int>> onChanged;

  static const _labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

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
        final day = index + 1;
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
              _labels[index],
              style: theme.typography.labelMedium.copyWith(
                color: isSelected
                    ? theme.colors.onPrimary
                    : theme.colors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        );
      }),
    );
  }
}
