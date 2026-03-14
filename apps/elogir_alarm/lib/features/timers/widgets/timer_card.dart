import 'package:elogir_alarm/features/timers/models/app_timer.dart';
import 'package:elogir_alarm/features/timers/widgets/countdown_ring.dart';
import 'package:elogir_alarm/shared/extensions/duration_extensions.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// A timer card. Tap to toggle pause/resume, long press to delete.
class TimerCard extends StatelessWidget {
  const TimerCard({
    required this.timer,
    required this.onPause,
    required this.onResume,
    required this.onRemove,
    super.key,
  });

  final AppTimer timer;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onRemove;

  void _onTap() {
    if (timer.status == TimerStatus.running) {
      onPause();
    } else if (timer.status == TimerStatus.paused) {
      onResume();
    }
  }

  void _onLongPress(BuildContext context) {
    ElogirDialog.show<bool>(
      context: context,
      builder: (context) => ElogirDialog(
        title: const ElogirText(
          'Delete Timer',
          variant: ElogirTextVariant.headlineSmall,
        ),
        content: const ElogirText(
          'Are you sure you want to delete this timer?',
          variant: ElogirTextVariant.bodyMedium,
        ),
        actions: [
          ElogirButton(
            onPressed: () => Navigator.of(context).pop(false),
            variant: ElogirButtonVariant.outlined,
            child: const Text('Cancel'),
          ),
          ElogirButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              onRemove();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final isDone = !timer.status.isActive;

    return AnimatedOpacity(
      duration: theme.durations.normal,
      opacity: isDone ? 0.5 : 1.0,
      child: ElogirPressable(
        onPressed: _onTap,
        onLongPress: () => _onLongPress(context),
        pressScale: 0.96,
        child: ElogirCard(
          padding: EdgeInsets.only(
            left: theme.spacing.md,
            top: theme.spacing.sm,
            bottom: theme.spacing.sm,
            right: theme.spacing.md,
          ),
          child: Row(
            children: [
              // Countdown ring.
              CountdownRing(
                progress: timer.progress,
                remaining: timer.remaining,
                size: 56,
              ),
              SizedBox(width: theme.spacing.md),

              // Label / duration.
              Expanded(
                child: ElogirText(
                  timer.label.isNotEmpty
                      ? timer.label
                      : Duration(milliseconds: timer.durationMs).formatted,
                  variant: ElogirTextVariant.titleSmall,
                ),
              ),

              // Pause indicator when paused.
              if (timer.status == TimerStatus.paused)
                Padding(
                  padding: EdgeInsets.only(left: theme.spacing.sm),
                  child: CustomPaint(
                    size: const Size(12, 16),
                    painter: _PauseIconPainter(
                      color: theme.colors.outlineVariant,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Two vertical bars — the universal pause symbol.
class _PauseIconPainter extends CustomPainter {
  _PauseIconPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final barWidth = size.width * 0.33;
    final gap = size.width - barWidth * 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, barWidth, size.height),
        const Radius.circular(1),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(barWidth + gap, 0, barWidth, size.height),
        const Radius.circular(1),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(_PauseIconPainter old) => color != old.color;
}
