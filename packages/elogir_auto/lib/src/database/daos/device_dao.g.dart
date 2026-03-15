// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_dao.dart';

// ignore_for_file: type=lint
mixin _$DeviceDaoMixin on DatabaseAccessor<AutoDatabase> {
  $DeviceEntriesTable get deviceEntries => attachedDatabase.deviceEntries;
  DeviceDaoManager get managers => DeviceDaoManager(this);
}

class DeviceDaoManager {
  final _$DeviceDaoMixin _db;
  DeviceDaoManager(this._db);
  $$DeviceEntriesTableTableManager get deviceEntries =>
      $$DeviceEntriesTableTableManager(_db.attachedDatabase, _db.deviceEntries);
}
