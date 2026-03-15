import 'controllers/device_controller.dart';
import 'database/auto_database.dart';
import 'database/daos/device_dao.dart';
import 'models/device_type.dart';
import 'models/scan_result.dart';
import 'models/smart_device.dart';
import 'models/tuya_credentials.dart';
import 'tuya/tuya_adaptive_controller.dart';
import 'tuya/tuya_cloud_cover_controller.dart';
import 'tuya/tuya_cloud_light_controller.dart';
import 'tuya/tuya_cloud_service.dart';
import 'tuya/tuya_cloud_switch_controller.dart';
import 'tuya/tuya_cover_controller.dart';
import 'tuya/tuya_light_controller.dart';
import 'tuya/tuya_scanner.dart';
import 'tuya/tuya_switch_controller.dart';

class ElogirAuto {
  ElogirAuto({required AutoDatabase database}) : _database = database;

  final AutoDatabase _database;
  final Map<String, DeviceController<dynamic>> _controllers = {};
  TuyaCloudService? _cloudService;

  DeviceDao get deviceDao => _database.deviceDao;

  bool get hasCloudService => _cloudService != null;

  void setCloudService(TuyaCloudService service) {
    _cloudService = service;
    // Clear cache so controllers are re-created with cloud on next access.
    _disposeControllers();
  }

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
    await _disposeControllers();
    await _database.close();
  }

  Future<void> _disposeControllers() async {
    for (final controller in _controllers.values) {
      if (controller is TuyaAdaptiveController<dynamic>) {
        await controller.dispose();
      } else if (controller is TuyaLightController) {
        await controller.dispose();
      } else if (controller is TuyaSwitchController) {
        await controller.dispose();
      } else if (controller is TuyaCoverController) {
        await controller.dispose();
      }
    }
    _controllers.clear();
  }

  DeviceController<dynamic> _createController(SmartDevice device) {
    return switch (device.connection) {
      final TuyaConnection connection => _createTuyaController(
          device,
          connection,
        ),
    };
  }

  DeviceController<dynamic> _createTuyaController(
    SmartDevice device,
    TuyaConnection connection,
  ) {
    final hasLan =
        connection.address.isNotEmpty && connection.localKey.isNotEmpty;
    final hasCloud = _cloudService != null;

    return switch (device.type) {
      DeviceType.light => TuyaAdaptiveLightController(
          lanController: hasLan ? TuyaLightController(device) : null,
          cloudController:
              hasCloud ? TuyaCloudLightController(device, _cloudService!) : null,
        ),
      DeviceType.switchDevice => TuyaAdaptiveSwitchController(
          lanController: hasLan ? TuyaSwitchController(device) : null,
          cloudController: hasCloud
              ? TuyaCloudSwitchController(device, _cloudService!)
              : null,
        ),
      DeviceType.cover => TuyaAdaptiveCoverController(
          lanController: hasLan ? TuyaCoverController(device) : null,
          cloudController: hasCloud
              ? TuyaCloudCoverController(device, _cloudService!)
              : null,
        ),
    };
  }
}
