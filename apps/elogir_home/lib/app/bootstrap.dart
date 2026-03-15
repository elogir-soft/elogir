import 'dart:async';

import 'package:elogir_auto/elogir_auto.dart';
import 'package:elogir_home/app/app.dart';
import 'package:elogir_home/database/app_database.dart';
import 'package:elogir_home/features/setup/services/credentials_service.dart';
import 'package:elogir_home/shared/providers/app_database_provider.dart';
import 'package:elogir_home/shared/providers/auto_database_provider.dart';
import 'package:elogir_home/shared/providers/elogir_auto_provider.dart';
import 'package:elogir_home/shared/providers/secure_storage_provider.dart';
import 'package:elogir_home/shared/providers/talker_provider.dart';
import 'package:elogir_updater/elogir_updater.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

/// Initializes async dependencies and runs the app.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = Talker();

  // Background update check — fire-and-forget to avoid slowing down startup.
  unawaited(_checkForUpdates(talker));

  final autoDb = AutoDatabase();
  final elogirAuto = ElogirAuto(database: autoDb);
  final appDb = AppDatabase();
  const secureStorage = FlutterSecureStorage();

  // Initialize cloud service from stored credentials if available.
  final credentialsService = CredentialsService(secureStorage);
  final credentials = await credentialsService.getTuyaCredentials();
  if (credentials != null) {
    try {
      final cloudService = elogirAuto.createTuyaCloudService(credentials);
      await cloudService.init();
      elogirAuto.setCloudService(cloudService);
    } on Object catch (e) {
      talker.error('Failed to initialize Tuya cloud service', e);
    }
  }

  runApp(
    ProviderScope(
      overrides: [
        talkerProvider.overrideWithValue(talker),
        autoDatabaseProvider.overrideWithValue(autoDb),
        elogirAutoProvider.overrideWithValue(elogirAuto),
        appDatabaseProvider.overrideWithValue(appDb),
        secureStorageProvider.overrideWithValue(secureStorage),
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
      appPrefix: 'elogir_home',
    );

    final release = await updater.checkForUpdate();
    if (release != null) {
      talker.info('New update available: ${release.version}');
    }
  } catch (e) {
    talker.error('Update check failed: $e');
  }
}
