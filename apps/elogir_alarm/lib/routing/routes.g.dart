// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$appShellRoute];

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
