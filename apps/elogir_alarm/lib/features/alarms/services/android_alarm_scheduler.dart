import 'package:alarm/alarm.dart' as native;
import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/alarms/services/alarm_scheduler.dart';

/// Android alarm scheduler using the `alarm` package (AlarmManager).
///
/// IDs are derived from the UUID hash since the alarm package requires int IDs.
/// Repeat alarms schedule only the next occurrence; after dismiss the
/// ringing screen reschedules the following one.
class AndroidAlarmScheduler implements AlarmScheduler {
  @override
  Future<void> init() => native.Alarm.init();

  @override
  Future<String?> schedule(Alarm alarm) async {
    await native.Alarm.set(
      alarmSettings: native.AlarmSettings(
        id: _id(alarm.id),
        dateTime: alarm.nextOccurrence(),
        volumeSettings: const native.VolumeSettings.fixed(),
        notificationSettings: native.NotificationSettings(
          title: alarm.label.isEmpty ? 'Alarm' : alarm.label,
          body: alarm.timeFormatted,
          stopButton: 'Dismiss',
        ),
        assetAudioPath: AppConstants.soundAssetPath(alarm.soundId),
        loopAudio: true,
        vibrate: true,
        androidFullScreenIntent: true,
        warningNotificationOnKill: false,
      ),
    );
    // Android derives the native ID deterministically; nothing to store in DB.
    return null;
  }

  @override
  Future<void> cancel(String alarmId, {String? nativeId}) =>
      native.Alarm.stop(_id(alarmId));

  @override
  Future<void> cancelAll() => native.Alarm.stopAll();

  int _id(String uuid) => uuid.hashCode.abs().clamp(1, 0x7FFFFFFF);
}
