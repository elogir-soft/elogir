import 'package:drift/drift.dart';

/// Drift table definition for timers.
class TimerTable extends Table {
  TextColumn get id => text()();
  TextColumn get label => text().withDefault(const Constant(''))();

  /// Total duration in milliseconds.
  IntColumn get durationMs => integer()();

  /// Remaining duration in milliseconds.
  IntColumn get remainingMs => integer()();

  /// Status: 'running', 'paused', 'completed', 'cancelled'.
  TextColumn get status => text()();

  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get pausedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
