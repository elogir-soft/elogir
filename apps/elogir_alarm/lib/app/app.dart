import 'dart:async';

import 'package:alarm/alarm.dart' as native;
import 'package:alarm/utils/alarm_set.dart';
import 'package:elogir_alarm/features/alarms/providers/alarm_repository_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/alarms_provider.dart';
import 'package:elogir_alarm/features/settings/providers/settings_provider.dart';
import 'package:elogir_alarm/features/timers/providers/active_timers_provider.dart';
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
  StreamSubscription<int>? _snoozedSubscription;

  @override
  void initState() {
    super.initState();
    // Listen for native alarm/timer ring events and push the ringing screen.
    _ringingSubscription = native.Alarm.ringing.listen(_onAlarmRinging);
    // Listen for snooze actions from the notification to update the DB.
    _snoozedSubscription = native.Alarm.snoozed.listen(_onAlarmSnoozed);
  }

  @override
  void dispose() {
    _ringingSubscription?.cancel();
    _snoozedSubscription?.cancel();
    super.dispose();
  }

  Future<void> _onAlarmRinging(AlarmSet alarmSet) async {
    if (alarmSet.alarms.isEmpty) return;
    final router = ref.read(routerProvider);

    // Check alarms first.
    final allAlarms = ref.read(alarmsProvider).value;
    if (allAlarms != null) {
      for (final alarmSetting in alarmSet.alarms) {
        for (final alarm in allAlarms) {
          if (alarm.id.hashCode.abs().clamp(1, 0x7FFFFFFF) ==
              alarmSetting.id) {
            await router.push<void>('/alarm-ringing/${alarm.id}');
            return;
          }
        }
      }
    }

    // Check timers.
    final allTimers = ref.read(activeTimersProvider);
    for (final alarmSetting in alarmSet.alarms) {
      for (final timer in allTimers) {
        if (timer.id.hashCode.abs().clamp(1, 0x7FFFFFFF) ==
            alarmSetting.id) {
          await router.push<void>('/timer-ringing/${timer.id}');
          return;
        }
      }
    }
  }

  Future<void> _onAlarmSnoozed(int nativeId) async {
    final allAlarms = ref.read(alarmsProvider).value;
    if (allAlarms == null) return;

    for (final alarm in allAlarms) {
      if (alarm.id.hashCode.abs().clamp(1, 0x7FFFFFFF) == nativeId) {
        final snoozeTime = DateTime.now()
            .add(Duration(minutes: alarm.snoozeDurationMinutes));
        await ref
            .read(alarmRepositoryProvider)
            .updateSnoozedUntil(alarm.id, snoozeTime);
        return;
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
