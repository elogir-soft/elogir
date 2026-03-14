import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/alarms/providers/alarm_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarms_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<List<Alarm>> alarms(Ref ref) {
  return ref.watch(alarmRepositoryProvider).watchAll();
}

@Riverpod(keepAlive: true)
Stream<List<Alarm>> enabledAlarms(Ref ref) {
  return ref.watch(alarmsProvider.future).asStream().asyncExpand(
        (_) => ref.watch(alarmRepositoryProvider).watchAll().map(
              (alarms) => alarms.where((a) => a.isEnabled).toList(),
            ),
      );
}
