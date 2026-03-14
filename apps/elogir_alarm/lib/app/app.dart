import 'package:elogir_alarm/routing/router.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Root application widget.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ElogirApp.router(
      theme: ElogirThemeData.light(),
      darkTheme: ElogirThemeData.dark(),
      routerConfig: router,
    );
  }
}
