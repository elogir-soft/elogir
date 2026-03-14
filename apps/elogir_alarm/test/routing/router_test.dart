import 'package:elogir_alarm/routing/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Routes', () {
    test('AlarmsRoute path is /alarms', () {
      const route = AlarmsRoute();
      expect(route, isA<AlarmsRoute>());
    });

    test('TimersRoute creates', () {
      const route = TimersRoute();
      expect(route, isA<TimersRoute>());
    });

    test('StopwatchRoute creates', () {
      const route = StopwatchRoute();
      expect(route, isA<StopwatchRoute>());
    });

    test('\$appRoutes is not empty', () {
      expect($appRoutes, isNotEmpty);
    });
  });
}
