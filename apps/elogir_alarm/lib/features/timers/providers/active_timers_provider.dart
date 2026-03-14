import 'dart:async';

import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/features/timers/models/app_timer.dart';
import 'package:elogir_alarm/features/timers/providers/timer_repository_provider.dart';
import 'package:elogir_alarm/features/timers/providers/timers_provider.dart';
import 'package:elogir_alarm/shared/providers/audio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'active_timers_provider.g.dart';

/// Manages in-memory timer ticking with periodic Drift persistence.
///
/// Loads initial state from Drift, ticks running timers every 100ms,
/// and flushes state to Drift every 5 seconds.
@Riverpod(keepAlive: true)
class ActiveTimers extends _$ActiveTimers {
  Timer? _tickTimer;
  Timer? _persistTimer;
  final _uuid = const Uuid();

  @override
  List<AppTimer> build() {
    // Load initial state from Drift.
    final persisted = ref.watch(persistedTimersProvider);
    final timers = persisted.value ?? [];

    // Reconstruct running timers — adjust remaining time based on elapsed.
    final now = DateTime.now();
    final adjusted = timers.map((AppTimer t) {
      if (t.status == TimerStatus.running && t.startedAt != null) {
        final elapsed = now.difference(t.startedAt!).inMilliseconds;
        final remaining = (t.remainingMs - elapsed).clamp(0, t.durationMs);
        return t.copyWith(
          remainingMs: remaining,
          status: remaining <= 0 ? TimerStatus.completed : t.status,
        );
      }
      return t;
    }).toList();

    _startTickLoop();
    _startPersistLoop();

    ref.onDispose(() {
      _tickTimer?.cancel();
      _persistTimer?.cancel();
    });

    return adjusted;
  }

  void _startTickLoop() {
    _tickTimer?.cancel();
    _tickTimer = Timer.periodic(
      const Duration(milliseconds: AppConstants.timerTickIntervalMs),
      (_) => _tick(),
    );
  }

  void _startPersistLoop() {
    _persistTimer?.cancel();
    _persistTimer = Timer.periodic(
      const Duration(milliseconds: AppConstants.timerPersistIntervalMs),
      (_) => _persistAll(),
    );
  }

  void _tick() {
    final current = state;
    var changed = false;
    final updated = current.map((t) {
      if (t.status != TimerStatus.running) return t;

      final newRemaining =
          t.remainingMs - AppConstants.timerTickIntervalMs;
      if (newRemaining <= 0) {
        changed = true;
        _onTimerComplete(t);
        return t.copyWith(
          remainingMs: 0,
          status: TimerStatus.completed,
        );
      }

      changed = true;
      return t.copyWith(remainingMs: newRemaining);
    }).toList();

    if (changed) state = updated;
  }

  void _onTimerComplete(AppTimer timer) {
    ref.read(audioServiceProvider).play('notification');
  }

  Future<void> _persistAll() async {
    final repo = ref.read(timerRepositoryProvider);
    for (final timer in state) {
      await repo.save(timer);
    }
  }

  /// Create and start a new timer.
  void startNew({required int durationMs, String label = ''}) {
    final now = DateTime.now();
    final timer = AppTimer(
      id: _uuid.v4(),
      label: label,
      durationMs: durationMs,
      remainingMs: durationMs,
      status: TimerStatus.running,
      startedAt: now,
      createdAt: now,
    );
    state = [timer, ...state];
  }

  /// Pause a running timer.
  void pause(String id) {
    state = state.map((t) {
      if (t.id != id || t.status != TimerStatus.running) return t;
      return t.copyWith(
        status: TimerStatus.paused,
        pausedAt: DateTime.now(),
      );
    }).toList();
  }

  /// Resume a paused timer.
  void resume(String id) {
    state = state.map((t) {
      if (t.id != id || t.status != TimerStatus.paused) return t;
      return t.copyWith(
        status: TimerStatus.running,
        startedAt: DateTime.now(),
        pausedAt: null,
      );
    }).toList();
  }

  /// Cancel a timer.
  void cancel(String id) {
    state = state.map((t) {
      if (t.id != id) return t;
      return t.copyWith(status: TimerStatus.cancelled);
    }).toList();
  }

  /// Remove a timer from the list and database.
  Future<void> remove(String id) async {
    state = state.where((t) => t.id != id).toList();
    await ref.read(timerRepositoryProvider).delete(id);
  }

  /// Remove all completed/cancelled timers.
  Future<void> clearFinished() async {
    state = state.where((t) => t.status.isActive).toList();
    await ref.read(timerRepositoryProvider).deleteFinished();
  }
}
