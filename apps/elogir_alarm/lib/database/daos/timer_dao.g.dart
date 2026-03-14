// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_dao.dart';

// ignore_for_file: type=lint
mixin _$TimerDaoMixin on DatabaseAccessor<AppDatabase> {
  $TimerTableTable get timerTable => attachedDatabase.timerTable;
  TimerDaoManager get managers => TimerDaoManager(this);
}

class TimerDaoManager {
  final _$TimerDaoMixin _db;
  TimerDaoManager(this._db);
  $$TimerTableTableTableManager get timerTable =>
      $$TimerTableTableTableManager(_db.attachedDatabase, _db.timerTable);
}
