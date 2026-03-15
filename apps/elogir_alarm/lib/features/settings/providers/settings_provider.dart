import 'package:elogir_alarm/features/settings/models/app_settings.dart';
import 'package:elogir_alarm/features/settings/providers/settings_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<AppSettings> settings(Ref ref) async* {
  final repo = ref.watch(settingsRepositoryProvider);
  // Ensure the settings row exists before watching.
  await repo.getOrCreate();
  yield* repo.watchSettings();
}
