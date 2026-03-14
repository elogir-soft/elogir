// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_dao.dart';

// ignore_for_file: type=lint
mixin _$AlarmDaoMixin on DatabaseAccessor<AppDatabase> {
  $AlarmTableTable get alarmTable => attachedDatabase.alarmTable;
  AlarmDaoManager get managers => AlarmDaoManager(this);
}

class AlarmDaoManager {
  final _$AlarmDaoMixin _db;
  AlarmDaoManager(this._db);
  $$AlarmTableTableTableManager get alarmTable =>
      $$AlarmTableTableTableManager(_db.attachedDatabase, _db.alarmTable);
}
