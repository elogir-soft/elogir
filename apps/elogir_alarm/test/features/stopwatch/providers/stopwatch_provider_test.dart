import 'package:elogir_alarm/features/stopwatch/providers/stopwatch_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('StopwatchNotifier', () {
    test('initial state is zero and not running', () {
      final state = container.read(stopwatchProvider);
      expect(state.elapsed, Duration.zero);
      expect(state.isRunning, isFalse);
      expect(state.laps, isEmpty);
      expect(state.hasStarted, isFalse);
    });

    test('start sets isRunning to true', () {
      container.read(stopwatchProvider.notifier).start();
      final state = container.read(stopwatchProvider);
      expect(state.isRunning, isTrue);
    });

    test('stop sets isRunning to false', () {
      final notifier = container.read(stopwatchProvider.notifier);
      notifier.start();
      notifier.stop();
      final state = container.read(stopwatchProvider);
      expect(state.isRunning, isFalse);
    });

    test('reset returns to initial state', () {
      final notifier = container.read(stopwatchProvider.notifier);
      notifier.start();
      notifier.stop();
      notifier.reset();
      final state = container.read(stopwatchProvider);
      expect(state.elapsed, Duration.zero);
      expect(state.isRunning, isFalse);
      expect(state.laps, isEmpty);
    });

    test('lap records a lap while running', () async {
      final notifier = container.read(stopwatchProvider.notifier);
      notifier.start();

      // Wait a tiny bit for elapsed time to accumulate.
      await Future<void>.delayed(const Duration(milliseconds: 50));

      notifier.lap();
      final state = container.read(stopwatchProvider);
      expect(state.laps, hasLength(1));
      expect(state.laps.first.number, 1);
    });

    test('lap does nothing when not running', () {
      container.read(stopwatchProvider.notifier).lap();
      final state = container.read(stopwatchProvider);
      expect(state.laps, isEmpty);
    });

    test('multiple laps accumulate', () async {
      final notifier = container.read(stopwatchProvider.notifier);
      notifier.start();

      await Future<void>.delayed(const Duration(milliseconds: 30));
      notifier.lap();

      await Future<void>.delayed(const Duration(milliseconds: 30));
      notifier.lap();

      final state = container.read(stopwatchProvider);
      expect(state.laps, hasLength(2));
      // Most recent lap first.
      expect(state.laps.first.number, 2);
      expect(state.laps.last.number, 1);
    });

    test('hasStarted is true after start even when stopped', () {
      final notifier = container.read(stopwatchProvider.notifier);
      notifier.start();

      // Let timer tick once.
      Future<void>.delayed(const Duration(milliseconds: 20)).then((_) {
        notifier.stop();
        final state = container.read(stopwatchProvider);
        expect(state.hasStarted, isTrue);
      });
    });
  });
}
