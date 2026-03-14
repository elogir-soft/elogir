import 'dart:async';

import 'package:elogir_alarm/features/alarms/models/alarm.dart';
import 'package:elogir_alarm/features/alarms/providers/alarm_repository_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/alarms_provider.dart';
import 'package:elogir_alarm/features/alarms/providers/next_alarm_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/alarm_fixtures.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockAlarmRepository mockRepo;

  setUp(() {
    mockRepo = MockAlarmRepository();
  });

  group('alarmsProvider', () {
    test('returns stream of alarms from repository', () async {
      final controller = StreamController<List<Alarm>>.broadcast();

      when(() => mockRepo.watchAll())
          .thenAnswer((_) => controller.stream);

      final container = ProviderContainer(
        overrides: [
          alarmRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );
      addTearDown(() {
        container.dispose();
        controller.close();
      });

      // Subscribe to the provider to start listening.
      container.listen(alarmsProvider, (_, __) {});

      // Emit data.
      controller.add(sampleAlarms());

      // Wait for the stream to propagate.
      await container.read(alarmsProvider.future);
      final alarms = container.read(alarmsProvider).value;

      expect(alarms, hasLength(3));
      verify(() => mockRepo.watchAll()).called(1);
    });
  });

  group('nextAlarmProvider', () {
    test('returns null when no enabled alarms', () async {
      final controller = StreamController<List<Alarm>>.broadcast();

      when(() => mockRepo.watchAll())
          .thenAnswer((_) => controller.stream);

      final container = ProviderContainer(
        overrides: [
          alarmRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );
      addTearDown(() {
        container.dispose();
        controller.close();
      });

      container.listen(alarmsProvider, (_, __) {});
      controller.add([createAlarm(isEnabled: false)]);
      await container.read(alarmsProvider.future);

      final next = container.read(nextAlarmProvider);
      expect(next, isNull);
    });

    test('returns soonest enabled alarm', () async {
      final controller = StreamController<List<Alarm>>.broadcast();

      when(() => mockRepo.watchAll())
          .thenAnswer((_) => controller.stream);

      final container = ProviderContainer(
        overrides: [
          alarmRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );
      addTearDown(() {
        container.dispose();
        controller.close();
      });

      container.listen(alarmsProvider, (_, __) {});
      controller.add([
        createAlarm(id: 'later', hour: 23, minute: 0),
        createAlarm(id: 'sooner', hour: 6, minute: 0),
      ]);
      await container.read(alarmsProvider.future);

      final next = container.read(nextAlarmProvider);
      expect(next, isNotNull);
    });
  });
}
