import 'package:drift/drift.dart';
import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/database/daos/timer_dao.dart';
import 'package:elogir_alarm/features/timers/models/app_timer.dart';

/// Concrete repository for timer CRUD. Maps between Drift rows and
/// Freezed domain models.
class TimerRepository {
  const TimerRepository(this._dao);

  final TimerDao _dao;

  /// Watch all timers as domain models.
  Stream<List<AppTimer>> watchAll() {
    return _dao.watchAllTimers().map(
          (rows) => rows.map(_toModel).toList(),
        );
  }

  /// Watch a single timer by ID.
  Stream<AppTimer?> watch(String id) {
    return _dao.watchTimer(id).map(
          (row) => row == null ? null : _toModel(row),
        );
  }

  /// Save (insert or update) a timer.
  Future<void> save(AppTimer timer) {
    return _dao.upsertTimer(_toCompanion(timer));
  }

  /// Delete a timer by ID.
  Future<void> delete(String id) {
    return _dao.deleteTimer(id);
  }

  /// Delete all completed or cancelled timers.
  Future<void> deleteFinished() {
    return _dao.deleteFinishedTimers();
  }

  /// Update timer state (status + remaining time).
  Future<void> updateState({
    required String id,
    required TimerStatus status,
    required int remainingMs,
    DateTime? startedAt,
    DateTime? pausedAt,
  }) {
    return _dao.updateTimerState(
      id: id,
      status: status.name,
      remainingMs: remainingMs,
      startedAt: startedAt,
      pausedAt: pausedAt,
    );
  }

  AppTimer _toModel(TimerTableData row) {
    return AppTimer(
      id: row.id,
      label: row.label,
      durationMs: row.durationMs,
      remainingMs: row.remainingMs,
      status: TimerStatus.values.byName(row.status),
      startedAt: row.startedAt,
      pausedAt: row.pausedAt,
      createdAt: row.createdAt,
    );
  }

  TimerTableCompanion _toCompanion(AppTimer timer) {
    return TimerTableCompanion(
      id: Value(timer.id),
      label: Value(timer.label),
      durationMs: Value(timer.durationMs),
      remainingMs: Value(timer.remainingMs),
      status: Value(timer.status.name),
      startedAt: Value(timer.startedAt),
      pausedAt: Value(timer.pausedAt),
      createdAt: Value(timer.createdAt),
    );
  }
}
