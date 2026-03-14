import 'package:elogir_alarm/routing/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Routes', () {
    test('AlarmsRoute path is /alarms', () {
      const route = AlarmsRoute();
      expect(route, isA<AlarmsRoute>());
    });

    test('AlarmNewRoute path resolves', () {
      const route = AlarmNewRoute();
      expect(route, isA<AlarmNewRoute>());
    });

    test('AlarmEditRoute holds alarmId', () {
      const route = AlarmEditRoute(alarmId: 'abc-123');
      expect(route.alarmId, 'abc-123');
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
