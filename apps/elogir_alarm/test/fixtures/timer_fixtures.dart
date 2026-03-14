import 'package:elogir_alarm/features/timers/models/app_timer.dart';

/// Factory for creating test [AppTimer] instances with sensible defaults.
AppTimer createAppTimer({
  String id = 'test-timer-1',
  String label = 'Cooking',
  int durationMs = 300000, // 5 min
  int? remainingMs,
  TimerStatus status = TimerStatus.running,
  DateTime? startedAt,
  DateTime? pausedAt,
  DateTime? createdAt,
}) {
  final now = DateTime(2026, 3, 14);
  return AppTimer(
    id: id,
    label: label,
    durationMs: durationMs,
    remainingMs: remainingMs ?? durationMs,
    status: status,
    startedAt: startedAt ?? now,
    pausedAt: pausedAt,
    createdAt: createdAt ?? now,
  );
}

/// A list of sample timers for testing.
List<AppTimer> sampleTimers() => [
      createAppTimer(),
      createAppTimer(
        id: 'test-timer-2',
        label: 'Tea',
        durationMs: 180000, // 3 min
        remainingMs: 90000, // 1.5 min remaining
      ),
      createAppTimer(
        id: 'test-timer-3',
        label: 'Done',
        durationMs: 60000,
        remainingMs: 0,
        status: TimerStatus.completed,
      ),
    ];
