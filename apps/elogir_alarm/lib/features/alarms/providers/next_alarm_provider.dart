import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/alarms/providers/alarms_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'next_alarm_provider.g.dart';

/// Derives the soonest enabled alarm from the alarms list.
@riverpod
Alarm? nextAlarm(Ref ref) {
  final alarmsValue = ref.watch(alarmsProvider);
  return alarmsValue.whenOrNull(
    data: (alarms) {
      final enabled = alarms.where((a) => a.isEnabled).toList();
      if (enabled.isEmpty) return null;

      final now = DateTime.now();
      enabled.sort(
        (a, b) => a.nextOccurrence(now).compareTo(b.nextOccurrence(now)),
      );
      return enabled.first;
    },
  );
}
