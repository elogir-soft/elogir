import 'controllers/device_controller.dart';
import 'database/auto_database.dart';
import 'database/daos/device_dao.dart';
import 'models/device_type.dart';
import 'models/scan_result.dart';
import 'models/smart_device.dart';
import 'models/tuya_credentials.dart';
import 'tuya/tuya_cloud_service.dart';
import 'tuya/tuya_cover_controller.dart';
import 'tuya/tuya_device_controller.dart';
import 'tuya/tuya_light_controller.dart';
import 'tuya/tuya_scanner.dart';
import 'tuya/tuya_switch_controller.dart';

class ElogirAuto {
  ElogirAuto({required AutoDatabase database}) : _database = database;

  final AutoDatabase _database;
  final Map<String, TuyaDeviceController<dynamic>> _controllers = {};

  DeviceDao get deviceDao => _database.deviceDao;

  DeviceController<dynamic> controllerFor(SmartDevice device) {
    return _controllers.putIfAbsent(device.id, () => _createController(device));
  }

  Future<List<ScanResult>> scan({
    Duration timeout = const Duration(seconds: 10),
  }) {
    return TuyaScanner().scan(timeout: timeout);
  }

  TuyaCloudService createTuyaCloudService(TuyaCredentials credentials) {
    return TuyaCloudService(credentials);
  }

  Future<void> dispose() async {
    for (final controller in _controllers.values) {
      await controller.dispose();
    }
    _controllers.clear();
    await _database.close();
  }

  TuyaDeviceController<dynamic> _createController(SmartDevice device) {
    return switch (device.connection) {
      TuyaConnection() => switch (device.type) {
          DeviceType.light => TuyaLightController(device),
          DeviceType.switchDevice => TuyaSwitchController(device),
          DeviceType.cover => TuyaCoverController(device),
        },
    };
  }
}
