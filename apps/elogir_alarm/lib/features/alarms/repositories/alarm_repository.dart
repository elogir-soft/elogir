import 'package:drift/drift.dart';
import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/database/daos/alarm_dao.dart';
import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/alarms/services/alarm_scheduler.dart';

/// Concrete repository for alarm CRUD. Maps between Drift rows and
/// Freezed domain models, and keeps native scheduling in sync.
class AlarmRepository {
  const AlarmRepository(this._dao, this._scheduler);

  final AlarmDao _dao;
  final AlarmScheduler _scheduler;

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

  /// Save (insert or update) an alarm and sync the native scheduler.
  Future<void> save(Alarm alarm) async {
    await _dao.upsertAlarm(_toCompanion(alarm));
    if (alarm.isEnabled) {
      final nativeId = await _scheduler.schedule(alarm);
      if (nativeId != null) await _dao.updateAlarmkitId(alarm.id, nativeId);
    } else {
      final row = await _dao.getAlarm(alarm.id);
      await _scheduler.cancel(alarm.id, nativeId: row?.alarmkitId);
    }
  }

  /// Delete an alarm by ID, cancelling any scheduled native alarm first.
  Future<void> delete(String id) async {
    final row = await _dao.getAlarm(id);
    await _scheduler.cancel(id, nativeId: row?.alarmkitId);
    await _dao.deleteAlarm(id);
  }

  /// Toggle the enabled state of an alarm, syncing the native scheduler.
  Future<void> toggle({required String id, required bool isEnabled}) async {
    await _dao.toggleAlarm(id: id, isEnabled: isEnabled);
    final row = await _dao.getAlarm(id);
    if (row == null) return;
    final alarm = _toModel(row);
    if (isEnabled) {
      final nativeId = await _scheduler.schedule(alarm);
      if (nativeId != null) await _dao.updateAlarmkitId(id, nativeId);
    } else {
      await _scheduler.cancel(id, nativeId: row.alarmkitId);
    }
  }

  /// Set or clear the snooze-end time for an alarm.
  Future<void> updateSnoozedUntil(String id, DateTime? snoozedUntil) {
    return _dao.updateSnoozedUntil(id, snoozedUntil);
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
      snoozedUntil: row.snoozedUntil,
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
      snoozedUntil: Value(alarm.snoozedUntil),
      createdAt: Value(alarm.createdAt),
      updatedAt: Value(alarm.updatedAt),
    );
  }
}
