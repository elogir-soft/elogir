// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tuya_credentials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TuyaCredentials _$TuyaCredentialsFromJson(Map<String, dynamic> json) =>
    _TuyaCredentials(
      apiKey: json['apiKey'] as String,
      apiSecret: json['apiSecret'] as String,
      region: json['region'] as String,
    );

Map<String, dynamic> _$TuyaCredentialsToJson(_TuyaCredentials instance) =>
    <String, dynamic>{
      'apiKey': instance.apiKey,
      'apiSecret': instance.apiSecret,
      'region': instance.region,
    };
