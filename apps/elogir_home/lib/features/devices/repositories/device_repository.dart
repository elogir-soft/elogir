import 'package:elogir_auto/elogir_auto.dart';

/// Thin wrapper around [DeviceDao] from elogir_auto.
///
/// No model mapping needed — [DeviceDao] already returns [SmartDevice] models.
class DeviceRepository {
  const DeviceRepository(this._dao);

  final DeviceDao _dao;

  Stream<List<SmartDevice>> watchAll() => _dao.watchAll();

  Future<List<SmartDevice>> getAll() => _dao.getAll();

  Future<SmartDevice?> getById(String id) => _dao.getById(id);

  Future<void> save(SmartDevice device) => _dao.upsert(device);

  Future<void> delete(String id) => _dao.deleteById(id);
}
