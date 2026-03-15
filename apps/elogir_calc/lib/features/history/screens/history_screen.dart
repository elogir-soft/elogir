import 'package:elogir_calc/features/calculator/providers/calculator_provider.dart';
import 'package:elogir_calc/features/history/providers/history_provider.dart';
import 'package:elogir_calc/features/history/providers/history_repository_provider.dart';
import 'package:elogir_calc/features/history/widgets/history_entry_card.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// History screen showing past calculations.
class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);
    final theme = ElogirTheme.of(context);

    return ElogirScaffold(
      appBar: ElogirAppBar(
        title: const ElogirText(
          'History',
          variant: ElogirTextVariant.titleLarge,
        ),
        trailing: ElogirPressable(
          onPressed: () => _confirmClearAll(context, ref),
          pressScale: 0.9,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.sm,
            ),
            child: Text(
              'Clear',
              style: theme.typography.labelLarge.copyWith(
                color: theme.colors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: historyAsync.when(
        data: (entries) {
          if (entries.isEmpty) {
            return const Center(
              child: ElogirText(
                'No calculations yet',
                variant: ElogirTextVariant.bodyLarge,
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(theme.spacing.sm),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Padding(
                padding: EdgeInsets.only(bottom: theme.spacing.xs),
                child: HistoryEntryCard(
                  calculation: entry,
                  onTap: () {
                    ref
                        .read(calculatorProvider.notifier)
                        .loadCalculation(entry.expression);
                    context.go('/calculator');
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: ElogirText(
            'Loading...',
            variant: ElogirTextVariant.bodyLarge,
          ),
        ),
        error: (error, _) => const Center(
          child: ElogirText(
            'Error loading history',
            variant: ElogirTextVariant.bodyLarge,
          ),
        ),
      ),
    );
  }

  void _confirmClearAll(BuildContext context, WidgetRef ref) {
    ElogirDialog.show<bool>(
      context: context,
      builder: (context) => ElogirDialog(
        title: const ElogirText(
          'Clear History',
          variant: ElogirTextVariant.headlineSmall,
        ),
        content: const ElogirText(
          'Delete all calculation history? '
          'This cannot be undone.',
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
              ref.read(historyRepositoryProvider).deleteAll();
              Navigator.of(context).pop(true);
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
