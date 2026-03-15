import 'dart:async';

import 'package:alarm/alarm.dart' as native;
import 'package:elogir_alarm/app/app.dart';
import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/features/alarms/providers/alarm_scheduler_provider.dart';
import 'package:elogir_alarm/features/alarms/services/alarm_scheduler.dart';
import 'package:elogir_alarm/shared/providers/database_provider.dart';
import 'package:elogir_alarm/shared/providers/talker_provider.dart';
import 'package:elogir_updater/elogir_updater.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

/// Initializes async dependencies and runs the app.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = Talker();
  final db = AppDatabase();

  // Background update check — fire-and-forget to avoid slowing down startup.
  unawaited(_checkForUpdates(talker));

  // Init alarm package on both platforms — needed for timer notifications.
  await native.Alarm.init();

  final scheduler = AlarmScheduler.create();
  await scheduler.init();

  // Request notification permission for alarms/timers to ring when closed.
  await Permission.notification.request();

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        talkerProvider.overrideWithValue(talker),
        alarmSchedulerProvider.overrideWithValue(scheduler),
      ],
      observers: [TalkerRiverpodObserver(talker: talker)],
      child: const App(),
    ),
  );
}

/// Checks for updates in the background.
Future<void> _checkForUpdates(Talker talker) async {
  try {
    final updater = ElogirUpdater(
      owner: 'elogir-soft',
      repo: 'elogir',
      appPrefix: 'elogir_alarm',
    );

    final release = await updater.checkForUpdate();
    if (release != null) {
      talker.info('New update available: ${release.version}');
    }
  } catch (e) {
    talker.error('Update check failed: $e');
  }
}
