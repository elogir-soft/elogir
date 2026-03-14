// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Alarm _$AlarmFromJson(Map<String, dynamic> json) => _Alarm(
  id: json['id'] as String,
  hour: (json['hour'] as num).toInt(),
  minute: (json['minute'] as num).toInt(),
  label: json['label'] as String? ?? '',
  isEnabled: json['isEnabled'] as bool? ?? true,
  repeatDays:
      (json['repeatDays'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  soundId: json['soundId'] as String? ?? 'alarm',
  snoozeDurationMinutes: (json['snoozeDurationMinutes'] as num?)?.toInt() ?? 5,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$AlarmToJson(_Alarm instance) => <String, dynamic>{
  'id': instance.id,
  'hour': instance.hour,
  'minute': instance.minute,
  'label': instance.label,
  'isEnabled': instance.isEnabled,
  'repeatDays': instance.repeatDays,
  'soundId': instance.soundId,
  'snoozeDurationMinutes': instance.snoozeDurationMinutes,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
