import 'package:elogir_home/features/automation/models/automation.dart';
import 'package:elogir_home/features/automation/widgets/automation_card.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

/// Scrollable list of recurring automations.
class RecurringAutomationsList extends StatelessWidget {
  const RecurringAutomationsList({required this.automations, super.key});

  final List<Automation> automations;

  @override
  Widget build(BuildContext context) {
    if (automations.isEmpty) return const _EmptyState();

    final theme = ElogirTheme.of(context);

    return ListView.separated(
      padding: EdgeInsets.all(theme.spacing.md),
      itemCount: automations.length,
      separatorBuilder: (_, _) => SizedBox(height: theme.spacing.sm),
      itemBuilder: (context, index) {
        return AutomationCard(automation: automations[index]);
      },
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
            FontAwesomeIcons.repeat,
            size: 48,
            color: theme.colors.onSurfaceVariant,
          ),
          SizedBox(height: theme.spacing.md),
          const ElogirText(
            'No recurring automations',
            variant: ElogirTextVariant.titleMedium,
          ),
          SizedBox(height: theme.spacing.sm),
          ElogirText(
            'Tap + to create one',
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
          SizedBox(height: theme.spacing.lg),
          ElogirButton(
            onPressed: () => context.go('/add-automation'),
            child: const Text('Add Automation'),
          ),
        ],
      ),
    );
  }
}
