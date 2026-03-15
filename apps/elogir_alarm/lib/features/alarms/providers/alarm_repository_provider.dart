import 'package:elogir_alarm/features/alarms/providers/alarm_scheduler_provider.dart';
import 'package:elogir_alarm/features/alarms/repositories/alarm_repository.dart';
import 'package:elogir_alarm/shared/providers/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AlarmRepository alarmRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  final scheduler = ref.watch(alarmSchedulerProvider);
  return AlarmRepository(db.alarmDao, scheduler);
}
