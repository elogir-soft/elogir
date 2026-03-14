import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/shared/extensions/duration_extensions.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// A card displaying alarm info with toggle, time, label, and repeat days.
class AlarmCard extends StatelessWidget {
  const AlarmCard({
    required this.alarm,
    required this.onToggle,
    required this.onTap,
    required this.onDelete,
    super.key,
  });

  final Alarm alarm;
  final ValueChanged<bool> onToggle;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirPressable(
      onPressed: onTap,
      onLongPress: onDelete,
      child: AnimatedOpacity(
        duration: theme.durations.normal,
        opacity: alarm.isEnabled ? 1.0 : 0.5,
        child: ElogirCard(
          padding: EdgeInsets.all(theme.spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: time + toggle
              Row(
                children: [
                  Expanded(
                    child: ElogirText(
                      alarm.timeFormatted,
                      variant: ElogirTextVariant.displaySmall,
                    ),
                  ),
                  ElogirSwitch(
                    value: alarm.isEnabled,
                    onChanged: onToggle,
                  ),
                ],
              ),
              // Label
              if (alarm.label.isNotEmpty) ...[
                SizedBox(height: theme.spacing.xs),
                ElogirText(
                  alarm.label,
                  variant: ElogirTextVariant.bodyMedium,
                  style: TextStyle(color: theme.colors.onSurfaceVariant),
                ),
              ],
              SizedBox(height: theme.spacing.sm),
              // Bottom row: repeat days + next occurrence
              Row(
                children: [
                  if (alarm.repeatDays.isNotEmpty) ...[
                    _RepeatDayDots(days: alarm.repeatDays),
                    SizedBox(width: theme.spacing.sm),
                  ],
                  if (alarm.isEnabled)
                    ElogirText(
                      alarm.timeUntilNext().relativeFormatted,
                      variant: ElogirTextVariant.caption,
                      style: TextStyle(color: theme.colors.onSurfaceVariant),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RepeatDayDots extends StatelessWidget {
  const _RepeatDayDots({required this.days});

  final List<int> days;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(7, (index) {
        final isActive = days.contains(index);
        return Padding(
          padding: EdgeInsets.only(right: theme.spacing.xxs),
          child: ElogirText(
            Alarm.dayLetters[index],
            variant: ElogirTextVariant.caption,
            style: TextStyle(
              color: isActive
                  ? theme.colors.primary
                  : theme.colors.onSurfaceVariant.withValues(alpha: 0.4),
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        );
      }),
    );
  }
}
