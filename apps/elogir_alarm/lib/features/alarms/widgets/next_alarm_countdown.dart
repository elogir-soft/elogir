import 'dart:async';

import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/shared/extensions/duration_extensions.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Displays the next alarm in a prominent card with time and countdown.
class NextAlarmCountdown extends StatefulWidget {
  const NextAlarmCountdown({required this.alarm, super.key});

  final Alarm alarm;

  @override
  State<NextAlarmCountdown> createState() => _NextAlarmCountdownState();
}

class _NextAlarmCountdownState extends State<NextAlarmCountdown> {
  late Timer _refreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) {
        if (mounted) setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _refreshTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final timeUntil = widget.alarm.timeUntilNext();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(theme.spacing.md),
      decoration: BoxDecoration(
        color: theme.colors.primaryContainer,
        borderRadius: theme.radii.lg,
        border: Border.all(
          color: theme.colors.primary.withValues(alpha: 0.3),
          width: theme.strokes.thick,
        ),
      ),
      child: Row(
        children: [
          // Alarm time - large and prominent.
          ElogirText(
            widget.alarm.timeFormatted,
            variant: ElogirTextVariant.headlineMedium,
            style: TextStyle(
              color: theme.colors.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: theme.spacing.md),
          // Label and countdown.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.alarm.label.isNotEmpty)
                  ElogirText(
                    widget.alarm.label,
                    variant: ElogirTextVariant.bodyMedium,
                    style: TextStyle(
                      color: theme.colors.onPrimaryContainer,
                    ),
                  ),
                ElogirText(
                  timeUntil.relativeFormatted,
                  variant: ElogirTextVariant.labelMedium,
                  style: TextStyle(
                    color: theme.colors.onPrimaryContainer
                        .withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          // Repeat day dots if any.
          if (widget.alarm.repeatDays.isNotEmpty)
            _MiniDayDots(days: widget.alarm.repeatDays),
        ],
      ),
    );
  }
}

class _MiniDayDots extends StatelessWidget {
  const _MiniDayDots({required this.days});

  final List<int> days;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(7, (index) {
        final isActive = days.contains(index);
        return Padding(
          padding: EdgeInsets.only(left: theme.spacing.xxs),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? theme.colors.onPrimaryContainer
                  : theme.colors.onPrimaryContainer.withValues(alpha: 0.2),
            ),
          ),
        );
      }),
    );
  }
}
