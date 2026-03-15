import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/alarms/services/alarm_scheduler.dart';
import 'package:flutter_alarmkit/flutter_alarmkit.dart';

/// iOS alarm scheduler using Apple's AlarmKit (iOS 26+).
///
/// Returns the AlarmKit UUID on [schedule] so the caller can persist it for
/// later cancellation. Recurrent alarms use [scheduleRecurrentAlarm];
/// one-shot alarms use [scheduleOneShotAlarm].
class IosAlarmScheduler implements AlarmScheduler {
  final _alarmkit = FlutterAlarmkit();

  @override
  Future<void> init() async {
    await _alarmkit.requestAuthorization();
  }

  @override
  Future<String?> schedule(Alarm alarm) async {
    if (alarm.repeatDays.isNotEmpty) {
      return _alarmkit.scheduleRecurrentAlarm(
        weekdays: alarm.repeatDays.map((d) => Weekday.values[d]).toSet(),
        hour: alarm.hour,
        minute: alarm.minute,
        label: alarm.label.isEmpty ? 'Alarm' : alarm.label,
      );
    }
    return _alarmkit.scheduleOneShotAlarm(
      timestamp: alarm.nextOccurrence().millisecondsSinceEpoch.toDouble(),
      label: alarm.label.isEmpty ? 'Alarm' : alarm.label,
    );
  }

  @override
  Future<void> cancel(String alarmId, {String? nativeId}) async {
    if (nativeId != null) {
      await _alarmkit.cancelAlarm(alarmId: nativeId);
    }
  }

  @override
  Future<void> cancelAll() async {
    final alarms = await _alarmkit.getAlarms();
    for (final a in alarms) {
      final id = a['alarmId'] as String?;
      if (id != null) await _alarmkit.cancelAlarm(alarmId: id);
    }
  }
}
