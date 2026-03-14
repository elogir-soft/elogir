import 'package:elogir_alarm/app/app.dart';
import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/shared/providers/database_provider.dart';
import 'package:elogir_alarm/shared/providers/talker_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

/// Initializes async dependencies and runs the app.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = Talker();
  final db = AppDatabase();

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
