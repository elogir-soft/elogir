// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Calculation _$CalculationFromJson(Map<String, dynamic> json) => _Calculation(
  id: json['id'] as String,
  expression: json['expression'] as String,
  result: json['result'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$CalculationToJson(_Calculation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expression': instance.expression,
      'result': instance.result,
      'createdAt': instance.createdAt.toIso8601String(),
    };
