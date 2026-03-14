import 'package:drift/drift.dart';
import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/database/daos/alarm_dao.dart';
import 'package:elogir_alarm/features/alarms/models/alarm.dart';

/// Concrete repository for alarm CRUD. Maps between Drift rows and
/// Freezed domain models.
class AlarmRepository {
  const AlarmRepository(this._dao);

  final AlarmDao _dao;

  /// Watch all alarms as domain models.
  Stream<List<Alarm>> watchAll() {
    return _dao.watchAllAlarms().map(
          (rows) => rows.map(_toModel).toList(),
        );
  }

  /// Watch a single alarm by ID.
  Stream<Alarm?> watch(String id) {
    return _dao.watchAlarm(id).map(
          (row) => row == null ? null : _toModel(row),
        );
  }

  /// Save (insert or update) an alarm.
  Future<void> save(Alarm alarm) {
    return _dao.upsertAlarm(_toCompanion(alarm));
  }

  /// Delete an alarm by ID.
  Future<void> delete(String id) {
    return _dao.deleteAlarm(id);
  }

  /// Toggle the enabled state of an alarm.
  Future<void> toggle({required String id, required bool isEnabled}) {
    return _dao.toggleAlarm(id: id, isEnabled: isEnabled);
  }

  Alarm _toModel(AlarmTableData row) {
    return Alarm(
      id: row.id,
      hour: row.hour,
      minute: row.minute,
      label: row.label,
      isEnabled: row.isEnabled,
      repeatDays: row.repeatDays.isEmpty
          ? []
          : row.repeatDays.split(',').map(int.parse).toList(),
      soundId: row.soundId,
      snoozeDurationMinutes: row.snoozeDurationMinutes,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  AlarmTableCompanion _toCompanion(Alarm alarm) {
    return AlarmTableCompanion(
      id: Value(alarm.id),
      hour: Value(alarm.hour),
      minute: Value(alarm.minute),
      label: Value(alarm.label),
      isEnabled: Value(alarm.isEnabled),
      repeatDays: Value(alarm.repeatDays.join(',')),
      soundId: Value(alarm.soundId),
      snoozeDurationMinutes: Value(alarm.snoozeDurationMinutes),
      createdAt: Value(alarm.createdAt),
      updatedAt: Value(alarm.updatedAt),
    );
  }
}
