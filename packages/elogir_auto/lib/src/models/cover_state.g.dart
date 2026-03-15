// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cover_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoverState _$CoverStateFromJson(Map<String, dynamic> json) => _CoverState(
  position: (json['position'] as num?)?.toInt() ?? 0,
  isMoving: json['isMoving'] as bool? ?? false,
  direction:
      $enumDecodeNullable(_$CoverDirectionEnumMap, json['direction']) ??
      CoverDirection.stopped,
);

Map<String, dynamic> _$CoverStateToJson(_CoverState instance) =>
    <String, dynamic>{
      'position': instance.position,
      'isMoving': instance.isMoving,
      'direction': _$CoverDirectionEnumMap[instance.direction]!,
    };

const _$CoverDirectionEnumMap = {
  CoverDirection.opening: 'opening',
  CoverDirection.closing: 'closing',
  CoverDirection.stopped: 'stopped',
};
