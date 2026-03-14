// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Lap _$LapFromJson(Map<String, dynamic> json) => _Lap(
  number: (json['number'] as num).toInt(),
  elapsed: const _DurationConverter().fromJson(
    (json['elapsed'] as num).toInt(),
  ),
  delta: const _DurationConverter().fromJson((json['delta'] as num).toInt()),
);

Map<String, dynamic> _$LapToJson(_Lap instance) => <String, dynamic>{
  'number': instance.number,
  'elapsed': const _DurationConverter().toJson(instance.elapsed),
  'delta': const _DurationConverter().toJson(instance.delta),
};
