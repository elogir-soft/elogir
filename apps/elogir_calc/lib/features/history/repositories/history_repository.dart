import 'package:drift/drift.dart';
import 'package:elogir_calc/database/app_database.dart';
import 'package:elogir_calc/database/daos/history_dao.dart';
import 'package:elogir_calc/features/history/models/calculation.dart';

/// Concrete repository for calculation history. Maps between Drift rows
/// and Freezed domain models.
class HistoryRepository {
  const HistoryRepository(this._dao);

  final HistoryDao _dao;

  /// Watch all history entries as domain models.
  Stream<List<Calculation>> watchAll() {
    return _dao.watchAllHistory().map(
          (rows) => rows.map(_toModel).toList(),
        );
  }

  /// Insert a new calculation entry.
  Future<void> insert(Calculation calculation) {
    return _dao.insertEntry(_toCompanion(calculation));
  }

  /// Delete a single entry by ID.
  Future<void> delete(String id) {
    return _dao.deleteEntry(id);
  }

  /// Delete all history entries.
  Future<void> deleteAll() {
    return _dao.deleteAll();
  }

  Calculation _toModel(HistoryTableData row) {
    return Calculation(
      id: row.id,
      expression: row.expression,
      result: row.result,
      createdAt: row.createdAt,
    );
  }

  HistoryTableCompanion _toCompanion(Calculation calculation) {
    return HistoryTableCompanion(
      id: Value(calculation.id),
      expression: Value(calculation.expression),
      result: Value(calculation.result),
      createdAt: Value(calculation.createdAt),
    );
  }
}
