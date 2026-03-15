import 'package:drift/drift.dart';
import 'package:elogir_home/database/app_database.dart';
import 'package:elogir_home/database/tables/settings_table.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [SettingsTable])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.attachedDatabase);

  static const _settingsId = 1;

  /// Watch the single settings row. The row must exist before calling this.
  Stream<SettingsTableData> watchSettings() {
    return (select(settingsTable)
          ..where((t) => t.id.equals(_settingsId)))
        .watchSingle();
  }

  /// Insert or update the settings row.
  Future<void> upsertSettings(SettingsTableCompanion settings) {
    return into(settingsTable).insertOnConflictUpdate(settings);
  }

  /// Returns the settings row, creating it with defaults if it doesn't exist.
  Future<SettingsTableData> getOrCreate() async {
    final existing = await (select(settingsTable)
          ..where((t) => t.id.equals(_settingsId)))
        .getSingleOrNull();
    if (existing != null) return existing;

    await into(settingsTable)
        .insert(SettingsTableCompanion(id: const Value(_settingsId)));
    return (select(settingsTable)
          ..where((t) => t.id.equals(_settingsId)))
        .getSingle();
  }
}
