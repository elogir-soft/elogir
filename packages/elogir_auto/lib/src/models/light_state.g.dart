// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LightState _$LightStateFromJson(Map<String, dynamic> json) => _LightState(
  isOn: json['isOn'] as bool? ?? false,
  brightness: (json['brightness'] as num?)?.toInt() ?? 100,
  r: (json['r'] as num?)?.toInt() ?? 255,
  g: (json['g'] as num?)?.toInt() ?? 255,
  b: (json['b'] as num?)?.toInt() ?? 255,
  colorTemp: (json['colorTemp'] as num?)?.toInt() ?? 50,
  mode:
      $enumDecodeNullable(_$LightModeEnumMap, json['mode']) ?? LightMode.white,
);

Map<String, dynamic> _$LightStateToJson(_LightState instance) =>
    <String, dynamic>{
      'isOn': instance.isOn,
      'brightness': instance.brightness,
      'r': instance.r,
      'g': instance.g,
      'b': instance.b,
      'colorTemp': instance.colorTemp,
      'mode': _$LightModeEnumMap[instance.mode]!,
    };

const _$LightModeEnumMap = {
  LightMode.white: 'white',
  LightMode.colour: 'colour',
  LightMode.scene: 'scene',
  LightMode.music: 'music',
};
