import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/alarms/providers/alarm_repository_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/alarms_provider.dart';
import 'package:elogir_alarm/features/alarms/widgets/day_of_week_selector.dart';
import 'package:elogir_alarm/features/alarms/widgets/sound_selector.dart';
import 'package:elogir_alarm/features/alarms/widgets/time_picker_wheel.dart';
import 'package:elogir_alarm/features/settings/providers/settings_provider.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

/// Shows the alarm edit/create sheet as a modal bottom sheet
/// over the entire app (including bottom nav).
Future<void> showAlarmEditSheet({
  required BuildContext context,
  String? alarmId,
}) {
  return ElogirBottomSheet.show(
    context: context,
    useRootNavigator: true,
    maxHeight: MediaQuery.of(context).size.height * 0.85,
    builder: (context) => _AlarmEditSheetContent(alarmId: alarmId),
  );
}

class _AlarmEditSheetContent extends ConsumerStatefulWidget {
  const _AlarmEditSheetContent({this.alarmId});

  final String? alarmId;

  @override
  ConsumerState<_AlarmEditSheetContent> createState() =>
      _AlarmEditSheetContentState();
}

class _AlarmEditSheetContentState
    extends ConsumerState<_AlarmEditSheetContent> {
  static const _uuid = Uuid();

  late final TextEditingController _labelController;
  int _hour = 8;
  int _minute = 0;
  List<int> _repeatDays = [];
  String _soundId = 'alarm';
  int _snoozeDuration = 5;
  bool _initialized = false;
  bool _snoozeInitialized = false;

  bool get _isEditing => widget.alarmId != null;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isEditing && !_snoozeInitialized) {
      _snoozeInitialized = true;
      final snooze =
          ref.read(settingsProvider).value?.defaultSnoozeMinutes;
      if (snooze != null) {
        _snoozeDuration = snooze;
      }
    }
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
      createdAt: now,
      updatedAt: now,
    );

    await ref.read(alarmRepositoryProvider).save(alarm);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);
    final settings = ref.watch(settingsProvider).value;
    final weekStartsOnMonday = settings?.weekStartsOnMonday ?? true;
    final use24HourFormat = settings?.use24HourFormat ?? false;

    // If editing, watch the alarm to init form fields.
    if (_isEditing) {
      final alarmsAsync = ref.watch(alarmsProvider);
      alarmsAsync.whenData((alarms) {
        final existing =
            alarms.where((a) => a.id == widget.alarmId).firstOrNull;
        if (existing != null) _initFromAlarm(existing);
      });
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title.
        Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ElogirText(
              _isEditing ? 'Edit Alarm' : 'New Alarm',
              variant: ElogirTextVariant.titleLarge,
            ),
          ),
        ),
        SizedBox(height: theme.spacing.sm),

        // Scrollable form content.
        Flexible(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
            shrinkWrap: true,
            children: [
              // Time picker
              TimePickerWheel(
                hour: _hour,
                minute: _minute,
                use24HourFormat: use24HourFormat,
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
                weekStartsOnMonday: weekStartsOnMonday,
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
                onChanged: (v) =>
                    setState(() => _snoozeDuration = v.round()),
              ),

              SizedBox(height: theme.spacing.md),
            ],
          ),
        ),

        // Save button pinned at the bottom.
        Padding(
          padding: EdgeInsets.only(
            left: theme.spacing.md,
            right: theme.spacing.md,
            bottom: theme.spacing.lg,
            top: theme.spacing.sm,
          ),
          child: ElogirButton(
            onPressed: _save,
            expanded: true,
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }
}
