import '../models/cover_state.dart';
import 'device_controller.dart';

abstract class CoverController extends DeviceController<CoverState> {
  Future<void> open({int channel = 1});
  Future<void> close({int channel = 1});
  Future<void> stop({int channel = 1});
}
