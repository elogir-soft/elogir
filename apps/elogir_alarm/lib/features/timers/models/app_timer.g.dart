// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_timer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppTimer _$AppTimerFromJson(Map<String, dynamic> json) => _AppTimer(
  id: json['id'] as String,
  durationMs: (json['durationMs'] as num).toInt(),
  remainingMs: (json['remainingMs'] as num).toInt(),
  status: $enumDecode(_$TimerStatusEnumMap, json['status']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  label: json['label'] as String? ?? '',
  startedAt: json['startedAt'] == null
      ? null
      : DateTime.parse(json['startedAt'] as String),
  pausedAt: json['pausedAt'] == null
      ? null
      : DateTime.parse(json['pausedAt'] as String),
);

Map<String, dynamic> _$AppTimerToJson(_AppTimer instance) => <String, dynamic>{
  'id': instance.id,
  'durationMs': instance.durationMs,
  'remainingMs': instance.remainingMs,
  'status': _$TimerStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'label': instance.label,
  'startedAt': instance.startedAt?.toIso8601String(),
  'pausedAt': instance.pausedAt?.toIso8601String(),
};

const _$TimerStatusEnumMap = {
  TimerStatus.running: 'running',
  TimerStatus.paused: 'paused',
  TimerStatus.completed: 'completed',
  TimerStatus.cancelled: 'cancelled',
};
