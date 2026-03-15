import 'package:freezed_annotation/freezed_annotation.dart';

part 'cover_state.freezed.dart';
part 'cover_state.g.dart';

enum CoverDirection {
  opening,
  closing,
  stopped,
}

@freezed
sealed class CoverState with _$CoverState {
  const factory CoverState({
    @Default(0) int position,
    @Default(false) bool isMoving,
    @Default(CoverDirection.stopped) CoverDirection direction,
  }) = _CoverState;

  factory CoverState.fromJson(Map<String, dynamic> json) =>
      _$CoverStateFromJson(json);
}
