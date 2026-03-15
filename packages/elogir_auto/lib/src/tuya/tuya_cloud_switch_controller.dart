import '../controllers/switch_controller.dart';
import '../models/switch_state.dart';
import 'tuya_cloud_device_controller.dart';

class TuyaCloudSwitchController extends TuyaCloudDeviceController<SwitchState>
    implements SwitchController {
  TuyaCloudSwitchController(super.device, super.cloudService);

  static final _switchPattern = RegExp(r'^switch(?:_(\d+))?$');

  /// Whether the device uses bare 'switch' code (no number suffix).
  bool _useBareSwitch = false;

  @override
  SwitchState parseCloudStatus(Map<String, dynamic> codes) {
    _useBareSwitch = codes.containsKey('switch');
    final channels = <int, bool>{};
    for (final entry in codes.entries) {
      final match = _switchPattern.firstMatch(entry.key);
      if (match != null && entry.value is bool) {
        // 'switch' (no number) → channel 1, 'switch_N' → channel N.
        final channel =
            match.group(1) != null ? int.parse(match.group(1)!) : 1;
        channels[channel] = entry.value as bool;
      }
    }
    return SwitchState(channels: channels);
  }

  /// Returns the cloud code for the given channel.
  String _codeForChannel(int channel) {
    if (channel == 1 && _useBareSwitch) return 'switch';
    return 'switch_$channel';
  }

  @override
  Future<void> turnOn({int channel = 1}) async {
    final expected = _withChannel(channel, value: true);
    await sendCloudCommand(
      [{'code': _codeForChannel(channel), 'value': true}],
      expectedState: expected,
    );
  }

  @override
  Future<void> turnOff({int channel = 1}) async {
    final expected = _withChannel(channel, value: false);
    await sendCloudCommand(
      [{'code': _codeForChannel(channel), 'value': false}],
      expectedState: expected,
    );
  }

  SwitchState _withChannel(int channel, {required bool value}) {
    final channels = Map<int, bool>.from(currentState?.channels ?? {});
    channels[channel] = value;
    return SwitchState(channels: channels);
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
