import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/settings/providers/settings_provider.dart';
import 'package:elogir_alarm/shared/extensions/day_index_extensions.dart';
import 'package:elogir_alarm/shared/extensions/duration_extensions.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A card displaying alarm info with toggle, time, label, and repeat days.
class AlarmCard extends ConsumerWidget {
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

  String _formatTime({
    required int hour,
    required int minute,
    required bool use24Hour,
  }) {
    if (use24Hour) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
    final period = hour < 12 ? 'AM' : 'PM';
    final h = hour % 12 == 0 ? 12 : hour % 12;
    return '${h.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  bool _isSnoozed(Alarm alarm) =>
      alarm.snoozedUntil != null &&
      alarm.snoozedUntil!.isAfter(DateTime.now());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ElogirTheme.of(context);
    final settings = ref.watch(settingsProvider).value;
    final use24Hour = settings?.use24HourFormat ?? false;
    final weekStartsOnMonday = settings?.weekStartsOnMonday ?? true;

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
                      _formatTime(
                        hour: alarm.hour,
                        minute: alarm.minute,
                        use24Hour: use24Hour,
                      ),
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
              // Snooze indicator
              if (_isSnoozed(alarm)) ...[
                SizedBox(height: theme.spacing.xs),
                _SnoozeBadge(snoozedUntil: alarm.snoozedUntil!),
              ],
              SizedBox(height: theme.spacing.sm),
              // Bottom row: repeat days + next occurrence
              Row(
                children: [
                  if (alarm.repeatDays.isNotEmpty) ...[
                    _RepeatDayDots(
                      days: alarm.repeatDays,
                      weekStartsOnMonday: weekStartsOnMonday,
                    ),
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
  const _RepeatDayDots({
    required this.days,
    required this.weekStartsOnMonday,
  });

  final List<int> days;
  final bool weekStartsOnMonday;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(7, (displayIndex) {
        final dayIndex =
            displayToDay(displayIndex, weekStartsOnMonday: weekStartsOnMonday);
        final isActive = days.contains(dayIndex);
        return Padding(
          padding: const EdgeInsets.only(right: 3),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? theme.colors.primary
                  : theme.colors.surfaceContainer,
              border: isActive
                  ? null
                  : Border.all(
                      color: theme.colors.outlineVariant,
                      width: theme.strokes.thin,
                    ),
            ),
            alignment: Alignment.center,
            child: Text(
              Alarm.dayLetters[dayIndex],
              style: theme.typography.labelSmall.copyWith(
                fontSize: 9,
                color: isActive
                    ? theme.colors.onPrimary
                    : theme.colors.onSurfaceVariant.withValues(alpha: 0.5),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _SnoozeBadge extends StatelessWidget {
  const _SnoozeBadge({required this.snoozedUntil});

  final DateTime snoozedUntil;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final h = snoozedUntil.hour.toString().padLeft(2, '0');
    final m = snoozedUntil.minute.toString().padLeft(2, '0');

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.sm,
        vertical: theme.spacing.xs,
      ),
      decoration: BoxDecoration(
        color: theme.colors.primaryContainer,
        borderRadius: theme.radii.sm,
      ),
      child: ElogirText(
        'Snoozed until $h:$m',
        variant: ElogirTextVariant.labelSmall,
        style: TextStyle(color: theme.colors.onPrimaryContainer),
      ),
    );
  }
}
