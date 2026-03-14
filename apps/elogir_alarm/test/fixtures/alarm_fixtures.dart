import 'package:elogir_alarm/features/alarms/models/alarm.dart';

/// Factory for creating test [Alarm] instances with sensible defaults.
Alarm createAlarm({
  String id = 'test-alarm-1',
  int hour = 8,
  int minute = 0,
  String label = 'Wake Up',
  bool isEnabled = true,
  List<int> repeatDays = const [],
  String soundId = 'alarm',
  int snoozeDurationMinutes = 5,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  final now = DateTime(2026, 3, 14);
  return Alarm(
    id: id,
    hour: hour,
    minute: minute,
    label: label,
    isEnabled: isEnabled,
    repeatDays: repeatDays,
    soundId: soundId,
    snoozeDurationMinutes: snoozeDurationMinutes,
    createdAt: createdAt ?? now,
    updatedAt: updatedAt ?? now,
  );
}

/// A list of sample alarms for testing.
List<Alarm> sampleAlarms() => [
      createAlarm(),
      createAlarm(
        id: 'test-alarm-2',
        hour: 9,
        minute: 30,
        label: 'Workout',
        repeatDays: [0, 1, 2, 3, 4], // Mon-Fri
      ),
      createAlarm(
        id: 'test-alarm-3',
        hour: 22,
        minute: 0,
        label: 'Sleep',
        isEnabled: false,
      ),
    ];
