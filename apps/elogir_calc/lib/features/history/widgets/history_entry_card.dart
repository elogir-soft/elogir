import 'package:elogir_calc/features/history/models/calculation.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';

/// A tappable card showing a past calculation.
class HistoryEntryCard extends StatelessWidget {
  const HistoryEntryCard({
    required this.calculation,
    required this.onTap,
    super.key,
  });

  final Calculation calculation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirPressable(
      onPressed: onTap,
      pressScale: 0.98,
      child: ElogirCard(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
            vertical: theme.spacing.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                calculation.expression,
                style: theme.typography.bodyMedium.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
                textAlign: TextAlign.right,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: theme.spacing.xxs),
              Text(
                '= ${calculation.result}',
                style: theme.typography.titleLarge.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
