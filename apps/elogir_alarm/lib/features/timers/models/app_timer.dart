import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_timer.freezed.dart';
part 'app_timer.g.dart';

/// Status of a timer.
enum TimerStatus {
  running,
  paused,
  completed,
  cancelled;

  /// Whether the timer is still active (not finished).
  bool get isActive => this == running || this == paused;
}

/// Named `AppTimer` to avoid collision with `dart:async` `Timer`.
@freezed
abstract class AppTimer with _$AppTimer {
  const factory AppTimer({
    required String id,
    @Default('') String label,
    required int durationMs,
    required int remainingMs,
    required TimerStatus status,
    DateTime? startedAt,
    DateTime? pausedAt,
    required DateTime createdAt,
  }) = _AppTimer;

  const AppTimer._();

  factory AppTimer.fromJson(Map<String, dynamic> json) =>
      _$AppTimerFromJson(json);

  /// Progress from 0.0 (just started) to 1.0 (completed).
  double get progress {
    if (durationMs == 0) return 1;
    return 1 - (remainingMs / durationMs).clamp(0, 1);
  }

  /// Remaining time as a Duration.
  Duration get remaining => Duration(milliseconds: remainingMs);

  /// Total duration as a Duration.
  Duration get duration => Duration(milliseconds: durationMs);
}
