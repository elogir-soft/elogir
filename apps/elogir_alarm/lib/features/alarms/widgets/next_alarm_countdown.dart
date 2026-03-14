import 'dart:async';

import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/shared/extensions/duration_extensions.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Displays a countdown to the next alarm.
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
    // Refresh every minute to keep the countdown current.
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
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.md,
        vertical: theme.spacing.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colors.primaryContainer,
        borderRadius: theme.radii.md,
      ),
      child: Column(
        children: [
          ElogirText(
            'Next alarm ${timeUntil.relativeFormatted}',
            variant: ElogirTextVariant.labelLarge,
            style: TextStyle(color: theme.colors.onPrimaryContainer),
          ),
          SizedBox(height: theme.spacing.xxs),
          ElogirText(
            '${widget.alarm.timeFormatted} ${widget.alarm.label}'.trim(),
            variant: ElogirTextVariant.bodySmall,
            style: TextStyle(color: theme.colors.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}
