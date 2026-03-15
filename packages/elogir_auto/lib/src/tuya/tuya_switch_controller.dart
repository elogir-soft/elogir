import 'package:tinytuya/tinytuya.dart' as tuya;

import '../controllers/switch_controller.dart';
import '../models/smart_device.dart';
import '../models/switch_state.dart';
import 'tuya_device_controller.dart';

class TuyaSwitchController extends TuyaDeviceController<SwitchState>
    implements SwitchController {
  TuyaSwitchController(super.device);

  tuya.OutletDevice get _outlet => tuyaDevice! as tuya.OutletDevice;

  @override
  tuya.OutletDevice createTuyaDevice() {
    final connection = device.connection as TuyaConnection;
    return tuya.OutletDevice(
      deviceId: connection.deviceId,
      address: connection.address,
      localKey: connection.localKey,
      version: connection.version,
      port: connection.port,
    );
  }

  @override
  SwitchState parseState(Map<String, dynamic> dps) {
    final channels = <int, bool>{};
    for (final entry in dps.entries) {
      final index = int.tryParse(entry.key);
      if (index != null && entry.value is bool) {
        channels[index] = entry.value as bool;
      }
    }
    return SwitchState(channels: channels);
  }

  @override
  Future<void> turnOn({int channel = 1}) async {
    await _outlet.turnOn(switchNum: channel.toString());
    await refresh();
  }

  @override
  Future<void> turnOff({int channel = 1}) async {
    await _outlet.turnOff(switchNum: channel.toString());
    await refresh();
  }

  @override
  Future<void> toggle({int channel = 1}) async {
    final current = currentState?.channels[channel] ?? false;
    if (current) {
      await turnOff(channel: channel);
    } else {
      await turnOn(channel: channel);
    }
  }
}
