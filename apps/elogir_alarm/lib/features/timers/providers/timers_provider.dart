import 'package:elogir_alarm/features/timers/models/app_timer.dart';
import 'package:elogir_alarm/features/timers/providers/timer_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timers_provider.g.dart';

/// Watches all persisted timers from Drift.
@Riverpod(keepAlive: true)
Stream<List<AppTimer>> persistedTimers(Ref ref) {
  return ref.watch(timerRepositoryProvider).watchAll();
}
