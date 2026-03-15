import 'package:elogir_calc/features/settings/repositories/settings_repository.dart';
import 'package:elogir_calc/shared/providers/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repository_provider.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return SettingsRepository(db.settingsDao);
}
