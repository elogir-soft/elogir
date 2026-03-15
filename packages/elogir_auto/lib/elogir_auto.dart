/// Smart device control library for the elogir ecosystem.
library;

// Models
export 'src/models/cover_state.dart';
export 'src/models/device_type.dart';
export 'src/models/light_state.dart';
export 'src/models/scan_result.dart';
export 'src/models/smart_device.dart';
export 'src/models/switch_state.dart';
export 'src/models/tuya_credentials.dart';

// Abstract controllers
export 'src/controllers/cover_controller.dart';
export 'src/controllers/device_controller.dart';
export 'src/controllers/light_controller.dart';
export 'src/controllers/switch_controller.dart';

// Discovery
export 'src/discovery/device_scanner.dart';

// Database
export 'src/database/auto_database.dart';
export 'src/database/daos/device_dao.dart';

// Tuya platform
export 'src/tuya/tuya_adaptive_controller.dart';
export 'src/tuya/tuya_cloud_cover_controller.dart';
export 'src/tuya/tuya_cloud_device_controller.dart';
export 'src/tuya/tuya_cloud_light_controller.dart';
export 'src/tuya/tuya_cloud_service.dart';
export 'src/tuya/tuya_cloud_switch_controller.dart';
export 'src/tuya/tuya_cover_controller.dart';
export 'src/tuya/tuya_device_controller.dart';
export 'src/tuya/tuya_light_controller.dart';
export 'src/tuya/tuya_scanner.dart';
export 'src/tuya/tuya_switch_controller.dart';

// Facade
export 'src/elogir_auto.dart';
