import 'package:elogir_home/features/automation/models/automation.dart';
import 'package:elogir_home/features/automation/providers/automation_repository_provider.dart';
import 'package:elogir_home/features/automation/widgets/automation_card.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// List of expired (disabled) one-time automations with a
/// "Clear All" button to remove them.
class ExpiredAutomationsList extends ConsumerWidget {
  /// Creates an expired automations list.
  const ExpiredAutomationsList({
    required this.automations,
    super.key,
  });

  /// The expired automations to display.
  final List<Automation> automations;

  Future<void> _clearAll(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await ElogirDialog.show<bool>(
      context: context,
      builder: (context) => ElogirDialog(
        title: const Text('Clear all expired?'),
        content: Text(
          '${automations.length} expired '
          "automation${automations.length == 1 ? '' : 's'}"
          ' will be permanently deleted.',
        ),
        actions: [
          ElogirButton(
            variant: ElogirButtonVariant.outlined,
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElogirButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(automationRepositoryProvider)
          .clearExpired();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (automations.isEmpty) return const _EmptyState();

    final theme = ElogirTheme.of(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
            vertical: theme.spacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: ElogirText(
                  '${automations.length} expired',
                  variant: ElogirTextVariant.bodySmall,
                  style: TextStyle(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ),
              ElogirButton(
                variant: ElogirButtonVariant.outlined,
                size: ElogirButtonSize.sm,
                onPressed: () => _clearAll(context, ref),
                child: const Text('Clear All'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.md,
            ),
            itemCount: automations.length,
            separatorBuilder: (_, _) =>
                SizedBox(height: theme.spacing.sm),
            itemBuilder: (context, index) {
              return Opacity(
                opacity: 0.6,
                child: AutomationCard(
                  automation: automations[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.boxArchive,
            size: 48,
            color: theme.colors.onSurfaceVariant,
          ),
          SizedBox(height: theme.spacing.md),
          const ElogirText(
            'No expired automations',
            variant: ElogirTextVariant.titleMedium,
          ),
          SizedBox(height: theme.spacing.sm),
          ElogirText(
            'Completed one-time automations appear here',
            style: TextStyle(
              color: theme.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
