import 'dart:convert';

import 'package:drift/drift.dart';

import '../../models/device_type.dart';
import '../../models/smart_device.dart';
import '../auto_database.dart';
import '../tables/device_entries.dart';

part 'device_dao.g.dart';

@DriftAccessor(tables: [DeviceEntries])
class DeviceDao extends DatabaseAccessor<AutoDatabase>
    with _$DeviceDaoMixin {
  DeviceDao(super.db);

  Stream<List<SmartDevice>> watchAll() {
    return select(deviceEntries).watch().map(
          (rows) => rows.map(_toModel).toList(),
        );
  }

  Future<List<SmartDevice>> getAll() async {
    final rows = await select(deviceEntries).get();
    return rows.map(_toModel).toList();
  }

  Future<SmartDevice?> getById(String id) async {
    final row = await (select(deviceEntries)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _toModel(row);
  }

  Future<void> upsert(SmartDevice device) {
    return into(deviceEntries).insertOnConflictUpdate(
      DeviceEntriesCompanion.insert(
        id: device.id,
        name: device.name,
        type: device.type.name,
        connectionJson: jsonEncode(device.connection.toJson()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteById(String id) {
    return (delete(deviceEntries)..where((t) => t.id.equals(id))).go();
  }

  SmartDevice _toModel(DeviceEntry row) {
    return SmartDevice(
      id: row.id,
      name: row.name,
      type: DeviceType.values.byName(row.type),
      connection: DeviceConnection.fromJson(
        jsonDecode(row.connectionJson) as Map<String, dynamic>,
      ),
    );
  }
}
