// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SmartDevice _$SmartDeviceFromJson(Map<String, dynamic> json) => _SmartDevice(
  id: json['id'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$DeviceTypeEnumMap, json['type']),
  connection: DeviceConnection.fromJson(
    json['connection'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$SmartDeviceToJson(_SmartDevice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$DeviceTypeEnumMap[instance.type]!,
      'connection': instance.connection.toJson(),
    };

const _$DeviceTypeEnumMap = {
  DeviceType.light: 'light',
  DeviceType.switchDevice: 'switchDevice',
  DeviceType.cover: 'cover',
};

TuyaConnection _$TuyaConnectionFromJson(Map<String, dynamic> json) =>
    TuyaConnection(
      deviceId: json['deviceId'] as String,
      address: json['address'] as String,
      localKey: json['localKey'] as String,
      version: (json['version'] as num?)?.toDouble() ?? 3.3,
      port: (json['port'] as num?)?.toInt() ?? 6668,
    );

Map<String, dynamic> _$TuyaConnectionToJson(TuyaConnection instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'address': instance.address,
      'localKey': instance.localKey,
      'version': instance.version,
      'port': instance.port,
    };
