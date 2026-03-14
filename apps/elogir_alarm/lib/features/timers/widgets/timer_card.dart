import 'package:elogir_alarm/features/timers/models/app_timer.dart';
import 'package:elogir_alarm/features/timers/widgets/countdown_ring.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// A compact card for a single timer in the list.
class TimerCard extends StatelessWidget {
  const TimerCard({
    required this.timer,
    required this.onPause,
    required this.onResume,
    required this.onCancel,
    required this.onRemove,
    super.key,
  });

  final AppTimer timer;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onCancel;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirCard(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Row(
        children: [
          // Countdown ring (compact size)
          CountdownRing(
            progress: timer.progress,
            remaining: timer.remaining,
            size: 80,
          ),
          SizedBox(width: theme.spacing.md),
          // Info + controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (timer.label.isNotEmpty)
                  ElogirText(
                    timer.label,
                    variant: ElogirTextVariant.titleSmall,
                  ),
                SizedBox(height: theme.spacing.xs),
                _StatusBadge(status: timer.status),
                SizedBox(height: theme.spacing.sm),
                // Action buttons
                Row(
                  children: [
                    if (timer.status == TimerStatus.running)
                      ElogirButton(
                        onPressed: onPause,
                        variant: ElogirButtonVariant.outlined,
                        size: ElogirButtonSize.sm,
                        child: const Text('Pause'),
                      ),
                    if (timer.status == TimerStatus.paused)
                      ElogirButton(
                        onPressed: onResume,
                        variant: ElogirButtonVariant.outlined,
                        size: ElogirButtonSize.sm,
                        child: const Text('Resume'),
                      ),
                    if (timer.status.isActive) ...[
                      SizedBox(width: theme.spacing.xs),
                      ElogirButton(
                        onPressed: onCancel,
                        variant: ElogirButtonVariant.ghost,
                        size: ElogirButtonSize.sm,
                        child: const Text('Cancel'),
                      ),
                    ],
                    if (!timer.status.isActive)
                      ElogirButton(
                        onPressed: onRemove,
                        variant: ElogirButtonVariant.ghost,
                        size: ElogirButtonSize.sm,
                        child: const Text('Remove'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final TimerStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, variant) = switch (status) {
      TimerStatus.running => ('Running', ElogirTagVariant.primary),
      TimerStatus.paused => ('Paused', ElogirTagVariant.warning),
      TimerStatus.completed => ('Done', ElogirTagVariant.success),
      TimerStatus.cancelled => ('Cancelled', ElogirTagVariant.neutral),
    };

    return ElogirTag(label: label, variant: variant);
  }
}
