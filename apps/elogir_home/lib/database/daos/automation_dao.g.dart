// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automation_dao.dart';

// ignore_for_file: type=lint
mixin _$AutomationDaoMixin on DatabaseAccessor<AppDatabase> {
  $AutomationTableTable get automationTable => attachedDatabase.automationTable;
  AutomationDaoManager get managers => AutomationDaoManager(this);
}

class AutomationDaoManager {
  final _$AutomationDaoMixin _db;
  AutomationDaoManager(this._db);
  $$AutomationTableTableTableManager get automationTable =>
      $$AutomationTableTableTableManager(
        _db.attachedDatabase,
        _db.automationTable,
      );
}
