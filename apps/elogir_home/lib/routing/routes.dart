import 'package:elogir_home/features/devices/screens/device_detail_screen.dart';
import 'package:elogir_home/features/devices/screens/devices_screen.dart';
import 'package:elogir_home/features/settings/screens/settings_screen.dart';
import 'package:elogir_home/features/setup/screens/add_device_screen.dart';
import 'package:elogir_home/layout/app_shell.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

/// Full-screen device detail. Lives outside the shell so it covers
/// the navigation chrome entirely.
@TypedGoRoute<DeviceDetailRoute>(path: '/devices/:deviceId')
class DeviceDetailRoute extends GoRouteData with $DeviceDetailRoute {
  const DeviceDetailRoute({required this.deviceId});

  final String deviceId;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ElogirPage(key: state.pageKey, child: DeviceDetailScreen(deviceId: deviceId));
  }
}

/// Full-screen add device flow. Lives outside the shell.
@TypedGoRoute<AddDeviceRoute>(path: '/add-device')
class AddDeviceRoute extends GoRouteData with $AddDeviceRoute {
  const AddDeviceRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ElogirPage(key: state.pageKey, child: const AddDeviceScreen());
  }
}

/// Full-screen settings. Lives outside the shell so back navigation works.
@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ElogirPage(key: state.pageKey, child: const SettingsScreen());
  }
}

@TypedShellRoute<AppShellRoute>(
  routes: [
    TypedGoRoute<DevicesRoute>(path: '/devices'),
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

class DevicesRoute extends GoRouteData with $DevicesRoute {
  const DevicesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DevicesScreen();
  }
}
