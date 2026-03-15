// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $deviceDetailRoute,
  $addDeviceRoute,
  $addAutomationRoute,
  $settingsRoute,
  $appShellRoute,
];

RouteBase get $deviceDetailRoute => GoRouteData.$route(
  path: '/devices/:deviceId',
  factory: $DeviceDetailRoute._fromState,
);

mixin $DeviceDetailRoute on GoRouteData {
  static DeviceDetailRoute _fromState(GoRouterState state) =>
      DeviceDetailRoute(deviceId: state.pathParameters['deviceId']!);

  DeviceDetailRoute get _self => this as DeviceDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/devices/${Uri.encodeComponent(_self.deviceId)}');

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

RouteBase get $addDeviceRoute => GoRouteData.$route(
  path: '/add-device',
  factory: $AddDeviceRoute._fromState,
);

mixin $AddDeviceRoute on GoRouteData {
  static AddDeviceRoute _fromState(GoRouterState state) =>
      const AddDeviceRoute();

  @override
  String get location => GoRouteData.$location('/add-device');

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

RouteBase get $addAutomationRoute => GoRouteData.$route(
  path: '/add-automation',
  factory: $AddAutomationRoute._fromState,
);

mixin $AddAutomationRoute on GoRouteData {
  static AddAutomationRoute _fromState(GoRouterState state) =>
      const AddAutomationRoute();

  @override
  String get location => GoRouteData.$location('/add-automation');

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

RouteBase get $appShellRoute => ShellRouteData.$route(
  factory: $AppShellRouteExtension._fromState,
  routes: [
    GoRouteData.$route(path: '/devices', factory: $DevicesRoute._fromState),
    GoRouteData.$route(
      path: '/automation',
      factory: $AutomationRoute._fromState,
    ),
  ],
);

extension $AppShellRouteExtension on AppShellRoute {
  static AppShellRoute _fromState(GoRouterState state) => const AppShellRoute();
}

mixin $DevicesRoute on GoRouteData {
  static DevicesRoute _fromState(GoRouterState state) => const DevicesRoute();

  @override
  String get location => GoRouteData.$location('/devices');

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

mixin $AutomationRoute on GoRouteData {
  static AutomationRoute _fromState(GoRouterState state) =>
      const AutomationRoute();

  @override
  String get location => GoRouteData.$location('/automation');

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
