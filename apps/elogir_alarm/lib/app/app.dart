import 'dart:async';
import 'dart:io';

import 'package:alarm/alarm.dart' as native;
import 'package:alarm/utils/alarm_set.dart';
import 'package:elogir_alarm/features/alarms/providers/alarms_provider.dart';
import 'package:elogir_alarm/features/settings/providers/settings_provider.dart';
import 'package:elogir_alarm/routing/router.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Root application widget.
class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  StreamSubscription<AlarmSet>? _ringingSubscription;

  @override
  void initState() {
    super.initState();
    // Android: listen for native alarm ring events and push the ringing screen.
    if (Platform.isAndroid) {
      _ringingSubscription = native.Alarm.ringing.listen(_onAlarmRinging);
    }
  }

  @override
  void dispose() {
    _ringingSubscription?.cancel();
    super.dispose();
  }

  Future<void> _onAlarmRinging(AlarmSet alarmSet) async {
    if (alarmSet.alarms.isEmpty) return;
    final allAlarms = ref.read(alarmsProvider).value;
    if (allAlarms == null) return;
    final router = ref.read(routerProvider);
    for (final alarmSetting in alarmSet.alarms) {
      for (final alarm in allAlarms) {
        if (alarm.id.hashCode.abs().clamp(1, 0x7FFFFFFF) == alarmSetting.id) {
          await router.push<void>('/alarm-ringing/${alarm.id}');
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
