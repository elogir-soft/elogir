import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/features/automation/models/automation_action.dart';
import 'package:talker/talker.dart';

/// Executes [AutomationAction]s by looking up the device and calling the
/// appropriate controller method on [ElogirAuto].
class AutomationExecutor {
  const AutomationExecutor({
    required ElogirAuto elogirAuto,
    required DeviceDao deviceDao,
    required Talker talker,
  })  : _elogirAuto = elogirAuto,
        _deviceDao = deviceDao,
        _talker = talker;

  final ElogirAuto _elogirAuto;
  final DeviceDao _deviceDao;
  final Talker _talker;

  /// Execute a single action. Returns `true` if the command was sent.
  Future<bool> execute(AutomationAction action) async {
    final deviceId = _deviceIdFor(action);
    final device = await _deviceDao.getById(deviceId);
    if (device == null) {
      _talker.warning('Automation: device $deviceId not found, skipping');
      return false;
    }

    try {
      final controller = _elogirAuto.controllerFor(device);
      await controller.connect();

      await switch (action) {
        TurnOnAction() => (controller as LightController).turnOn(),
        TurnOffAction() => (controller as LightController).turnOff(),
        SetBrightnessAction(:final percentage) =>
          (controller as LightController).setBrightness(percentage),
        SetColorAction(:final r, :final g, :final b) =>
          (controller as LightController).setColor(r, g, b),
        SetColorTemperatureAction(:final percentage) =>
          (controller as LightController).setColorTemperature(percentage),
        OpenCoverAction() => (controller as CoverController).open(),
        CloseCoverAction() => (controller as CoverController).close(),
        SwitchOnAction() => (controller as SwitchController).turnOn(),
        SwitchOffAction() => (controller as SwitchController).turnOff(),
        _ => throw StateError('Unknown action type: ${action.runtimeType}'),
      };

      _talker.info('Automation: executed ${action.runtimeType} on $deviceId');
      return true;
    } on Object catch (e) {
      _talker.error(
        'Automation: failed to execute ${action.runtimeType} on $deviceId',
        e,
      );
      return false;
    }
  }

  /// Execute all actions in a list sequentially.
  Future<void> executeAll(List<AutomationAction> actions) async {
    for (final action in actions) {
      await execute(action);
    }
  }

  String _deviceIdFor(AutomationAction action) {
    return switch (action) {
      TurnOnAction(:final deviceId) => deviceId,
      TurnOffAction(:final deviceId) => deviceId,
      SetBrightnessAction(:final deviceId) => deviceId,
      SetColorAction(:final deviceId) => deviceId,
      SetColorTemperatureAction(:final deviceId) => deviceId,
      OpenCoverAction(:final deviceId) => deviceId,
      CloseCoverAction(:final deviceId) => deviceId,
      SwitchOnAction(:final deviceId) => deviceId,
      SwitchOffAction(:final deviceId) => deviceId,
      _ => throw StateError('Unknown action type: ${action.runtimeType}'),
    };
  }
}
