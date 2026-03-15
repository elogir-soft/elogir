import 'package:drift/drift.dart';
import 'package:elogir_home/database/app_database.dart';
import 'package:elogir_home/database/daos/settings_dao.dart';
import 'package:elogir_home/features/settings/models/app_settings.dart';

class SettingsRepository {
  const SettingsRepository(this._dao);

  final SettingsDao _dao;

  Stream<AppSettings> watchSettings() =>
      _dao.watchSettings().map(_toModel);

  Future<AppSettings> getOrCreate() async {
    final row = await _dao.getOrCreate();
    return _toModel(row);
  }

  Future<void> updateSettings(AppSettings settings) {
    return _dao.upsertSettings(
      SettingsTableCompanion(
        id: const Value(1),
        themeMode: Value(settings.themeMode),
        use24HourFormat: Value(settings.use24HourFormat),
      ),
    );
  }

  AppSettings _toModel(SettingsTableData row) => AppSettings(
        themeMode: row.themeMode,
        use24HourFormat: row.use24HourFormat,
      );
}
