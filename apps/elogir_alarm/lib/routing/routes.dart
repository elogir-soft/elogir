import 'package:elogir_alarm/features/alarms/screens/alarm_ringing_screen.dart';
import 'package:elogir_alarm/features/alarms/screens/alarms_screen.dart';
import 'package:elogir_alarm/features/settings/screens/settings_screen.dart';
import 'package:elogir_alarm/features/stopwatch/screens/stopwatch_screen.dart';
import 'package:elogir_alarm/features/timers/screens/timer_ringing_screen.dart';
import 'package:elogir_alarm/features/timers/screens/timers_screen.dart';
import 'package:elogir_alarm/layout/app_shell.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

/// Full-screen ringing alarm overlay. Lives outside the shell so it covers
/// the navigation chrome entirely.
@TypedGoRoute<AlarmRingingRoute>(path: '/alarm-ringing/:alarmId')
class AlarmRingingRoute extends GoRouteData with $AlarmRingingRoute {
  const AlarmRingingRoute({required this.alarmId});

  final String alarmId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AlarmRingingScreen(alarmId: alarmId);
  }
}

/// Full-screen timer completion overlay. Lives outside the shell.
@TypedGoRoute<TimerRingingRoute>(path: '/timer-ringing/:timerId')
class TimerRingingRoute extends GoRouteData with $TimerRingingRoute {
  const TimerRingingRoute({required this.timerId});

  final String timerId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TimerRingingScreen(timerId: timerId);
  }
}

@TypedShellRoute<AppShellRoute>(
  routes: [
    TypedGoRoute<AlarmsRoute>(path: '/alarms'),
    TypedGoRoute<TimersRoute>(path: '/timers'),
    TypedGoRoute<StopwatchRoute>(path: '/stopwatch'),
    TypedGoRoute<SettingsRoute>(path: '/settings'),
  ],
)
class AppShellRoute extends ShellRouteData {
  const AppShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    return AppShell(navigator: navigator);
  }
}

class AlarmsRoute extends GoRouteData with $AlarmsRoute {
  const AlarmsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AlarmsScreen();
  }
}

class TimersRoute extends GoRouteData with $TimersRoute {
  const TimersRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TimersScreen();
  }
}

class StopwatchRoute extends GoRouteData with $StopwatchRoute {
  const StopwatchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StopwatchScreen();
  }
}

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}
