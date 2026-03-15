import 'package:freezed_annotation/freezed_annotation.dart';

part 'light_state.freezed.dart';
part 'light_state.g.dart';

enum LightMode {
  white,
  colour,
  scene,
  music,
}

@freezed
sealed class LightState with _$LightState {
  const factory LightState({
    @Default(false) bool isOn,
    @Default(100) int brightness,
    @Default(255) int r,
    @Default(255) int g,
    @Default(255) int b,
    @Default(50) int colorTemp,
    @Default(LightMode.white) LightMode mode,
  }) = _LightState;

  factory LightState.fromJson(Map<String, dynamic> json) =>
      _$LightStateFromJson(json);
}
