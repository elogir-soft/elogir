import 'package:drift/drift.dart';

/// Drift table definition for alarms.
class AlarmTable extends Table {
  TextColumn get id => text()();
  IntColumn get hour => integer()();
  IntColumn get minute => integer()();
  TextColumn get label => text().withDefault(const Constant(''))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  /// Comma-separated day indices: 0=Mon, 1=Tue, ..., 6=Sun.
  TextColumn get repeatDays => text().withDefault(const Constant(''))();

  /// System sound type: 'alarm', 'ringtone', 'notification'.
  TextColumn get soundId => text().withDefault(const Constant('alarm'))();

  IntColumn get snoozeDurationMinutes =>
      integer().withDefault(const Constant(5))();

  /// Native AlarmKit alarm UUID (iOS only). Null on Android.
  TextColumn get alarmkitId => text().nullable()();

  /// Non-null when the alarm is currently snoozed. Stores the snooze-end time.
  DateTimeColumn get snoozedUntil => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
