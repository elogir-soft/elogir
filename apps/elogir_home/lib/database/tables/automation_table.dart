import 'package:drift/drift.dart';

/// Persists automations with their triggers and actions stored as JSON text.
class AutomationTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  /// JSON-encoded automation trigger.
  TextColumn get trigger => text()();

  /// JSON-encoded [List<AutomationAction>].
  TextColumn get actions => text()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
