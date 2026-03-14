import 'package:elogir_alarm/features/stopwatch/models/lap.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stopwatch_state.freezed.dart';

/// Immutable state for the stopwatch feature.
@freezed
abstract class StopwatchState with _$StopwatchState {
  const factory StopwatchState({
    @Default(Duration.zero) Duration elapsed,
    @Default(false) bool isRunning,
    @Default([]) List<Lap> laps,
  }) = _StopwatchState;

  const StopwatchState._();

  /// Whether the stopwatch has been started (even if currently paused).
  bool get hasStarted => elapsed > Duration.zero || laps.isNotEmpty;
}
