import 'dart:io';

import 'package:elogir_alarm/app/app.dart';
import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/features/alarms/providers/alarm_scheduler_provider.dart';
import 'package:elogir_alarm/features/alarms/services/alarm_scheduler.dart';
import 'package:elogir_alarm/shared/providers/database_provider.dart';
import 'package:elogir_alarm/shared/providers/talker_provider.dart';
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
  final scheduler = AlarmScheduler.create();
  await scheduler.init();

  // Android 13+ requires runtime notification permission for alarms to fire
  // when the app is closed.
  if (Platform.isAndroid) {
    await Permission.notification.request();
  }

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
