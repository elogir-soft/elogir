import 'package:freezed_annotation/freezed_annotation.dart';

part 'switch_state.freezed.dart';
part 'switch_state.g.dart';

@freezed
sealed class SwitchState with _$SwitchState {
  const factory SwitchState({
    @Default({}) Map<int, bool> channels,
  }) = _SwitchState;

  factory SwitchState.fromJson(Map<String, dynamic> json) =>
      _$SwitchStateFromJson(json);
}
