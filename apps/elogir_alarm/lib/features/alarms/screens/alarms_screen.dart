import 'package:elogir_alarm/features/alarms/providers/alarm_repository_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/alarms_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/next_alarm_provider.dart';
import 'package:elogir_alarm/features/alarms/widgets/alarm_card.dart';
import 'package:elogir_alarm/features/alarms/widgets/next_alarm_countdown.dart';
import 'package:elogir_alarm/routing/routes.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Main screen showing all alarms with a next-alarm banner.
class AlarmsScreen extends ConsumerWidget {
  const AlarmsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ElogirTheme.of(context);
    final alarmsAsync = ref.watch(alarmsProvider);
    final nextAlarm = ref.watch(nextAlarmProvider);

    return ElogirScaffold(
      appBar: ElogirAppBar(
        title: const ElogirText(
          'Alarms',
          variant: ElogirTextVariant.titleLarge,
        ),
        trailing: ElogirButton(
          onPressed: () => AlarmNewRoute().go(context),
          variant: ElogirButtonVariant.ghost,
          size: ElogirButtonSize.sm,
          child: const Text('+'),
        ),
      ),
      body: alarmsAsync.when(
        loading: () => const Center(child: ElogirSpinner()),
        error: (error, _) => Center(
          child: ElogirText('Error: $error', variant: ElogirTextVariant.bodyMedium),
        ),
        data: (alarms) {
          if (alarms.isEmpty) {
            return _EmptyState(
              onAdd: () => AlarmNewRoute().go(context),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(theme.spacing.md),
            itemCount: alarms.length + (nextAlarm != null ? 1 : 0),
            itemBuilder: (context, index) {
              // Next alarm banner at top.
              if (nextAlarm != null && index == 0) {
                return Padding(
                  padding: EdgeInsets.only(bottom: theme.spacing.md),
                  child: NextAlarmCountdown(alarm: nextAlarm),
                );
              }

              final alarmIndex = nextAlarm != null ? index - 1 : index;
              final alarm = alarms[alarmIndex];

              return Padding(
                padding: EdgeInsets.only(bottom: theme.spacing.sm),
                child: AlarmCard(
                  alarm: alarm,
                  onToggle: (enabled) {
                    ref
                        .read(alarmRepositoryProvider)
                        .toggle(id: alarm.id, isEnabled: enabled);
                  },
                  onTap: () => AlarmEditRoute(alarmId: alarm.id).go(context),
                  onDelete: () => _confirmDelete(context, ref, alarm.id),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String id) {
    ElogirDialog.show<bool>(
      context: context,
      builder: (context) => ElogirDialog(
        title: const ElogirText(
          'Delete Alarm',
          variant: ElogirTextVariant.headlineSmall,
        ),
        content: const ElogirText(
          'Are you sure you want to delete this alarm?',
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
              ref.read(alarmRepositoryProvider).delete(id);
              Navigator.of(context).pop(true);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElogirText(
            'No alarms set',
            variant: ElogirTextVariant.headlineSmall,
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
          SizedBox(height: theme.spacing.md),
          ElogirButton(
            onPressed: onAdd,
            child: const Text('Add Alarm'),
          ),
        ],
      ),
    );
  }
}
