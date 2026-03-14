import 'dart:async';

import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/features/stopwatch/models/lap.dart';
import 'package:elogir_alarm/features/stopwatch/models/stopwatch_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stopwatch_provider.g.dart';

/// Manages stopwatch state with high-frequency tick updates.
///
/// Uses [Timer.periodic] for ~60fps updates. Ephemeral — no persistence.
@Riverpod(keepAlive: true)
class StopwatchNotifier extends _$StopwatchNotifier {
  Timer? _timer;
  DateTime? _startedAt;

  /// The base elapsed time accumulated before the current run.
  Duration _baseElapsed = Duration.zero;

  @override
  StopwatchState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return const StopwatchState();
  }

  /// Start or resume the stopwatch.
  void start() {
    if (state.isRunning) return;

    _startedAt = DateTime.now();
    _baseElapsed = state.elapsed;

    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: AppConstants.stopwatchTickIntervalMs),
      (_) => _tick(),
    );

    state = state.copyWith(isRunning: true);
  }

  /// Stop (pause) the stopwatch.
  void stop() {
    if (!state.isRunning) return;

    _timer?.cancel();
    _timer = null;

    // Finalize elapsed time.
    if (_startedAt != null) {
      _baseElapsed += DateTime.now().difference(_startedAt!);
      _startedAt = null;
    }

    state = state.copyWith(
      isRunning: false,
      elapsed: _baseElapsed,
    );
  }

  /// Record a lap.
  void lap() {
    if (!state.isRunning) return;

    final currentElapsed = _currentElapsed();
    final previousLapElapsed =
        state.laps.isEmpty ? Duration.zero : state.laps.first.elapsed;
    final delta = currentElapsed - previousLapElapsed;

    final newLap = Lap(
      number: state.laps.length + 1,
      elapsed: currentElapsed,
      delta: delta,
    );

    state = state.copyWith(
      laps: [newLap, ...state.laps],
      elapsed: currentElapsed,
    );
  }

  /// Reset the stopwatch to zero.
  void reset() {
    _timer?.cancel();
    _timer = null;
    _startedAt = null;
    _baseElapsed = Duration.zero;

    state = const StopwatchState();
  }

  void _tick() {
    state = state.copyWith(elapsed: _currentElapsed());
  }

  Duration _currentElapsed() {
    if (_startedAt == null) return _baseElapsed;
    return _baseElapsed + DateTime.now().difference(_startedAt!);
  }
}
