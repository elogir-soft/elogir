import 'package:drift/native.dart';
import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/features/alarms/repositories/alarm_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/alarm_fixtures.dart';

void main() {
  late AppDatabase db;
  late AlarmRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = AlarmRepository(db.alarmDao);
  });

  tearDown(() async {
    await db.close();
  });

  group('AlarmRepository', () {
    test('watchAll returns empty list initially', () async {
      final alarms = await repository.watchAll().first;
      expect(alarms, isEmpty);
    });

    test('save and watchAll returns saved alarm', () async {
      final alarm = createAlarm();
      await repository.save(alarm);

      final alarms = await repository.watchAll().first;
      expect(alarms, hasLength(1));
      expect(alarms.first.id, alarm.id);
      expect(alarms.first.hour, alarm.hour);
      expect(alarms.first.label, alarm.label);
    });

    test('save updates existing alarm', () async {
      final alarm = createAlarm();
      await repository.save(alarm);
      await repository.save(alarm.copyWith(label: 'Updated'));

      final alarms = await repository.watchAll().first;
      expect(alarms, hasLength(1));
      expect(alarms.first.label, 'Updated');
    });

    test('delete removes alarm', () async {
      final alarm = createAlarm();
      await repository.save(alarm);
      await repository.delete(alarm.id);

      final alarms = await repository.watchAll().first;
      expect(alarms, isEmpty);
    });

    test('toggle changes isEnabled state', () async {
      final alarm = createAlarm();
      await repository.save(alarm);

      await repository.toggle(id: alarm.id, isEnabled: false);

      final alarms = await repository.watchAll().first;
      expect(alarms.first.isEnabled, isFalse);
    });

    test('saves and retrieves repeatDays correctly', () async {
      final alarm = createAlarm(repeatDays: [0, 2, 4]);
      await repository.save(alarm);

      final alarms = await repository.watchAll().first;
      expect(alarms.first.repeatDays, [0, 2, 4]);
    });

    test('watch returns single alarm by id', () async {
      final alarm = createAlarm();
      await repository.save(alarm);

      final result = await repository.watch(alarm.id).first;
      expect(result, isNotNull);
      expect(result!.id, alarm.id);
    });

    test('watch returns null for non-existent id', () async {
      final result = await repository.watch('nonexistent').first;
      expect(result, isNull);
    });
  });
}
