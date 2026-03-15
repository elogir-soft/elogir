import 'package:elogir_home/features/automation/models/automation.dart';
import 'package:elogir_home/features/automation/models/automation_action.dart';
import 'package:elogir_home/features/automation/models/automation_trigger.dart';
import 'package:elogir_home/features/automation/providers/automation_repository_provider.dart';
import 'package:elogir_home/features/settings/providers/settings_provider.dart';
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
    final label = automation.name.isEmpty
        ? _actionsSummary(automation.actions)
        : automation.name;
    final confirmed = await ElogirDialog.show<bool>(
      context: context,
      builder: (context) => ElogirDialog(
        title: const Text('Delete automation?'),
        content: Text(
          '"$label" will be permanently deleted.',
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
    final use24h = ref.watch(
      settingsProvider.select(
        (s) => s.value?.use24HourFormat ?? false,
      ),
    );

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
                    _timeSummary(
                      automation.trigger,
                      use24h: use24h,
                    ),
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
                  // Show day dots for recurring triggers with
                  // specific repeat days.
                  if (automation.trigger
                      is RecurringTrigger) ...[
                    SizedBox(height: theme.spacing.sm),
                    _RepeatDayDots(
                      days: (automation.trigger
                              as RecurringTrigger)
                          .repeatDays,
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

  String _formatTime(int hour, int minute, {required bool use24h}) {
    if (use24h) {
      final h = hour.toString().padLeft(2, '0');
      final m = minute.toString().padLeft(2, '0');
      return '$h:$m';
    }
    final period = hour < 12 ? 'AM' : 'PM';
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final m = minute.toString().padLeft(2, '0');
    return '${h.toString().padLeft(2, '0')}:$m $period';
  }

  String _timeSummary(
    AutomationTrigger trigger, {
    required bool use24h,
  }) {
    return switch (trigger) {
      RecurringTrigger(
        :final hour,
        :final minute,
        :final repeatDays,
      ) =>
        () {
          final time = _formatTime(hour, minute, use24h: use24h);
          if (repeatDays.isEmpty) return '$time every day';
          return time;
        }(),
      OneTimeTrigger(:final scheduledAt) => () {
          final date =
              '${scheduledAt.day}/${scheduledAt.month}'
              '/${scheduledAt.year}';
          final time = _formatTime(
            scheduledAt.hour,
            scheduledAt.minute,
            use24h: use24h,
          );
          return '$date at $time';
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
}

/// Small circular day indicators matching the alarm card pattern.
///
/// Automation uses 1-based days (1=Mon … 7=Sun).
class _RepeatDayDots extends StatelessWidget {
  const _RepeatDayDots({required this.days});

  final List<int> days;

  // Single-letter labels indexed by ISO weekday (1=Mon … 7=Sun).
  static const _letters = {
    1: 'M',
    2: 'T',
    3: 'W',
    4: 'T',
    5: 'F',
    6: 'S',
    7: 'S',
  };

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(7, (index) {
        final day = index + 1; // 1=Mon … 7=Sun
        final isActive = days.contains(day);
        return Padding(
          padding: const EdgeInsets.only(right: 3),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? theme.colors.primary
                  : theme.colors.surfaceContainer,
              border: isActive
                  ? null
                  : Border.all(
                      color: theme.colors.outlineVariant,
                      width: theme.strokes.thin,
                    ),
            ),
            alignment: Alignment.center,
            child: Text(
              _letters[day]!,
              style: theme.typography.labelSmall.copyWith(
                fontSize: 9,
                color: isActive
                    ? theme.colors.onPrimary
                    : theme.colors.onSurfaceVariant
                        .withValues(alpha: 0.5),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }),
    );
  }
}
