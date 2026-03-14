import 'package:elogir_alarm/features/timers/repositories/timer_repository.dart';
import 'package:elogir_alarm/shared/providers/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_repository_provider.g.dart';

@riverpod
TimerRepository timerRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return TimerRepository(db.timerDao);
}
