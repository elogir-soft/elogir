import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:elogir_alarm/config/constants.dart';
import 'package:elogir_alarm/database/app_database.dart';
import 'package:elogir_alarm/database/daos/settings_dao.dart';
import 'package:elogir_alarm/features/settings/models/app_settings.dart';

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
        defaultSnoozeMinutes: Value(settings.defaultSnoozeMinutes),
        keepScreenOnStopwatch: Value(settings.keepScreenOnStopwatch),
        timerSoundId: Value(settings.timerSoundId),
        themeMode: Value(settings.themeMode),
        use24HourFormat: Value(settings.use24HourFormat),
        weekStartsOnMonday: Value(settings.weekStartsOnMonday),
        timerPresets: Value(jsonEncode(settings.timerPresets)),
      ),
    );
  }

  AppSettings _toModel(SettingsTableData row) => AppSettings(
        defaultSnoozeMinutes: row.defaultSnoozeMinutes,
        keepScreenOnStopwatch: row.keepScreenOnStopwatch,
        timerSoundId: row.timerSoundId,
        themeMode: row.themeMode,
        use24HourFormat: row.use24HourFormat,
        weekStartsOnMonday: row.weekStartsOnMonday,
        timerPresets: _decodePresets(row.timerPresets),
      );

  List<int> _decodePresets(String json) {
    try {
      return (jsonDecode(json) as List<dynamic>).cast<int>();
    } catch (_) {
      return AppConstants.defaultTimerPresetSeconds;
    }
  }
}
