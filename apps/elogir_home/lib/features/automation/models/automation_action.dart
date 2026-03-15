import 'package:freezed_annotation/freezed_annotation.dart';

part 'automation_action.freezed.dart';
part 'automation_action.g.dart';

/// A single device command to execute when an automation fires.
@Freezed(unionKey: 'type')
abstract class AutomationAction with _$AutomationAction {
  const factory AutomationAction.turnOn({
    required String deviceId,
  }) = TurnOnAction;

  const factory AutomationAction.turnOff({
    required String deviceId,
  }) = TurnOffAction;

  const factory AutomationAction.setBrightness({
    required String deviceId,
    required int percentage,
  }) = SetBrightnessAction;

  const factory AutomationAction.setColor({
    required String deviceId,
    required int r,
    required int g,
    required int b,
  }) = SetColorAction;

  const factory AutomationAction.setColorTemperature({
    required String deviceId,
    required int percentage,
  }) = SetColorTemperatureAction;

  const factory AutomationAction.openCover({
    required String deviceId,
  }) = OpenCoverAction;

  const factory AutomationAction.closeCover({
    required String deviceId,
  }) = CloseCoverAction;

  const factory AutomationAction.switchOn({
    required String deviceId,
  }) = SwitchOnAction;

  const factory AutomationAction.switchOff({
    required String deviceId,
  }) = SwitchOffAction;

  factory AutomationAction.fromJson(Map<String, dynamic> json) =>
      _$AutomationActionFromJson(json);
}
