// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automation_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TurnOnAction _$TurnOnActionFromJson(Map<String, dynamic> json) => TurnOnAction(
  deviceId: json['deviceId'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TurnOnActionToJson(TurnOnAction instance) =>
    <String, dynamic>{'deviceId': instance.deviceId, 'type': instance.$type};

TurnOffAction _$TurnOffActionFromJson(Map<String, dynamic> json) =>
    TurnOffAction(
      deviceId: json['deviceId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$TurnOffActionToJson(TurnOffAction instance) =>
    <String, dynamic>{'deviceId': instance.deviceId, 'type': instance.$type};

SetBrightnessAction _$SetBrightnessActionFromJson(Map<String, dynamic> json) =>
    SetBrightnessAction(
      deviceId: json['deviceId'] as String,
      percentage: (json['percentage'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SetBrightnessActionToJson(
  SetBrightnessAction instance,
) => <String, dynamic>{
  'deviceId': instance.deviceId,
  'percentage': instance.percentage,
  'type': instance.$type,
};

SetColorAction _$SetColorActionFromJson(Map<String, dynamic> json) =>
    SetColorAction(
      deviceId: json['deviceId'] as String,
      r: (json['r'] as num).toInt(),
      g: (json['g'] as num).toInt(),
      b: (json['b'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SetColorActionToJson(SetColorAction instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'r': instance.r,
      'g': instance.g,
      'b': instance.b,
      'type': instance.$type,
    };

SetColorTemperatureAction _$SetColorTemperatureActionFromJson(
  Map<String, dynamic> json,
) => SetColorTemperatureAction(
  deviceId: json['deviceId'] as String,
  percentage: (json['percentage'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SetColorTemperatureActionToJson(
  SetColorTemperatureAction instance,
) => <String, dynamic>{
  'deviceId': instance.deviceId,
  'percentage': instance.percentage,
  'type': instance.$type,
};

OpenCoverAction _$OpenCoverActionFromJson(Map<String, dynamic> json) =>
    OpenCoverAction(
      deviceId: json['deviceId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$OpenCoverActionToJson(OpenCoverAction instance) =>
    <String, dynamic>{'deviceId': instance.deviceId, 'type': instance.$type};

CloseCoverAction _$CloseCoverActionFromJson(Map<String, dynamic> json) =>
    CloseCoverAction(
      deviceId: json['deviceId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$CloseCoverActionToJson(CloseCoverAction instance) =>
    <String, dynamic>{'deviceId': instance.deviceId, 'type': instance.$type};

SwitchOnAction _$SwitchOnActionFromJson(Map<String, dynamic> json) =>
    SwitchOnAction(
      deviceId: json['deviceId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SwitchOnActionToJson(SwitchOnAction instance) =>
    <String, dynamic>{'deviceId': instance.deviceId, 'type': instance.$type};

SwitchOffAction _$SwitchOffActionFromJson(Map<String, dynamic> json) =>
    SwitchOffAction(
      deviceId: json['deviceId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SwitchOffActionToJson(SwitchOffAction instance) =>
    <String, dynamic>{'deviceId': instance.deviceId, 'type': instance.$type};
