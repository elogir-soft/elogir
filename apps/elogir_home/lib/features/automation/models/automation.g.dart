// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Automation _$AutomationFromJson(Map<String, dynamic> json) => _Automation(
  id: json['id'] as String,
  name: json['name'] as String? ?? '',
  trigger: AutomationTrigger.fromJson(json['trigger'] as Map<String, dynamic>),
  actions: (json['actions'] as List<dynamic>)
      .map((e) => AutomationAction.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  isEnabled: json['isEnabled'] as bool? ?? true,
);

Map<String, dynamic> _$AutomationToJson(_Automation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'trigger': instance.trigger.toJson(),
      'actions': instance.actions.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isEnabled': instance.isEnabled,
    };
