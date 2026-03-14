import 'dart:convert';

import 'package:elogir_alarm/features/timers/models/app_timer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/timer_fixtures.dart';

void main() {
  group('AppTimer', () {
    test('creates with default values', () {
      final timer = createAppTimer();
      expect(timer.id, 'test-timer-1');
      expect(timer.label, 'Cooking');
      expect(timer.durationMs, 300000);
      expect(timer.remainingMs, 300000);
      expect(timer.status, TimerStatus.running);
    });

    test('progress is 0.0 when just started', () {
      final timer = createAppTimer(durationMs: 1000, remainingMs: 1000);
      expect(timer.progress, 0.0);
    });

    test('progress is 0.5 at halfway', () {
      final timer = createAppTimer(durationMs: 1000, remainingMs: 500);
      expect(timer.progress, 0.5);
    });

    test('progress is 1.0 when completed', () {
      final timer = createAppTimer(durationMs: 1000, remainingMs: 0);
      expect(timer.progress, 1.0);
    });

    test('remaining returns Duration', () {
      final timer = createAppTimer(remainingMs: 5000);
      expect(timer.remaining, const Duration(milliseconds: 5000));
    });

    test('duration returns Duration', () {
      final timer = createAppTimer(durationMs: 300000);
      expect(timer.duration, const Duration(milliseconds: 300000));
    });

    test('copyWith creates new instance', () {
      final timer = createAppTimer();
      final copy = timer.copyWith(status: TimerStatus.paused);
      expect(copy.status, TimerStatus.paused);
      expect(timer.status, TimerStatus.running);
    });

    test('equality by value', () {
      final a = createAppTimer();
      final b = createAppTimer();
      expect(a, equals(b));
    });

    group('JSON serialization', () {
      test('round-trips correctly', () {
        final timer = createAppTimer();
        final json = timer.toJson();
        final decoded = AppTimer.fromJson(json);
        expect(decoded, equals(timer));
      });

      test('serializes status enum', () {
        final timer = createAppTimer(status: TimerStatus.paused);
        final json = jsonEncode(timer.toJson());
        expect(json, contains('"paused"'));
      });
    });

    group('TimerStatus', () {
      test('isActive for running', () {
        expect(TimerStatus.running.isActive, isTrue);
      });

      test('isActive for paused', () {
        expect(TimerStatus.paused.isActive, isTrue);
      });

      test('not isActive for completed', () {
        expect(TimerStatus.completed.isActive, isFalse);
      });

      test('not isActive for cancelled', () {
        expect(TimerStatus.cancelled.isActive, isFalse);
      });
    });
  });
}
