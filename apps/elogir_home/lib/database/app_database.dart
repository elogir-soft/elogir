import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:elogir_home/config/constants.dart';
import 'package:elogir_home/database/daos/automation_dao.dart';
import 'package:elogir_home/database/daos/settings_dao.dart';
import 'package:elogir_home/database/tables/automation_table.dart';
import 'package:elogir_home/database/tables/settings_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [SettingsTable, AutomationTable],
  daos: [SettingsDao, AutomationDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor for testing with an in-memory database.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.createTable(automationTable);
          }
          if (from < 3) {
            await migrator.addColumn(
              settingsTable,
              settingsTable.use24HourFormat,
            );
          }
          if (from < 4) {
            await migrator.addColumn(
              settingsTable,
              settingsTable.weekStartsOnMonday,
            );
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
