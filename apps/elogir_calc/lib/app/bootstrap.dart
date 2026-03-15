import 'dart:async';

import 'package:elogir_calc/app/app.dart';
import 'package:elogir_calc/database/app_database.dart';
import 'package:elogir_calc/shared/providers/database_provider.dart';
import 'package:elogir_calc/shared/providers/talker_provider.dart';
import 'package:elogir_updater/elogir_updater.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

/// Initializes async dependencies and runs the app.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = Talker();
  final db = AppDatabase();

  // Background update check — fire-and-forget to avoid slowing down startup.
  unawaited(_checkForUpdates(talker));

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        talkerProvider.overrideWithValue(talker),
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
      owner: 'elogir',
      repo: 'elogir',
      appPrefix: 'elogir_calc',
    );

    final release = await updater.checkForUpdate();
    if (release != null) {
      talker.info('New update available: ${release.version}');
    }
  } catch (e) {
    talker.error('Update check failed: $e');
  }
}
