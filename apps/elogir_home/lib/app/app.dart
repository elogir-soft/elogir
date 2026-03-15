import 'package:elogir_home/features/automation/providers/automation_scheduler_provider.dart';
import 'package:elogir_home/features/settings/providers/settings_provider.dart';
import 'package:elogir_home/routing/router.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Root application widget.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Start the automation scheduler as soon as the app builds.
    ref.watch(automationSchedulerProvider);

    final router = ref.watch(routerProvider);
    final themeModeString = ref.watch(
      settingsProvider.select((s) => s.value?.themeMode ?? 'system'),
    );
    final themeMode = switch (themeModeString) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    return ElogirApp.router(
      theme: ElogirThemeData.light(),
      darkTheme: ElogirThemeData.dark(),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
