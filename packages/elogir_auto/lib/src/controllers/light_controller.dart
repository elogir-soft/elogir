import '../models/light_state.dart';
import 'device_controller.dart';

abstract class LightController extends DeviceController<LightState> {
  Future<void> turnOn();
  Future<void> turnOff();
  Future<void> setBrightness(int percentage);
  Future<void> setColor(int r, int g, int b);
  Future<void> setColorTemperature(int percentage);
  Future<void> setMode(LightMode mode);
}
