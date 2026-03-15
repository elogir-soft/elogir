import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculator_state.freezed.dart';
part 'calculator_state.g.dart';

@freezed
abstract class CalculatorState with _$CalculatorState {
  const factory CalculatorState({
    @Default('') String expression,
    @Default('0') String display,
    @Default('') String preview,
    @Default(false) bool hasError,
    @Default(false) bool isScientific,
    @Default(true) bool isDegrees,
    @Default(false) bool justEvaluated,
  }) = _CalculatorState;

  factory CalculatorState.fromJson(Map<String, dynamic> json) =>
      _$CalculatorStateFromJson(json);
}
