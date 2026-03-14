import 'package:drift/drift.dart';
import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/database/tables/timer_table.dart';

part 'timer_dao.g.dart';

@DriftAccessor(tables: [TimerTable])
class TimerDao extends DatabaseAccessor<AppDatabase> with _$TimerDaoMixin {
  TimerDao(super.attachedDatabase);

  /// Watch all timers ordered by creation time (newest first).
  Stream<List<TimerTableData>> watchAllTimers() {
    return (select(timerTable)
          ..orderBy([
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch();
  }

  /// Watch a single timer by ID.
  Stream<TimerTableData?> watchTimer(String id) {
    return (select(timerTable)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  /// Insert or update a timer.
  Future<void> upsertTimer(TimerTableCompanion timer) {
    return into(timerTable).insertOnConflictUpdate(timer);
  }

  /// Delete a timer by ID.
  Future<int> deleteTimer(String id) {
    return (delete(timerTable)..where((t) => t.id.equals(id))).go();
  }

  /// Delete all completed or cancelled timers.
  Future<int> deleteFinishedTimers() {
    return (delete(timerTable)
          ..where(
            (t) =>
                t.status.isIn(const ['completed', 'cancelled']),
          ))
        .go();
  }

  /// Update a timer's status and remaining time.
  Future<int> updateTimerState({
    required String id,
    required String status,
    required int remainingMs,
    DateTime? startedAt,
    DateTime? pausedAt,
  }) {
    return (update(timerTable)..where((t) => t.id.equals(id))).write(
      TimerTableCompanion(
        status: Value(status),
        remainingMs: Value(remainingMs),
        startedAt: Value(startedAt),
        pausedAt: Value(pausedAt),
      ),
    );
  }
}
