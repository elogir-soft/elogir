import 'package:drift/drift.dart';

/// Single-row settings table. The row with id = 1 is always the settings row.
class SettingsTable extends Table {
  IntColumn get id => integer()();

  // Alarms
  IntColumn get defaultSnoozeMinutes =>
      integer().withDefault(const Constant(5))();

  // Stopwatch
  BoolColumn get keepScreenOnStopwatch =>
      boolean().withDefault(const Constant(false))();

  // Appearance
  /// One of 'system', 'light', 'dark'.
  TextColumn get themeMode =>
      text().withDefault(const Constant('system'))();
  BoolColumn get use24HourFormat =>
      boolean().withDefault(const Constant(false))();

  // Timers
  TextColumn get timerSoundId =>
      text().withDefault(const Constant('marimba'))();

  // General
  BoolColumn get weekStartsOnMonday =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
