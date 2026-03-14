import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/alarms/providers/alarm_repository_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/alarms_provider.dart';
import 'package:elogir_alarm/features/alarms/widgets/day_of_week_selector.dart';
import 'package:elogir_alarm/features/alarms/widgets/sound_selector.dart';
import 'package:elogir_alarm/features/alarms/widgets/time_picker_wheel.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

/// Screen for creating or editing an alarm.
class AlarmEditScreen extends ConsumerStatefulWidget {
  const AlarmEditScreen({this.alarmId, super.key});

  /// If null, we're creating a new alarm. Otherwise editing.
  final String? alarmId;

  @override
  ConsumerState<AlarmEditScreen> createState() => _AlarmEditScreenState();
}

class _AlarmEditScreenState extends ConsumerState<AlarmEditScreen> {
  static const _uuid = Uuid();

  late final TextEditingController _labelController;
  int _hour = 8;
  int _minute = 0;
  List<int> _repeatDays = [];
  String _soundId = 'alarm';
  int _snoozeDuration = 5;
  bool _initialized = false;

  bool get _isEditing => widget.alarmId != null;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController();
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  void _initFromAlarm(Alarm alarm) {
    if (_initialized) return;
    _initialized = true;
    _hour = alarm.hour;
    _minute = alarm.minute;
    _labelController.text = alarm.label;
    _repeatDays = List.from(alarm.repeatDays);
    _soundId = alarm.soundId;
    _snoozeDuration = alarm.snoozeDurationMinutes;
  }

  Future<void> _save() async {
    final now = DateTime.now();
    final alarm = Alarm(
      id: widget.alarmId ?? _uuid.v4(),
      hour: _hour,
      minute: _minute,
      label: _labelController.text.trim(),
      repeatDays: _repeatDays,
      soundId: _soundId,
      snoozeDurationMinutes: _snoozeDuration,
      createdAt: _isEditing ? now : now, // Keep original on edit ideally
      updatedAt: now,
    );

    await ref.read(alarmRepositoryProvider).save(alarm);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    if (widget.alarmId == null) return;

    final confirmed = await ElogirDialog.show<bool>(
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
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(alarmRepositoryProvider).delete(widget.alarmId!);
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    // If editing, watch the alarm to init form fields.
    if (_isEditing) {
      final alarmsAsync = ref.watch(alarmsProvider);
      alarmsAsync.whenData((alarms) {
        final existing = alarms
            .where((a) => a.id == widget.alarmId)
            .firstOrNull;
        if (existing != null) _initFromAlarm(existing);
      });
    }

    return ElogirScaffold(
      appBar: ElogirAppBar(
        leading: ElogirButton(
          onPressed: () => Navigator.of(context).pop(),
          variant: ElogirButtonVariant.ghost,
          size: ElogirButtonSize.sm,
          child: const Text('Back'),
        ),
        title: ElogirText(
          _isEditing ? 'Edit Alarm' : 'New Alarm',
          variant: ElogirTextVariant.titleLarge,
        ),
        trailing: ElogirButton(
          onPressed: _save,
          size: ElogirButtonSize.sm,
          child: const Text('Save'),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(theme.spacing.md),
        children: [
          // Time picker
          TimePickerWheel(
            hour: _hour,
            minute: _minute,
            onTimeChanged: (h, m) => setState(() {
              _hour = h;
              _minute = m;
            }),
          ),
          SizedBox(height: theme.spacing.lg),

          // Label
          ElogirTextField(
            controller: _labelController,
            label: 'Label',
            hint: 'e.g. Wake up, Workout',
          ),
          SizedBox(height: theme.spacing.lg),

          // Repeat days
          ElogirText(
            'Repeat',
            variant: ElogirTextVariant.labelMedium,
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
          SizedBox(height: theme.spacing.sm),
          DayOfWeekSelector(
            selectedDays: _repeatDays,
            onChanged: (days) => setState(() => _repeatDays = days),
          ),
          SizedBox(height: theme.spacing.lg),

          // Sound selector
          SoundSelector(
            selectedSoundId: _soundId,
            onChanged: (id) => setState(() => _soundId = id),
          ),
          SizedBox(height: theme.spacing.lg),

          // Snooze duration
          ElogirText(
            'Snooze: $_snoozeDuration min',
            variant: ElogirTextVariant.labelMedium,
            style: TextStyle(color: theme.colors.onSurfaceVariant),
          ),
          SizedBox(height: theme.spacing.xs),
          ElogirSlider(
            value: _snoozeDuration.toDouble(),
            min: 1,
            max: 30,
            divisions: 29,
            onChanged: (v) => setState(() => _snoozeDuration = v.round()),
          ),

          // Delete button (edit mode only)
          if (_isEditing) ...[
            SizedBox(height: theme.spacing.xl),
            ElogirButton(
              onPressed: _delete,
              variant: ElogirButtonVariant.outlined,
              expanded: true,
              child: const Text('Delete Alarm'),
            ),
          ],
        ],
      ),
    );
  }
}
