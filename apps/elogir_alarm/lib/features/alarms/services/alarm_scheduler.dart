import 'dart:io';

import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/alarms/services/android_alarm_scheduler.dart';
import 'package:elogir_alarm/features/alarms/services/ios_alarm_scheduler.dart';

/// Abstracts platform-specific native alarm scheduling.
///
/// Android uses the `alarm` package (AlarmManager + foreground service).
/// iOS uses `flutter_alarmkit` (Apple AlarmKit, iOS 26+).
abstract class AlarmScheduler {
  /// Initialise the native scheduler (request permissions, etc.).
  Future<void> init();

  /// Schedule (or reschedule) a native alarm for the alarm's next occurrence.
  ///
  /// Returns a native ID string on iOS (the AlarmKit UUID to be stored in DB),
  /// or null on Android (integer ID is derived deterministically from the UUID).
  Future<String?> schedule(Alarm alarm);

  /// Cancel the native alarm with the given [alarmId] (UUID).
  ///
  /// Pass [nativeId] when available (iOS AlarmKit UUID stored in DB).
  Future<void> cancel(String alarmId, {String? nativeId});

  /// Cancel all scheduled native alarms.
  Future<void> cancelAll();

  /// Returns the platform-appropriate scheduler implementation.
  factory AlarmScheduler.create() =>
      Platform.isIOS ? IosAlarmScheduler() : AndroidAlarmScheduler();
}
