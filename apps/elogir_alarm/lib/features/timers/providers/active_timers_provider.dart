import 'dart:async';

import 'package:alarm/alarm.dart' as native;
import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/features/settings/providers/settings_provider.dart';
import 'package:elogir_alarm/features/timers/models/app_timer.dart';
import 'package:elogir_alarm/features/timers/providers/timer_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'active_timers_provider.g.dart';

/// Manages in-memory timer ticking with periodic Drift persistence.
///
/// Loads initial state from Drift, ticks running timers every 100ms,
/// and flushes state to Drift every 5 seconds. Schedules native alarms
/// via the `alarm` package so timers ring even when the app is closed.
@Riverpod(keepAlive: true)
class ActiveTimers extends _$ActiveTimers {
  Timer? _tickTimer;
  Timer? _persistTimer;
  final _uuid = const Uuid();

  @override
  List<AppTimer> build() {
    _hydrateFromDrift();
    _startTickLoop();
    _startPersistLoop();

    ref.onDispose(() {
      _tickTimer?.cancel();
      _persistTimer?.cancel();
    });

    return [];
  }

  /// One-time load from Drift on cold start. Adjusts running timers for
  /// wall-clock elapsed time while the app was closed.
  Future<void> _hydrateFromDrift() async {
    final repo = ref.read(timerRepositoryProvider);
    final timers = await repo.watchAll().first;
    final now = DateTime.now();
    state = timers.map((AppTimer t) {
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
    // Native alarm handles sound + notification on both platforms.
  }

  Future<void> _persistAll() async {
    final repo = ref.read(timerRepositoryProvider);
    final now = DateTime.now();
    for (final timer in state) {
      // For running timers, stamp startedAt with the current time so that
      // _hydrateFromDrift can compute correct remaining time on the next cold
      // start: remaining = remainingMs - (T_reopen - startedAt).
      // Without this, startedAt stays at the original start/resume time while
      // remainingMs is already decremented, causing double-subtraction.
      final toSave = timer.status == TimerStatus.running
          ? timer.copyWith(startedAt: now)
          : timer;
      await repo.save(toSave);
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
    _scheduleNativeAlarm(
      timer.id,
      now.add(Duration(milliseconds: durationMs)),
      label,
    );
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
    _cancelNativeAlarm(id);
  }

  /// Resume a paused timer.
  void resume(String id) {
    final now = DateTime.now();
    AppTimer? resumed;
    state = state.map((t) {
      if (t.id != id || t.status != TimerStatus.paused) return t;
      resumed = t.copyWith(
        status: TimerStatus.running,
        startedAt: now,
        pausedAt: null,
      );
      return resumed!;
    }).toList();
    if (resumed != null) {
      _scheduleNativeAlarm(
        id,
        now.add(Duration(milliseconds: resumed!.remainingMs)),
        resumed!.label,
      );
    }
  }

  /// Cancel a timer.
  void cancel(String id) {
    state = state.map((t) {
      if (t.id != id) return t;
      return t.copyWith(status: TimerStatus.cancelled);
    }).toList();
    _cancelNativeAlarm(id);
  }

  /// Remove a timer from the list and database.
  Future<void> remove(String id) async {
    state = state.where((t) => t.id != id).toList();
    _cancelNativeAlarm(id);
    await ref.read(timerRepositoryProvider).delete(id);
  }

  /// Mark a timer as completed immediately (e.g. after the user dismisses the
  /// ringing screen). Prevents the tick loop from running the timer down to
  /// zero a second time with no alarm to ring.
  void markCompleted(String id) {
    state = state.map((t) {
      if (t.id != id) return t;
      return t.copyWith(status: TimerStatus.completed, remainingMs: 0);
    }).toList();
  }

  /// Remove all completed/cancelled timers.
  Future<void> clearFinished() async {
    final finished = state.where((t) => !t.status.isActive).toList();
    for (final t in finished) {
      _cancelNativeAlarm(t.id);
    }
    state = state.where((t) => t.status.isActive).toList();
    await ref.read(timerRepositoryProvider).deleteFinished();
  }

  /// Restart a completed timer from the beginning.
  void restart(String id) {
    final now = DateTime.now();
    AppTimer? restarted;
    state = state.map((t) {
      if (t.id != id) return t;
      restarted = t.copyWith(
        remainingMs: t.durationMs,
        status: TimerStatus.running,
        startedAt: now,
        pausedAt: null,
      );
      return restarted!;
    }).toList();
    if (restarted != null) {
      _scheduleNativeAlarm(
        id,
        now.add(Duration(milliseconds: restarted!.durationMs)),
        restarted!.label,
      );
    }
  }

  // ── Native alarm helpers ────────────────────────────────────────────

  int _nativeId(String uuid) => uuid.hashCode.abs().clamp(1, 0x7FFFFFFF);

  String _timerSoundAsset() {
    final soundId =
        ref.read(settingsProvider).value?.timerSoundId ?? 'marimba';
    return AppConstants.soundAssetPath(soundId);
  }

  void _scheduleNativeAlarm(String id, DateTime fireAt, String label) {
    native.Alarm.set(
      alarmSettings: native.AlarmSettings(
        id: _nativeId(id),
        dateTime: fireAt,
        volumeSettings: const native.VolumeSettings.fixed(),
        notificationSettings: native.NotificationSettings(
          title: label.isEmpty ? 'Timer' : label,
          body: 'Time is up!',
          stopButton: 'Dismiss',
        ),
        assetAudioPath: _timerSoundAsset(),
        vibrate: true,
        androidFullScreenIntent: true,
        warningNotificationOnKill: false,
      ),
    );
  }

  void _cancelNativeAlarm(String id) {
    native.Alarm.stop(_nativeId(id));
  }
}
