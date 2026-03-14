import 'package:elogir_alarm/features/alarms/providers/alarm_repository_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/alarms_provider.dart';
import 'package:elogir_alarm/features/alarms/screens/alarm_edit_sheet.dart';
import 'package:elogir_alarm/features/alarms/widgets/alarm_card.dart';
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

    return ElogirScaffold(
      appBar: const ElogirAppBar(
        title: ElogirText('Alarms', variant: ElogirTextVariant.titleLarge),
      ),
      body: Stack(
        children: [
          alarmsAsync.when(
            loading: () => const Center(child: ElogirSpinner()),
            error: (error, _) => Center(
              child: ElogirText(
                'Error: $error',
                variant: ElogirTextVariant.bodyMedium,
              ),
            ),
            data: (alarms) {
              if (alarms.isEmpty) {
                return _EmptyState(
                  onAdd: () => showAlarmEditSheet(context: context),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.only(
                  left: theme.spacing.md,
                  right: theme.spacing.md,
                  top: theme.spacing.md,
                  // Extra bottom padding for the floating add button.
                  bottom: 96,
                ),
                itemCount: alarms.length,
                itemBuilder: (context, index) {
                  final alarm = alarms[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: theme.spacing.sm),
                    child: AlarmCard(
                      alarm: alarm,
                      onToggle: (enabled) {
                        ref
                            .read(alarmRepositoryProvider)
                            .toggle(id: alarm.id, isEnabled: enabled);
                      },
                      onTap: () => showAlarmEditSheet(
                        context: context,
                        alarmId: alarm.id,
                      ),
                      onDelete: () =>
                          _confirmDelete(context, ref, alarm.id),
                    ),
                  );
                },
              );
            },
          ),

          // Floating add button at bottom-right.
          Positioned(
            right: theme.spacing.md,
            bottom: theme.spacing.lg,
            child: _AddAlarmButton(
              onPressed: () => showAlarmEditSheet(context: context),
            ),
          ),
        ],
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

class _AddAlarmButton extends StatelessWidget {
  const _AddAlarmButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    return ElogirIconButton(
      onPressed: onPressed,
      variant: ElogirIconButtonVariant.tonal,
      size: ElogirIconButtonSize.lg,
      borderRadius: theme.radii.lg,
      icon: const Text(
        '+',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
        ),
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
