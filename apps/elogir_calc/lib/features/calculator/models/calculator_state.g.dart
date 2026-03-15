// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalculatorState _$CalculatorStateFromJson(Map<String, dynamic> json) =>
    _CalculatorState(
      expression: json['expression'] as String? ?? '',
      display: json['display'] as String? ?? '0',
      preview: json['preview'] as String? ?? '',
      hasError: json['hasError'] as bool? ?? false,
      isScientific: json['isScientific'] as bool? ?? false,
      isDegrees: json['isDegrees'] as bool? ?? true,
      justEvaluated: json['justEvaluated'] as bool? ?? false,
    );

Map<String, dynamic> _$CalculatorStateToJson(_CalculatorState instance) =>
    <String, dynamic>{
      'expression': instance.expression,
      'display': instance.display,
      'preview': instance.preview,
      'hasError': instance.hasError,
      'isScientific': instance.isScientific,
      'isDegrees': instance.isDegrees,
      'justEvaluated': instance.justEvaluated,
    };
