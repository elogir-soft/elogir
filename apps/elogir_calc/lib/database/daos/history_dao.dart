import 'package:drift/drift.dart';
import 'package:elogir_calc/database/app_database.dart';
import 'package:elogir_calc/database/tables/history_table.dart';

part 'history_dao.g.dart';

@DriftAccessor(tables: [HistoryTable])
class HistoryDao extends DatabaseAccessor<AppDatabase> with _$HistoryDaoMixin {
  HistoryDao(super.attachedDatabase);

  /// Watch all history entries ordered by most recent first.
  Stream<List<HistoryTableData>> watchAllHistory() {
    return (select(historyTable)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  /// Insert a new history entry.
  Future<void> insertEntry(HistoryTableCompanion entry) {
    return into(historyTable).insert(entry);
  }

  /// Delete a single entry by ID.
  Future<int> deleteEntry(String id) {
    return (delete(historyTable)..where((t) => t.id.equals(id))).go();
  }

  /// Delete all history entries.
  Future<int> deleteAll() {
    return delete(historyTable).go();
  }
}
