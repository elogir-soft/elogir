import 'package:drift/drift.dart';

/// Single-row settings table. The row with id = 1 is always the settings row.
class SettingsTable extends Table {
  IntColumn get id => integer()();

  /// One of 'system', 'light', 'dark'.
  TextColumn get themeMode =>
      text().withDefault(const Constant('system'))();

  BoolColumn get use24HourFormat =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
