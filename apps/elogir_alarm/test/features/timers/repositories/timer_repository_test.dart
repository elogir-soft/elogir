import 'package:drift/native.dart';
import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/features/timers/models/app_timer.dart';
import 'package:elogir_alarm/features/timers/repositories/timer_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/timer_fixtures.dart';

void main() {
  late AppDatabase db;
  late TimerRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = TimerRepository(db.timerDao);
  });

  tearDown(() async {
    await db.close();
  });

  group('TimerRepository', () {
    test('watchAll returns empty list initially', () async {
      final timers = await repository.watchAll().first;
      expect(timers, isEmpty);
    });

    test('save and watchAll returns saved timer', () async {
      final timer = createAppTimer();
      await repository.save(timer);

      final timers = await repository.watchAll().first;
      expect(timers, hasLength(1));
      expect(timers.first.id, timer.id);
      expect(timers.first.label, timer.label);
      expect(timers.first.durationMs, timer.durationMs);
    });

    test('save updates existing timer', () async {
      final timer = createAppTimer();
      await repository.save(timer);
      await repository.save(timer.copyWith(remainingMs: 100000));

      final timers = await repository.watchAll().first;
      expect(timers, hasLength(1));
      expect(timers.first.remainingMs, 100000);
    });

    test('delete removes timer', () async {
      final timer = createAppTimer();
      await repository.save(timer);
      await repository.delete(timer.id);

      final timers = await repository.watchAll().first;
      expect(timers, isEmpty);
    });

    test('deleteFinished removes completed and cancelled', () async {
      await repository.save(createAppTimer(id: 'running'));
      await repository.save(
        createAppTimer(
          id: 'completed',
          status: TimerStatus.completed,
          remainingMs: 0,
        ),
      );
      await repository.save(
        createAppTimer(id: 'cancelled', status: TimerStatus.cancelled),
      );

      await repository.deleteFinished();

      final timers = await repository.watchAll().first;
      expect(timers, hasLength(1));
      expect(timers.first.id, 'running');
    });

    test('updateState changes status and remainingMs', () async {
      final timer = createAppTimer();
      await repository.save(timer);

      await repository.updateState(
        id: timer.id,
        status: TimerStatus.paused,
        remainingMs: 150000,
        pausedAt: DateTime(2026, 3, 14, 12),
      );

      final timers = await repository.watchAll().first;
      expect(timers.first.status, TimerStatus.paused);
      expect(timers.first.remainingMs, 150000);
    });

    test('watch returns single timer by id', () async {
      final timer = createAppTimer();
      await repository.save(timer);

      final result = await repository.watch(timer.id).first;
      expect(result, isNotNull);
      expect(result!.id, timer.id);
    });
  });
}
