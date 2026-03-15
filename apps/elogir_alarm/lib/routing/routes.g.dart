// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $alarmRingingRoute,
  $timerRingingRoute,
  $settingsRoute,
  $editPresetsRoute,
  $appShellRoute,
];

RouteBase get $alarmRingingRoute => GoRouteData.$route(
  path: '/alarm-ringing/:alarmId',
  factory: $AlarmRingingRoute._fromState,
);

mixin $AlarmRingingRoute on GoRouteData {
  static AlarmRingingRoute _fromState(GoRouterState state) =>
      AlarmRingingRoute(alarmId: state.pathParameters['alarmId']!);

  AlarmRingingRoute get _self => this as AlarmRingingRoute;

  @override
  String get location => GoRouteData.$location(
    '/alarm-ringing/${Uri.encodeComponent(_self.alarmId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $timerRingingRoute => GoRouteData.$route(
  path: '/timer-ringing/:timerId',
  factory: $TimerRingingRoute._fromState,
);

mixin $TimerRingingRoute on GoRouteData {
  static TimerRingingRoute _fromState(GoRouterState state) =>
      TimerRingingRoute(timerId: state.pathParameters['timerId']!);

  TimerRingingRoute get _self => this as TimerRingingRoute;

  @override
  String get location => GoRouteData.$location(
    '/timer-ringing/${Uri.encodeComponent(_self.timerId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsRoute =>
    GoRouteData.$route(path: '/settings', factory: $SettingsRoute._fromState);

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $editPresetsRoute => GoRouteData.$route(
  path: '/edit-presets',
  factory: $EditPresetsRoute._fromState,
);

mixin $EditPresetsRoute on GoRouteData {
  static EditPresetsRoute _fromState(GoRouterState state) =>
      const EditPresetsRoute();

  @override
  String get location => GoRouteData.$location('/edit-presets');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $appShellRoute => ShellRouteData.$route(
  factory: $AppShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(path: '/alarms', factory: $AlarmsRoute._fromState),
    GoRouteData.$route(path: '/timers', factory: $TimersRoute._fromState),
    GoRouteData.$route(path: '/stopwatch', factory: $StopwatchRoute._fromState),
  ],
);

extension $AppShellRouteExtension on AppShellRoute {
  static AppShellRoute _fromState(GoRouterState state) => const AppShellRoute();
}

mixin $AlarmsRoute on GoRouteData {
  static AlarmsRoute _fromState(GoRouterState state) => const AlarmsRoute();

  @override
  String get location => GoRouteData.$location('/alarms');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TimersRoute on GoRouteData {
  static TimersRoute _fromState(GoRouterState state) => const TimersRoute();

  @override
  String get location => GoRouteData.$location('/timers');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $StopwatchRoute on GoRouteData {
  static StopwatchRoute _fromState(GoRouterState state) =>
      const StopwatchRoute();

  @override
  String get location => GoRouteData.$location('/stopwatch');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
