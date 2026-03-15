import '../models/switch_state.dart';
import 'device_controller.dart';

abstract class SwitchController extends DeviceController<SwitchState> {
  Future<void> turnOn({int channel = 1});
  Future<void> turnOff({int channel = 1});
  Future<void> toggle({int channel = 1});
}
