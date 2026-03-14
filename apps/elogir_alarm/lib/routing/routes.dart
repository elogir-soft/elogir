import 'package:elogir_alarm/features/alarms/screens/alarm_edit_screen.dart';
import 'package:elogir_alarm/features/alarms/screens/alarms_screen.dart';
import 'package:elogir_alarm/features/stopwatch/screens/stopwatch_screen.dart';
import 'package:elogir_alarm/features/timers/screens/timers_screen.dart';
import 'package:elogir_alarm/layout/app_shell.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedShellRoute<AppShellRoute>(
  routes: [
    TypedGoRoute<AlarmsRoute>(
      path: '/alarms',
      routes: [
        TypedGoRoute<AlarmNewRoute>(path: 'new'),
        TypedGoRoute<AlarmEditRoute>(path: ':alarmId/edit'),
      ],
    ),
    TypedGoRoute<TimersRoute>(path: '/timers'),
    TypedGoRoute<StopwatchRoute>(path: '/stopwatch'),
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

class AlarmNewRoute extends GoRouteData with $AlarmNewRoute {
  const AlarmNewRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AlarmEditScreen();
  }
}

class AlarmEditRoute extends GoRouteData with $AlarmEditRoute {
  const AlarmEditRoute({required this.alarmId});

  final String alarmId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AlarmEditScreen(alarmId: alarmId);
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
