import 'dart:math' as math;

import '../controllers/light_controller.dart';
import '../models/light_state.dart';
import 'tuya_cloud_device_controller.dart';

class TuyaCloudLightController extends TuyaCloudDeviceController<LightState>
    implements LightController {
  TuyaCloudLightController(super.device, super.cloudService);

  @override
  LightState parseCloudStatus(Map<String, dynamic> codes) {
    final isOn = codes['switch_led'] as bool? ?? false;
    final rawBrightness =
        codes['bright_value_v2'] as int? ?? codes['bright_value'] as int? ?? 100;
    final rawColorTemp =
        codes['temp_value_v2'] as int? ?? codes['temp_value'] as int? ?? 0;
    final modeStr = codes['work_mode'] as String?;
    final colourHex =
        codes['colour_data_v2'] as String? ?? codes['colour_data'] as String?;

    var r = 255;
    var g = 255;
    var b = 255;
    if (colourHex != null && colourHex.isNotEmpty) {
      final rgb = _parseHsvHex(colourHex);
      r = rgb[0];
      g = rgb[1];
      b = rgb[2];
    }

    return LightState(
      isOn: isOn,
      brightness: _scaleTo100(rawBrightness, 1000),
      colorTemp: _scaleTo100(rawColorTemp, 1000),
      r: r,
      g: g,
      b: b,
      mode: _parseMode(modeStr),
    );
  }

  @override
  Future<void> turnOn() async {
    await sendCloudCommand(
      [{'code': 'switch_led', 'value': true}],
      expectedState: currentState?.copyWith(isOn: true),
    );
  }

  @override
  Future<void> turnOff() async {
    await sendCloudCommand(
      [{'code': 'switch_led', 'value': false}],
      expectedState: currentState?.copyWith(isOn: false),
    );
  }

  @override
  Future<void> setBrightness(int percentage) async {
    await sendCloudCommand(
      [{'code': 'bright_value_v2', 'value': (percentage * 10).clamp(10, 1000)}],
      expectedState: currentState?.copyWith(brightness: percentage),
    );
  }

  @override
  Future<void> setColor(int r, int g, int b) async {
    final hsv = _rgbToHsv(r, g, b);
    final hex = _hsvToHex(hsv[0], hsv[1], hsv[2]);
    await sendCloudCommand(
      [{'code': 'colour_data_v2', 'value': hex}],
      expectedState: currentState?.copyWith(r: r, g: g, b: b),
    );
  }

  @override
  Future<void> setColorTemperature(int percentage) async {
    await sendCloudCommand(
      [{'code': 'temp_value_v2', 'value': (percentage * 10).clamp(0, 1000)}],
      expectedState: currentState?.copyWith(colorTemp: percentage),
    );
  }

  @override
  Future<void> setMode(LightMode mode) async {
    await sendCloudCommand(
      [{'code': 'work_mode', 'value': _modeToString(mode)}],
      expectedState: currentState?.copyWith(mode: mode),
    );
  }

  // -- Helpers ---------------------------------------------------------------

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
      LightMode.white => 'white',
      LightMode.colour => 'colour',
      LightMode.scene => 'scene',
      LightMode.music => 'music',
    };
  }

  /// Parses Tuya v2 HSV hex format: HHHH SSSS VVVV (12 hex chars, 4 per component).
  /// H: 0-360, S: 0-1000, V: 0-1000.
  static List<int> _parseHsvHex(String hex) {
    if (hex.length < 12) return [255, 255, 255];
    try {
      final h = int.parse(hex.substring(0, 4), radix: 16);
      final s = int.parse(hex.substring(4, 8), radix: 16) / 1000;
      final v = int.parse(hex.substring(8, 12), radix: 16) / 1000;
      return _hsvToRgb(h.toDouble(), s, v);
    } on Object {
      return [255, 255, 255];
    }
  }

  static List<int> _hsvToRgb(double h, double s, double v) {
    final c = v * s;
    final x = c * (1 - ((h / 60) % 2 - 1).abs());
    final m = v - c;
    double r, g, b;
    if (h < 60) {
      (r, g, b) = (c, x, 0.0);
    } else if (h < 120) {
      (r, g, b) = (x, c, 0.0);
    } else if (h < 180) {
      (r, g, b) = (0.0, c, x);
    } else if (h < 240) {
      (r, g, b) = (0.0, x, c);
    } else if (h < 300) {
      (r, g, b) = (x, 0.0, c);
    } else {
      (r, g, b) = (c, 0.0, x);
    }
    return [
      ((r + m) * 255).round().clamp(0, 255),
      ((g + m) * 255).round().clamp(0, 255),
      ((b + m) * 255).round().clamp(0, 255),
    ];
  }

  /// Converts RGB (0-255) to [h (0-360), s (0-1000), v (0-1000)].
  static List<int> _rgbToHsv(int r, int g, int b) {
    final rf = r / 255;
    final gf = g / 255;
    final bf = b / 255;
    final cMax = math.max(rf, math.max(gf, bf));
    final cMin = math.min(rf, math.min(gf, bf));
    final delta = cMax - cMin;

    double h;
    if (delta == 0) {
      h = 0;
    } else if (cMax == rf) {
      h = 60 * (((gf - bf) / delta) % 6);
    } else if (cMax == gf) {
      h = 60 * (((bf - rf) / delta) + 2);
    } else {
      h = 60 * (((rf - gf) / delta) + 4);
    }
    if (h < 0) h += 360;

    final s = cMax == 0 ? 0.0 : delta / cMax;
    return [h.round(), (s * 1000).round(), (cMax * 1000).round()];
  }

  /// Encodes HSV to Tuya v2 hex: HHHH SSSS VVVV.
  static String _hsvToHex(int h, int s, int v) {
    return h.toRadixString(16).padLeft(4, '0') +
        s.toRadixString(16).padLeft(4, '0') +
        v.toRadixString(16).padLeft(4, '0');
  }
}
