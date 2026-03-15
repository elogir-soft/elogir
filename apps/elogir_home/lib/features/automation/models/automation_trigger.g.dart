// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automation_trigger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecurringTrigger _$RecurringTriggerFromJson(Map<String, dynamic> json) =>
    RecurringTrigger(
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num).toInt(),
      repeatDays:
          (json['repeatDays'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$RecurringTriggerToJson(RecurringTrigger instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'minute': instance.minute,
      'repeatDays': instance.repeatDays,
      'type': instance.$type,
    };

OneTimeTrigger _$OneTimeTriggerFromJson(Map<String, dynamic> json) =>
    OneTimeTrigger(
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$OneTimeTriggerToJson(OneTimeTrigger instance) =>
    <String, dynamic>{
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'type': instance.$type,
    };
