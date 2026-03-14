import 'dart:convert';

import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/alarm_fixtures.dart';

void main() {
  group('Alarm', () {
    test('creates with default values', () {
      final alarm = createAlarm();
      expect(alarm.id, 'test-alarm-1');
      expect(alarm.hour, 8);
      expect(alarm.minute, 0);
      expect(alarm.label, 'Wake Up');
      expect(alarm.isEnabled, isTrue);
      expect(alarm.repeatDays, isEmpty);
      expect(alarm.soundId, 'alarm');
      expect(alarm.snoozeDurationMinutes, 5);
    });

    test('timeFormatted pads with zeros', () {
      expect(createAlarm(hour: 7, minute: 5).timeFormatted, '07:05');
      expect(createAlarm(hour: 23, minute: 30).timeFormatted, '23:30');
      expect(createAlarm(hour: 0, minute: 0).timeFormatted, '00:00');
    });

    test('copyWith creates new instance', () {
      final alarm = createAlarm();
      final copy = alarm.copyWith(label: 'New Label');
      expect(copy.label, 'New Label');
      expect(copy.id, alarm.id);
      expect(alarm.label, 'Wake Up');
    });

    test('equality by value', () {
      final a = createAlarm();
      final b = createAlarm();
      expect(a, equals(b));
    });

    test('inequality when fields differ', () {
      final a = createAlarm();
      final b = createAlarm(label: 'Different');
      expect(a, isNot(equals(b)));
    });

    group('JSON serialization', () {
      test('round-trips correctly', () {
        final alarm = createAlarm(repeatDays: [0, 2, 4]);
        final json = alarm.toJson();
        final decoded = Alarm.fromJson(json);
        expect(decoded, equals(alarm));
      });

      test('handles empty repeatDays', () {
        final alarm = createAlarm();
        final json = jsonEncode(alarm.toJson());
        final decoded = Alarm.fromJson(
          jsonDecode(json) as Map<String, dynamic>,
        );
        expect(decoded.repeatDays, isEmpty);
      });
    });

    group('nextOccurrence', () {
      test('returns today if alarm time has not passed', () {
        final now = DateTime(2026, 3, 14, 7, 0); // Saturday 7:00
        final alarm = createAlarm(hour: 8, minute: 0);
        final next = alarm.nextOccurrence(now);
        expect(next, DateTime(2026, 3, 14, 8, 0));
      });

      test('returns tomorrow if alarm time has passed', () {
        final now = DateTime(2026, 3, 14, 9, 0); // Saturday 9:00
        final alarm = createAlarm(hour: 8, minute: 0);
        final next = alarm.nextOccurrence(now);
        expect(next, DateTime(2026, 3, 15, 8, 0));
      });

      test('finds next matching weekday for repeating alarm', () {
        // Saturday 9:00, alarm at 8:00, repeats Mon(0) and Wed(2)
        final now = DateTime(2026, 3, 14, 9, 0); // Saturday
        final alarm = createAlarm(hour: 8, minute: 0, repeatDays: [0, 2]);
        final next = alarm.nextOccurrence(now);
        // Next Monday is March 16
        expect(next, DateTime(2026, 3, 16, 8, 0));
      });

      test('returns today if repeating and time not passed', () {
        // Monday 7:00, alarm at 8:00, repeats Mon(0)
        final now = DateTime(2026, 3, 16, 7, 0); // Monday
        final alarm = createAlarm(hour: 8, minute: 0, repeatDays: [0]);
        final next = alarm.nextOccurrence(now);
        expect(next, DateTime(2026, 3, 16, 8, 0));
      });
    });

    group('timeUntilNext', () {
      test('returns positive duration for future alarm', () {
        final now = DateTime(2026, 3, 14, 7, 0);
        final alarm = createAlarm(hour: 8, minute: 0);
        expect(alarm.timeUntilNext(now), const Duration(hours: 1));
      });
    });

    test('dayLabels has 7 entries', () {
      expect(Alarm.dayLabels, hasLength(7));
    });

    test('dayLetters has 7 entries', () {
      expect(Alarm.dayLetters, hasLength(7));
    });
  });
}
