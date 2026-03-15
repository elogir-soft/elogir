import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/database/daos/alarm_dao.dart';
import 'package:elogir_alarm/database/daos/settings_dao.dart';
import 'package:elogir_alarm/database/daos/timer_dao.dart';
import 'package:elogir_alarm/database/tables/alarm_table.dart';
import 'package:elogir_alarm/database/tables/settings_table.dart';
import 'package:elogir_alarm/database/tables/timer_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
part 'app_database.g.dart';

@DriftDatabase(
  tables: [AlarmTable, TimerTable, SettingsTable],
  daos: [AlarmDao, TimerDao, SettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor for testing with an in-memory database.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.createTable(settingsTable);
          }
          if (from < 3) {
            await migrator.addColumn(alarmTable, alarmTable.alarmkitId);
          }
          if (from < 4) {
            await migrator.addColumn(alarmTable, alarmTable.snoozedUntil);
          }
          if (from < 5) {
            await migrator.addColumn(
              settingsTable,
              settingsTable.timerSoundId,
            );
          }
          if (from < 6) {
            try {
              await migrator.addColumn(
                settingsTable,
                settingsTable.timerPresets,
              );
            } on Exception catch (_) {
              // Column may already exist from a prior build.
            }
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, AppConstants.databaseName));

    return NativeDatabase.createInBackground(file);
  });
}
