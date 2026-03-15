import 'package:elogir_home/features/automation/models/automation.dart';
import 'package:elogir_home/features/automation/models/automation_action.dart';
import 'package:elogir_home/features/automation/models/automation_trigger.dart';
import 'package:elogir_home/features/automation/providers/automation_repository_provider.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Card displaying an automation's name, trigger summary, action summary,
/// and an enable/disable toggle.
///
/// - Tap navigates to the edit screen.
/// - Long press shows a delete confirmation dialog.
class AutomationCard extends ConsumerWidget {
  /// Creates an automation card.
  const AutomationCard({required this.automation, super.key});

  /// The automation to display.
  final Automation automation;

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await ElogirDialog.show<bool>(
      context: context,
      builder: (context) => ElogirDialog(
        title: const Text('Delete automation?'),
        content: Text(
          '"${automation.name}" will be permanently deleted.',
        ),
        actions: [
          ElogirButton(
            variant: ElogirButtonVariant.outlined,
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElogirButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(automationRepositoryProvider)
          .delete(automation.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ElogirTheme.of(context);

    return ElogirPressable(
      onPressed: () =>
          context.go('/edit-automation/${automation.id}'),
      onLongPress: () => _confirmDelete(context, ref),
      pressScale: 0.98,
      child: ElogirCard(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElogirText(
                    automation.name.isEmpty
                        ? _actionsSummary(automation.actions)
                        : automation.name,
                    variant: ElogirTextVariant.bodyLarge,
                    style: TextStyle(
                      color: automation.isEnabled
                          ? theme.colors.onSurface
                          : theme.colors.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: theme.spacing.xxs),
                  ElogirText(
                    _triggerSummary(automation.trigger),
                    variant: ElogirTextVariant.bodySmall,
                    style: TextStyle(
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                  if (automation.name.isNotEmpty) ...[
                    SizedBox(height: theme.spacing.xxs),
                    ElogirText(
                      _actionsSummary(automation.actions),
                      variant: ElogirTextVariant.bodySmall,
                      style: TextStyle(
                        color: theme.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: theme.spacing.sm),
            ElogirSwitch(
              value: automation.isEnabled,
              onChanged: (value) async {
                await ref
                    .read(automationRepositoryProvider)
                    .toggle(
                      id: automation.id,
                      isEnabled: value,
                    );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _triggerSummary(AutomationTrigger trigger) {
    return switch (trigger) {
      RecurringTrigger(
        :final hour,
        :final minute,
        :final repeatDays,
      ) =>
        () {
          final h = hour.toString().padLeft(2, '0');
          final m = minute.toString().padLeft(2, '0');
          final time = '$h:$m';
          if (repeatDays.isEmpty) return '$time every day';
          final days =
              repeatDays.map(_dayLabel).join(', ');
          return '$time on $days';
        }(),
      OneTimeTrigger(:final scheduledAt) => () {
          final date =
              '${scheduledAt.day}/${scheduledAt.month}'
              '/${scheduledAt.year}';
          final h =
              scheduledAt.hour.toString().padLeft(2, '0');
          final m = scheduledAt.minute
              .toString()
              .padLeft(2, '0');
          return '$date at $h:$m';
        }(),
      _ => 'Unknown trigger',
    };
  }

  String _actionsSummary(List<AutomationAction> actions) {
    if (actions.isEmpty) return 'No actions';
    if (actions.length == 1) return _actionLabel(actions.first);
    return '${_actionLabel(actions.first)} '
        '+${actions.length - 1} more';
  }

  String _actionLabel(AutomationAction action) {
    return switch (action) {
      TurnOnAction() => 'Turn on light',
      TurnOffAction() => 'Turn off light',
      SetBrightnessAction(:final percentage) =>
        'Brightness $percentage%',
      SetColorAction() => 'Set color',
      SetColorTemperatureAction(:final percentage) =>
        'Color temp $percentage%',
      OpenCoverAction() => 'Open cover',
      CloseCoverAction() => 'Close cover',
      SwitchOnAction() => 'Switch on',
      SwitchOffAction() => 'Switch off',
      _ => 'Unknown action',
    };
  }

  static const _dayLabels = {
    1: 'Mon',
    2: 'Tue',
    3: 'Wed',
    4: 'Thu',
    5: 'Fri',
    6: 'Sat',
    7: 'Sun',
  };

  String _dayLabel(int day) => _dayLabels[day] ?? '?';
}
