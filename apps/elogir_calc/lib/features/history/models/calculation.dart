import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculation.freezed.dart';
part 'calculation.g.dart';

@freezed
abstract class Calculation with _$Calculation {
  const factory Calculation({
    required String id,
    required String expression,
    required String result,
    required DateTime createdAt,
  }) = _Calculation;

  factory Calculation.fromJson(Map<String, dynamic> json) =>
      _$CalculationFromJson(json);
}
