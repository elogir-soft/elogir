import 'package:elogir_alarm/features/settings/repositories/settings_repository.dart';
import 'package:elogir_alarm/shared/providers/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repository_provider.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return SettingsRepository(db.settingsDao);
}
