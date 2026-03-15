import 'package:elogir_home/routing/routes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('Router configuration', () {
    test('has expected number of top-level routes', () {
      // 2 standalone routes (DeviceDetailRoute, AddDeviceRoute)
      // + 1 ShellRoute containing 2 child routes.
      expect($appRoutes, hasLength(3));
    });

    test('DeviceDetailRoute builds with deviceId', () {
      const route = DeviceDetailRoute(deviceId: 'abc-123');
      expect(route.deviceId, 'abc-123');
    });

    test('AddDeviceRoute is constructible', () {
      const route = AddDeviceRoute();
      expect(route, isNotNull);
    });

    test('DevicesRoute is constructible', () {
      const route = DevicesRoute();
      expect(route, isNotNull);
    });

    test('SettingsRoute is constructible', () {
      const route = SettingsRoute();
      expect(route, isNotNull);
    });

    test('GoRouter creates with expected initialLocation', () {
      final router = GoRouter(
        initialLocation: '/devices',
        routes: $appRoutes,
      );
      expect(router, isNotNull);
    });
  });
}
