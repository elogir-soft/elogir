import 'package:drift/drift.dart';
import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/database/tables/alarm_table.dart';

part 'alarm_dao.g.dart';

@DriftAccessor(tables: [AlarmTable])
class AlarmDao extends DatabaseAccessor<AppDatabase> with _$AlarmDaoMixin {
  AlarmDao(super.attachedDatabase);

  /// Watch all alarms ordered by hour then minute.
  Stream<List<AlarmTableData>> watchAllAlarms() {
    return (select(alarmTable)
          ..orderBy([
            (t) => OrderingTerm.asc(t.hour),
            (t) => OrderingTerm.asc(t.minute),
          ]))
        .watch();
  }

  /// Watch a single alarm by ID.
  Stream<AlarmTableData?> watchAlarm(String id) {
    return (select(alarmTable)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  /// Insert or update an alarm.
  Future<void> upsertAlarm(AlarmTableCompanion alarm) {
    return into(alarmTable).insertOnConflictUpdate(alarm);
  }

  /// Delete an alarm by ID.
  Future<int> deleteAlarm(String id) {
    return (delete(alarmTable)..where((t) => t.id.equals(id))).go();
  }

  /// Toggle the enabled state of an alarm.
  Future<int> toggleAlarm({required String id, required bool isEnabled}) {
    return (update(alarmTable)..where((t) => t.id.equals(id))).write(
      AlarmTableCompanion(isEnabled: Value(isEnabled)),
    );
  }
}
