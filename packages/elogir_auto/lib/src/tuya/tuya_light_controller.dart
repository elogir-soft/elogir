import 'package:tinytuya/tinytuya.dart' as tuya;

import '../controllers/light_controller.dart';
import '../models/light_state.dart';
import '../models/smart_device.dart';
import 'tuya_device_controller.dart';

class TuyaLightController extends TuyaDeviceController<LightState>
    implements LightController {
  TuyaLightController(super.device);

  tuya.BulbDevice get _bulb => tuyaDevice! as tuya.BulbDevice;

  @override
  tuya.BulbDevice createTuyaDevice() {
    final connection = device.connection as TuyaConnection;
    return tuya.BulbDevice(
      deviceId: connection.deviceId,
      address: connection.address,
      localKey: connection.localKey,
      version: connection.version,
      port: connection.port,
    );
  }

  @override
  LightState parseState(Map<String, dynamic> dps) {
    final isOn = dps['20'] as bool? ?? dps['1'] as bool? ?? false;
    final brightness = dps['22'] as int? ?? dps['2'] as int? ?? 100;
    final colorTemp = dps['23'] as int? ?? dps['3'] as int? ?? 0;
    final modeStr = dps['21'] as String? ?? dps['2'] as String?;
    final colourHex = dps['24'] as String? ?? dps['5'] as String?;

    var r = 255;
    var g = 255;
    var b = 255;
    if (colourHex != null && colourHex.isNotEmpty) {
      try {
        final rgb = tuya.BulbDevice.hexvalueToRgb(colourHex);
        r = rgb[0];
        g = rgb[1];
        b = rgb[2];
      } on Object {
        // keep defaults on parse failure
      }
    }

    return LightState(
      isOn: isOn,
      brightness: _scaleTo100(brightness, 1000),
      colorTemp: _scaleTo100(colorTemp, 1000),
      r: r,
      g: g,
      b: b,
      mode: _parseMode(modeStr),
    );
  }

  @override
  Future<void> turnOn() async {
    await _bulb.turnOn();
    await refresh();
  }

  @override
  Future<void> turnOff() async {
    await _bulb.turnOff();
    await refresh();
  }

  @override
  Future<void> setBrightness(int percentage) async {
    await _bulb.setBrightnessPercentage(percentage);
    await refresh();
  }

  @override
  Future<void> setColor(int r, int g, int b) async {
    await _bulb.setColour(r, g, b);
    await refresh();
  }

  @override
  Future<void> setColorTemperature(int percentage) async {
    await _bulb.setColourTempPercentage(percentage);
    await refresh();
  }

  @override
  Future<void> setMode(LightMode mode) async {
    await _bulb.setMode(_modeToString(mode));
    await refresh();
  }

  static int _scaleTo100(int value, int max) =>
      max > 0 ? (value * 100 / max).round().clamp(0, 100) : 0;

  static LightMode _parseMode(String? mode) {
    return switch (mode) {
      'white' => LightMode.white,
      'colour' => LightMode.colour,
      'scene' => LightMode.scene,
      'music' => LightMode.music,
      _ => LightMode.white,
    };
  }

  static String _modeToString(LightMode mode) {
    return switch (mode) {
      LightMode.white => tuya.BulbDevice.dpsModeWhite,
      LightMode.colour => tuya.BulbDevice.dpsModeColour,
      LightMode.scene => tuya.BulbDevice.dpsModeScene,
      LightMode.music => tuya.BulbDevice.dpsModeMusic,
    };
  }
}
