import '../controllers/cover_controller.dart';
import '../models/cover_state.dart';
import 'tuya_cloud_device_controller.dart';

class TuyaCloudCoverController extends TuyaCloudDeviceController<CoverState>
    implements CoverController {
  TuyaCloudCoverController(super.device, super.cloudService);

  @override
  CoverState parseCloudStatus(Map<String, dynamic> codes) {
    final controlStr =
        codes['control'] as String? ?? codes['mach'] as String?;
    final position =
        codes['percent_control'] as int? ?? codes['position'] as int? ?? 0;

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
    await sendCloudCommand(
      [{'code': 'control', 'value': 'open'}],
      expectedState: currentState?.copyWith(
        isMoving: true,
        direction: CoverDirection.opening,
      ),
    );
  }

  @override
  Future<void> close({int channel = 1}) async {
    await sendCloudCommand(
      [{'code': 'control', 'value': 'close'}],
      expectedState: currentState?.copyWith(
        isMoving: true,
        direction: CoverDirection.closing,
      ),
    );
  }

  @override
  Future<void> stop({int channel = 1}) async {
    await sendCloudCommand(
      [{'code': 'control', 'value': 'stop'}],
      expectedState: currentState?.copyWith(
        isMoving: false,
        direction: CoverDirection.stopped,
      ),
    );
  }
}
