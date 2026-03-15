import 'package:drift/drift.dart';
import 'package:elogir_home/database/app_database.dart';
import 'package:elogir_home/database/tables/automation_table.dart';

part 'automation_dao.g.dart';

@DriftAccessor(tables: [AutomationTable])
class AutomationDao extends DatabaseAccessor<AppDatabase>
    with _$AutomationDaoMixin {
  AutomationDao(super.attachedDatabase);

  /// Watch all automations ordered by creation time (newest first).
  Stream<List<AutomationTableData>> watchAll() {
    return (select(automationTable)
          ..orderBy([
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch();
  }

  /// Insert or update an automation.
  Future<void> upsert(AutomationTableCompanion companion) {
    return into(automationTable).insertOnConflictUpdate(companion);
  }

  /// Delete an automation by ID.
  Future<void> deleteById(String id) {
    return (delete(automationTable)..where((t) => t.id.equals(id))).go();
  }

  /// Toggle the enabled state of an automation.
  Future<void> toggleEnabled({
    required String id,
    required bool isEnabled,
  }) {
    return (update(automationTable)..where((t) => t.id.equals(id))).write(
      AutomationTableCompanion(
        isEnabled: Value(isEnabled),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
