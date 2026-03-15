import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm.freezed.dart';
part 'alarm.g.dart';

@freezed
abstract class Alarm with _$Alarm {
  const factory Alarm({
    required String id,
    required int hour,
    required int minute,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default('') String label,
    @Default(true) bool isEnabled,
    @Default([]) List<int> repeatDays,
    @Default('marimba') String soundId,
    @Default(5) int snoozeDurationMinutes,
    DateTime? snoozedUntil,
  }) = _Alarm;

  const Alarm._();

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);

  /// Formatted time string like "07:30" or "23:05".
  String get timeFormatted =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  /// Computes the next occurrence of this alarm from [now].
  ///
  /// If [repeatDays] is empty, returns the next occurrence today or tomorrow.
  /// If [repeatDays] is set, finds the soonest matching day.
  DateTime nextOccurrence([DateTime? now]) {
    final reference = now ?? DateTime.now();
    final todayAlarm = DateTime(
      reference.year,
      reference.month,
      reference.day,
      hour,
      minute,
    );

    if (repeatDays.isEmpty) {
      // One-shot alarm: today if not passed, otherwise tomorrow.
      if (todayAlarm.isAfter(reference)) return todayAlarm;
      return todayAlarm.add(const Duration(days: 1));
    }

    // Repeating alarm: find the next matching weekday.
    // DateTime.weekday: 1=Monday, 7=Sunday.
    // Our repeatDays: 0=Monday, 6=Sunday.
    for (var daysAhead = 0; daysAhead < 7; daysAhead++) {
      final candidate = todayAlarm.add(Duration(days: daysAhead));
      final candidateDayIndex = candidate.weekday - 1; // 0=Mon, 6=Sun
      if (repeatDays.contains(candidateDayIndex)) {
        if (candidate.isAfter(reference)) return candidate;
      }
    }

    // Fallback: should not reach here if repeatDays is valid.
    return todayAlarm.add(const Duration(days: 1));
  }

  /// Duration until the next occurrence.
  Duration timeUntilNext([DateTime? now]) {
    final reference = now ?? DateTime.now();
    return nextOccurrence(reference).difference(reference);
  }

  /// Short day labels for the selected repeat days.
  static const List<String> dayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  /// Single-character day labels for compact display.
  static const List<String> dayLetters = [
    'M',
    'T',
    'W',
    'T',
    'F',
    'S',
    'S',
  ];
}
