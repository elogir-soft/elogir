import 'package:drift/native.dart';
import 'package:elogir_home/database/app_database.dart';
import 'package:elogir_home/features/settings/models/app_settings.dart';
import 'package:elogir_home/features/settings/repositories/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late SettingsRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = SettingsRepository(db.settingsDao);
  });

  tearDown(() => db.close());

  group('SettingsRepository', () {
    test('getOrCreate returns defaults on first call', () async {
      final settings = await repository.getOrCreate();

      expect(settings.themeMode, 'system');
    });

    test('updateSettings persists changes', () async {
      await repository.getOrCreate();
      await repository.updateSettings(
        const AppSettings(themeMode: 'dark'),
      );

      final settings = await repository.getOrCreate();
      expect(settings.themeMode, 'dark');
    });

    test('watchSettings emits updates', () async {
      await repository.getOrCreate();
      final stream = repository.watchSettings();

      await repository.updateSettings(
        const AppSettings(themeMode: 'light'),
      );

      await expectLater(
        stream,
        emits(
          predicate<AppSettings>((s) => s.themeMode == 'light'),
        ),
      );
    });
  });
}
