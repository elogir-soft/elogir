import 'dart:async';

import 'package:elogir_alarm/features/timers/models/app_timer.dart';
import 'package:elogir_alarm/features/timers/providers/timer_repository_provider.dart';
import 'package:elogir_alarm/features/timers/providers/timers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/timer_fixtures.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockTimerRepository mockRepo;

  setUp(() {
    mockRepo = MockTimerRepository();
  });

  group('persistedTimersProvider', () {
    test('returns stream of timers from repository', () async {
      final controller = StreamController<List<AppTimer>>.broadcast();

      when(() => mockRepo.watchAll())
          .thenAnswer((_) => controller.stream);

      final container = ProviderContainer(
        overrides: [
          timerRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );
      addTearDown(() {
        container.dispose();
        controller.close();
      });

      container.listen(persistedTimersProvider, (_, __) {});
      controller.add(sampleTimers());

      final timers = await container.read(persistedTimersProvider.future);

      expect(timers, hasLength(3));
      expect(timers.first.status, TimerStatus.running);
      verify(() => mockRepo.watchAll()).called(1);
    });
  });
}
