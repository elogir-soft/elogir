import 'package:freezed_annotation/freezed_annotation.dart';

import 'device_type.dart';

part 'smart_device.freezed.dart';
part 'smart_device.g.dart';

@freezed
sealed class SmartDevice with _$SmartDevice {
  const factory SmartDevice({
    required String id,
    required String name,
    required DeviceType type,
    required DeviceConnection connection,
  }) = _SmartDevice;

  factory SmartDevice.fromJson(Map<String, dynamic> json) =>
      _$SmartDeviceFromJson(json);
}

@Freezed(unionKey: 'platform')
sealed class DeviceConnection with _$DeviceConnection {
  @FreezedUnionValue('tuya')
  const factory DeviceConnection.tuya({
    required String deviceId,
    required String address,
    required String localKey,
    @Default(3.3) double version,
    @Default(6668) int port,
  }) = TuyaConnection;

  factory DeviceConnection.fromJson(Map<String, dynamic> json) =>
      _$DeviceConnectionFromJson(json);
}
