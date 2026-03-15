// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScanResult _$ScanResultFromJson(Map<String, dynamic> json) => _ScanResult(
  ip: json['ip'] as String,
  deviceId: json['deviceId'] as String,
  version: json['version'] as String?,
  productKey: json['productKey'] as String?,
);

Map<String, dynamic> _$ScanResultToJson(_ScanResult instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'deviceId': instance.deviceId,
      'version': instance.version,
      'productKey': instance.productKey,
    };
