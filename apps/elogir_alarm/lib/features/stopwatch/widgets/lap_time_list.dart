import 'dart:ui';

import 'package:elogir_alarm/features/stopwatch/models/lap.dart';
import 'package:elogir_alarm/shared/extensions/duration_extensions.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// Scrollable list of lap times with best/worst highlighting.
class LapTimeList extends StatelessWidget {
  const LapTimeList({required this.laps, super.key});

  /// Laps in reverse chronological order (most recent first).
  final List<Lap> laps;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    if (laps.isEmpty) return const SizedBox.shrink();

    // Determine best and worst laps (only highlight when 3+ laps).
    int? bestIndex;
    int? worstIndex;
    if (laps.length >= 3) {
      var bestDelta = laps.first.delta;
      var worstDelta = laps.first.delta;
      for (var i = 0; i < laps.length; i++) {
        if (laps[i].delta < bestDelta) {
          bestDelta = laps[i].delta;
          bestIndex = i;
        }
        if (laps[i].delta > worstDelta) {
          worstDelta = laps[i].delta;
          worstIndex = i;
        }
      }
    }

    final tabularStyle = const TextStyle(
      fontFeatures: [FontFeature.tabularFigures()],
    );

    return Column(
      children: [
        // Header
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
            vertical: theme.spacing.xs,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: ElogirText(
                  'Lap',
                  variant: ElogirTextVariant.labelSmall,
                  style: TextStyle(color: theme.colors.onSurfaceVariant),
                ),
              ),
              Expanded(
                child: ElogirText(
                  'Lap Time',
                  variant: ElogirTextVariant.labelSmall,
                  style: TextStyle(color: theme.colors.onSurfaceVariant),
                ),
              ),
              Expanded(
                child: ElogirText(
                  'Total',
                  variant: ElogirTextVariant.labelSmall,
                  style: TextStyle(color: theme.colors.onSurfaceVariant),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        ElogirDivider(),
        // Lap entries
        Expanded(
          child: ListView.separated(
            itemCount: laps.length,
            separatorBuilder: (_, __) => ElogirDivider(),
            itemBuilder: (context, index) {
              final lap = laps[index];
              final isBest = index == bestIndex;
              final isWorst = index == worstIndex;

              final rowColor = isBest
                  ? theme.colors.success
                  : isWorst
                      ? theme.colors.error
                      : theme.colors.onSurface;

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.md,
                  vertical: theme.spacing.sm,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 48,
                      child: Text(
                        '${lap.number}',
                        style: theme.typography.bodyMedium.copyWith(
                          color: rowColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        lap.delta.stopwatchFormatted,
                        style: theme.typography.bodyMedium
                            .copyWith(color: rowColor)
                            .merge(tabularStyle),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        lap.elapsed.stopwatchFormatted,
                        style: theme.typography.bodyMedium
                            .copyWith(color: rowColor)
                            .merge(tabularStyle),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
