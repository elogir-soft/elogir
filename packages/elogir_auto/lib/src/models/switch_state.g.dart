// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SwitchState _$SwitchStateFromJson(Map<String, dynamic> json) => _SwitchState(
  channels:
      (json['channels'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k), e as bool),
      ) ??
      const {},
);

Map<String, dynamic> _$SwitchStateToJson(_SwitchState instance) =>
    <String, dynamic>{
      'channels': instance.channels.map((k, e) => MapEntry(k.toString(), e)),
    };
