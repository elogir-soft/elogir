import 'dart:async';

import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/automation/models/add_automation_state.dart';
import 'package:elogir_home/features/automation/models/automation.dart';
import 'package:elogir_home/features/automation/models/automation_action.dart';
import 'package:elogir_home/features/automation/models/automation_trigger.dart';
import 'package:elogir_home/features/automation/providers/automation_repository_provider.dart';
import 'package:elogir_home/features/automation/widgets/action_picker.dart';
import 'package:elogir_home/features/automation/widgets/action_summary_tile.dart';
import 'package:elogir_home/features/automation/widgets/day_of_week_selector.dart';
import 'package:elogir_home/features/automation/widgets/device_picker.dart';
import 'package:elogir_home/features/automation/widgets/time_picker_wheel.dart';
import 'package:elogir_home/features/settings/providers/settings_provider.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

/// Multi-step flow for creating or editing an automation.
///
/// Steps:
/// 0 — Trigger: recurring/one-time selection + time/date configuration
/// 1 — Actions: pick devices and actions
/// 2 — Name + confirm: enter name, review, save
class AddAutomationScreen extends ConsumerStatefulWidget {
  /// Creates the add/edit automation screen.
  ///
  /// If [automationId] is provided, the screen loads the existing
  /// automation for editing.
  const AddAutomationScreen({this.automationId, super.key});

  /// Optional ID of an existing automation to edit.
  final String? automationId;

  @override
  ConsumerState<AddAutomationScreen> createState() =>
      _AddAutomationScreenState();
}

class _AddAutomationScreenState extends ConsumerState<AddAutomationScreen> {
  AddAutomationState _state = AddAutomationState(
    scheduledAt: DateTime.now().add(const Duration(hours: 1)),
  );

  final _nameController = TextEditingController();
  bool _isLoading = false;
  String? _existingId;
  DateTime? _existingCreatedAt;

  bool get _isEditing => widget.automationId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      unawaited(_loadExisting());
    }
  }

  Future<void> _loadExisting() async {
    setState(() => _isLoading = true);
    final automation = await ref
        .read(automationRepositoryProvider)
        .getById(widget.automationId!);

    if (automation == null || !mounted) {
      if (mounted) context.go('/automation');
      return;
    }

    _existingId = automation.id;
    _existingCreatedAt = automation.createdAt;
    _nameController.text = automation.name;

    setState(() {
      _state = switch (automation.trigger) {
        RecurringTrigger(
          :final hour,
          :final minute,
          :final repeatDays,
        ) =>
          _state.copyWith(
            isRecurring: true,
            hour: hour,
            minute: minute,
            repeatDays: repeatDays,
            actions: automation.actions,
          ),
        OneTimeTrigger(:final scheduledAt) => _state.copyWith(
            isRecurring: false,
            scheduledAt: scheduledAt,
            actions: automation.actions,
          ),
        _ => _state.copyWith(actions: automation.actions),
      };
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _goBack() {
    if (_state.currentStep > 0) {
      setState(() {
        _state = _state.copyWith(
          currentStep: _state.currentStep - 1,
        );
      });
    } else {
      context.go('/automation');
    }
  }

  void _goForward() {
    if (_state.currentStep < 2) {
      setState(() {
        _state = _state.copyWith(
          currentStep: _state.currentStep + 1,
        );
      });
    }
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (_state.actions.isEmpty) return;

    final now = DateTime.now();
    final trigger = _state.isRecurring
        ? AutomationTrigger.recurring(
            hour: _state.hour,
            minute: _state.minute,
            repeatDays: _state.repeatDays,
          )
        : AutomationTrigger.oneTime(
            scheduledAt: _state.scheduledAt!,
          );

    final automation = Automation(
      id: _existingId ?? const Uuid().v4(),
      name: name,
      trigger: trigger,
      actions: _state.actions,
      createdAt: _existingCreatedAt ?? now,
      updatedAt: now,
    );

    await ref.read(automationRepositoryProvider).save(automation);

    if (mounted) {
      context.go('/automation');
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = _isEditing ? 'Edit Automation' : 'Add Automation';

    if (_isLoading) {
      return ElogirScaffold(
        appBar: ElogirAppBar(
          title: ElogirText(
            title,
            variant: ElogirTextVariant.titleLarge,
          ),
          leading: ElogirIconButton(
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              size: 18,
            ),
            onPressed: _goBack,
          ),
        ),
        body: const Center(child: ElogirSpinner()),
      );
    }

    return ElogirScaffold(
      appBar: ElogirAppBar(
        title: ElogirText(
          title,
          variant: ElogirTextVariant.titleLarge,
        ),
        leading: ElogirIconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, size: 18),
          onPressed: _goBack,
        ),
      ),
      body: switch (_state.currentStep) {
        0 => _TriggerStep(
            state: _state,
            onStateChanged: (s) => setState(() => _state = s),
            onNext: _goForward,
          ),
        1 => _ActionsStep(
            actions: _state.actions,
            onActionsChanged: (actions) => setState(() {
              _state = _state.copyWith(actions: actions);
            }),
            onNext: _goForward,
          ),
        2 => _ConfirmStep(
            state: _state,
            nameController: _nameController,
            onSave: _save,
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

// -- Step 0: Trigger --

class _TriggerStep extends ConsumerWidget {
  const _TriggerStep({
    required this.state,
    required this.onStateChanged,
    required this.onNext,
  });

  final AddAutomationState state;
  final ValueChanged<AddAutomationState> onStateChanged;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ElogirTheme.of(context);
    final use24h = ref.watch(
      settingsProvider.select(
        (s) => s.value?.use24HourFormat ?? false,
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ElogirText(
            'Trigger type',
            variant: ElogirTextVariant.labelLarge,
          ),
          SizedBox(height: theme.spacing.sm),
          ElogirTabBar(
            indicatorStyle: ElogirTabIndicatorStyle.pill,
            selectedIndex: state.isRecurring ? 0 : 1,
            onChanged: (i) => onStateChanged(
              state.copyWith(isRecurring: i == 0),
            ),
            tabs: const [
              ElogirTab(label: 'Recurring'),
              ElogirTab(label: 'One-time'),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          if (state.isRecurring) ...[
            const ElogirText(
              'Time',
              variant: ElogirTextVariant.labelLarge,
            ),
            SizedBox(height: theme.spacing.sm),
            Center(
              child: TimePickerWheel(
                hour: state.hour,
                minute: state.minute,
                use24HourFormat: use24h,
                onTimeChanged: (h, m) => onStateChanged(
                  state.copyWith(hour: h, minute: m),
                ),
              ),
            ),
            SizedBox(height: theme.spacing.lg),
            const ElogirText(
              'Repeat on',
              variant: ElogirTextVariant.labelLarge,
            ),
            SizedBox(height: theme.spacing.sm),
            ElogirText(
              'Leave empty for every day',
              variant: ElogirTextVariant.bodySmall,
              style: TextStyle(
                color: theme.colors.onSurfaceVariant,
              ),
            ),
            SizedBox(height: theme.spacing.sm),
            DayOfWeekSelector(
              selectedDays: state.repeatDays,
              onChanged: (days) => onStateChanged(
                state.copyWith(repeatDays: days),
              ),
            ),
          ] else ...[
            const ElogirText(
              'Date',
              variant: ElogirTextVariant.labelLarge,
            ),
            SizedBox(height: theme.spacing.sm),
            ElogirDatePicker(
              value: state.scheduledAt,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(
                const Duration(days: 365),
              ),
              onChanged: (date) {
                final current =
                    state.scheduledAt ?? DateTime.now();
                onStateChanged(
                  state.copyWith(
                    scheduledAt: DateTime(
                      date.year,
                      date.month,
                      date.day,
                      current.hour,
                      current.minute,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: theme.spacing.md),
            const ElogirText(
              'Time',
              variant: ElogirTextVariant.labelLarge,
            ),
            SizedBox(height: theme.spacing.sm),
            Center(
              child: TimePickerWheel(
                hour: state.scheduledAt?.hour ?? 0,
                minute: state.scheduledAt?.minute ?? 0,
                use24HourFormat: use24h,
                onTimeChanged: (h, m) {
                  final current =
                      state.scheduledAt ?? DateTime.now();
                  onStateChanged(
                    state.copyWith(
                      scheduledAt: DateTime(
                        current.year,
                        current.month,
                        current.day,
                        h,
                        m,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          SizedBox(height: theme.spacing.xl),
          SizedBox(
            width: double.infinity,
            child: ElogirButton(
              onPressed: onNext,
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}

// -- Step 1: Actions --

class _ActionsStep extends StatefulWidget {
  const _ActionsStep({
    required this.actions,
    required this.onActionsChanged,
    required this.onNext,
  });

  final List<AutomationAction> actions;
  final ValueChanged<List<AutomationAction>> onActionsChanged;
  final VoidCallback onNext;

  @override
  State<_ActionsStep> createState() => _ActionsStepState();
}

class _ActionsStepState extends State<_ActionsStep> {
  SmartDevice? _selectedDevice;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Show configured actions.
          if (widget.actions.isNotEmpty) ...[
            const ElogirText(
              'Configured actions',
              variant: ElogirTextVariant.labelLarge,
            ),
            SizedBox(height: theme.spacing.sm),
            ...widget.actions.asMap().entries.map(
                  (entry) => Padding(
                    padding: EdgeInsets.only(bottom: theme.spacing.sm),
                    child: ActionSummaryTile(
                      action: entry.value,
                      onRemove: () {
                        final updated = List.of(widget.actions)
                          ..removeAt(entry.key);
                        widget.onActionsChanged(updated);
                      },
                    ),
                  ),
                ),
            SizedBox(height: theme.spacing.md),
          ],

          // Pick a device, then show actions for it.
          if (_selectedDevice == null) ...[
            const ElogirText(
              'Select a device',
              variant: ElogirTextVariant.labelLarge,
            ),
            SizedBox(height: theme.spacing.sm),
            DevicePicker(
              onDeviceSelected: (device) {
                setState(() => _selectedDevice = device);
              },
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: ElogirText(
                    'Action for ${_selectedDevice!.name}',
                    variant: ElogirTextVariant.labelLarge,
                  ),
                ),
                ElogirIconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    size: 14,
                    color: theme.colors.onSurfaceVariant,
                  ),
                  onPressed: () => setState(() => _selectedDevice = null),
                ),
              ],
            ),
            SizedBox(height: theme.spacing.sm),
            ActionPicker(
              device: _selectedDevice!,
              onActionSelected: (action) {
                widget.onActionsChanged([...widget.actions, action]);
                setState(() => _selectedDevice = null);
              },
            ),
          ],

          SizedBox(height: theme.spacing.xl),
          if (widget.actions.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: ElogirButton(
                onPressed: widget.onNext,
                child: const Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}

// -- Step 2: Name + Confirm --

class _ConfirmStep extends StatelessWidget {
  const _ConfirmStep({
    required this.state,
    required this.nameController,
    required this.onSave,
  });

  final AddAutomationState state;
  final TextEditingController nameController;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ElogirText('Name', variant: ElogirTextVariant.labelLarge),
          SizedBox(height: theme.spacing.sm),
          ElogirTextField(
            controller: nameController,
            hint: 'e.g. Morning lights',
          ),
          SizedBox(height: theme.spacing.lg),
          const ElogirText('Summary', variant: ElogirTextVariant.labelLarge),
          SizedBox(height: theme.spacing.sm),
          ElogirCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElogirText(
                  state.isRecurring ? 'Recurring' : 'One-time',
                  style: TextStyle(color: theme.colors.primary),
                ),
                SizedBox(height: theme.spacing.xs),
                ElogirText(
                  _triggerSummary(),
                  variant: ElogirTextVariant.bodySmall,
                  style: TextStyle(color: theme.colors.onSurfaceVariant),
                ),
                SizedBox(height: theme.spacing.sm),
                ElogirText(
                  '${state.actions.length} '
                  "action${state.actions.length == 1 ? '' : 's'}",
                  variant: ElogirTextVariant.bodySmall,
                  style: TextStyle(color: theme.colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          SizedBox(height: theme.spacing.xl),
          SizedBox(
            width: double.infinity,
            child: ElogirButton(
              onPressed: onSave,
              child: const Text('Save Automation'),
            ),
          ),
        ],
      ),
    );
  }

  String _triggerSummary() {
    if (state.isRecurring) {
      final time =
          '${state.hour.toString().padLeft(2, '0')}'
          ':${state.minute.toString().padLeft(2, '0')}';
      if (state.repeatDays.isEmpty) return '$time every day';
      const labels = {
        1: 'Mon', 2: 'Tue', 3: 'Wed', 4: 'Thu',
        5: 'Fri', 6: 'Sat', 7: 'Sun',
      };
      final days = state.repeatDays
          .map((d) => labels[d] ?? '?')
          .join(', ');
      return '$time on $days';
    }
    final dt = state.scheduledAt;
    if (dt == null) return 'Not set';
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '${dt.day}/${dt.month}/${dt.year} at $h:$m';
  }
}
