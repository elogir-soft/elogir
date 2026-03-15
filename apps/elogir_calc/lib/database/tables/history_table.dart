import 'package:drift/drift.dart';

/// Drift table definition for calculation history.
class HistoryTable extends Table {
  TextColumn get id => text()();
  TextColumn get expression => text()();
  TextColumn get result => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
