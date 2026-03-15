import 'package:tinytuya/tinytuya.dart' as tuya;

import '../controllers/cover_controller.dart';
import '../models/cover_state.dart';
import '../models/smart_device.dart';
import 'tuya_device_controller.dart';

class TuyaCoverController extends TuyaDeviceController<CoverState>
    implements CoverController {
  TuyaCoverController(super.device);

  tuya.CoverDevice get _cover => tuyaDevice! as tuya.CoverDevice;

  @override
  tuya.CoverDevice createTuyaDevice() {
    final connection = device.connection as TuyaConnection;
    return tuya.CoverDevice(
      deviceId: connection.deviceId,
      address: connection.address,
      localKey: connection.localKey,
      version: connection.version,
      port: connection.port,
    );
  }

  @override
  CoverState parseState(Map<String, dynamic> dps) {
    final controlStr = dps['1'] as String?;
    final position = dps['2'] as int? ?? 0;

    final direction = switch (controlStr) {
      'open' => CoverDirection.opening,
      'close' => CoverDirection.closing,
      'stop' => CoverDirection.stopped,
      _ => CoverDirection.stopped,
    };

    return CoverState(
      position: position.clamp(0, 100),
      isMoving: direction != CoverDirection.stopped,
      direction: direction,
    );
  }

  @override
  Future<void> open({int channel = 1}) async {
    await _cover.openCover(switchNum: channel.toString());
    await refresh();
  }

  @override
  Future<void> close({int channel = 1}) async {
    await _cover.closeCover(switchNum: channel.toString());
    await refresh();
  }

  @override
  Future<void> stop({int channel = 1}) async {
    await _cover.stopCover(switchNum: channel.toString());
    await refresh();
  }
}
