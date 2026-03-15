// ignore_for_file: depend_on_referenced_packages

import 'package:elogir_calc/features/calculator/providers/calculator_provider.dart';
import 'package:elogir_calc/features/history/models/calculation.dart';
import 'package:elogir_calc/features/history/providers/history_repository_provider.dart';
import 'package:elogir_calc/features/history/repositories/history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHistoryRepository extends Mock
    implements HistoryRepository {}

class _FakeCalculation extends Fake implements Calculation {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeCalculation());
  });

  group('CalculatorProvider', () {
    late ProviderContainer container;
    late MockHistoryRepository mockRepo;

    setUp(() {
      mockRepo = MockHistoryRepository();
      when(() => mockRepo.insert(any()))
          .thenAnswer((_) async {});
      container = ProviderContainer(
        overrides: [
          historyRepositoryProvider
              .overrideWithValue(mockRepo),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state has empty expression', () {
      final state =
          container.read(calculatorProvider);
      expect(state.expression, '');
      expect(state.display, '0');
    });

    test('inputDigit updates expression', () {
      container
          .read(calculatorProvider.notifier)
          .inputDigit('5');
      final state =
          container.read(calculatorProvider);
      expect(state.expression, '5');
      expect(state.display, '5');
    });

    test('multiple digits build expression', () {
      final notifier =
          container.read(calculatorProvider.notifier);
      notifier
        ..inputDigit('1')
        ..inputDigit('2')
        ..inputDigit('3');
      final state =
          container.read(calculatorProvider);
      expect(state.expression, '123');
    });

    test('inputDecimal adds decimal point', () {
      final notifier =
          container.read(calculatorProvider.notifier);
      notifier
        ..inputDigit('1')
        ..inputDecimal()
        ..inputDigit('5');
      final state =
          container.read(calculatorProvider);
      expect(state.expression, '1.5');
    });

    test('inputDecimal does not add duplicate', () {
      final notifier =
          container.read(calculatorProvider.notifier);
      notifier
        ..inputDigit('1')
        ..inputDecimal()
        ..inputDecimal()
        ..inputDigit('5');
      final state =
          container.read(calculatorProvider);
      expect(state.expression, '1.5');
    });

    test('inputOperator adds operator', () {
      final notifier =
          container.read(calculatorProvider.notifier);
      notifier
        ..inputDigit('5')
        ..inputOperator('+');
      final state =
          container.read(calculatorProvider);
      expect(state.expression, '5+');
    });

    test('evaluate produces result', () {
      final notifier =
          container.read(calculatorProvider.notifier);
      notifier
        ..inputDigit('2')
        ..inputOperator('+')
        ..inputDigit('3')
        ..evaluate();
      final state =
          container.read(calculatorProvider);
      expect(state.display, '5');
      expect(state.justEvaluated, true);
    });

    test('clear resets state', () {
      final notifier =
          container.read(calculatorProvider.notifier);
      notifier
        ..inputDigit('5')
        ..clear();
      final state =
          container.read(calculatorProvider);
      expect(state.expression, '');
      expect(state.display, '0');
    });

    test('backspace removes last character', () {
      final notifier =
          container.read(calculatorProvider.notifier);
      notifier
        ..inputDigit('1')
        ..inputDigit('2')
        ..inputDigit('3')
        ..backspace();
      final state =
          container.read(calculatorProvider);
      expect(state.expression, '12');
    });

    test('after evaluate, new digit starts fresh', () {
      final notifier =
          container.read(calculatorProvider.notifier);
      notifier
        ..inputDigit('2')
        ..inputOperator('+')
        ..inputDigit('3')
        ..evaluate()
        ..inputDigit('7');
      final state =
          container.read(calculatorProvider);
      expect(state.expression, '7');
      expect(state.justEvaluated, false);
    });

    test(
      'after evaluate, operator continues from result',
      () {
        final notifier =
            container.read(calculatorProvider.notifier);
        notifier
          ..inputDigit('2')
          ..inputOperator('+')
          ..inputDigit('3')
          ..evaluate()
          ..inputOperator('+')
          ..inputDigit('1');
        final state =
            container.read(calculatorProvider);
        expect(state.expression, '5+1');
      },
    );

    test('toggleScientific toggles mode', () {
      final notifier =
          container.read(calculatorProvider.notifier);
      expect(
        container.read(calculatorProvider).isScientific,
        false,
      );
      notifier.toggleScientific();
      expect(
        container.read(calculatorProvider).isScientific,
        true,
      );
    });

    test('toggleAngleMode toggles degrees/radians', () {
      final notifier =
          container.read(calculatorProvider.notifier);
      expect(
        container.read(calculatorProvider).isDegrees,
        true,
      );
      notifier.toggleAngleMode();
      expect(
        container.read(calculatorProvider).isDegrees,
        false,
      );
    });

    test('loadCalculation sets expression and display', () {
      container
          .read(calculatorProvider.notifier)
          .loadCalculation('42');
      final state =
          container.read(calculatorProvider);
      expect(state.expression, '42');
      expect(state.display, '42');
    });

    test('inputFunction adds function with paren', () {
      container
          .read(calculatorProvider.notifier)
          .inputFunction('sin');
      final state =
          container.read(calculatorProvider);
      expect(state.expression, 'sin(');
    });

    test('inputConstant adds constant', () {
      container
          .read(calculatorProvider.notifier)
          .inputConstant('\u03C0');
      final state =
          container.read(calculatorProvider);
      expect(state.expression, '\u03C0');
    });

    test('complex sequence: 2 + 3 * 4', () {
      final notifier = container.read(calculatorProvider.notifier);
      notifier.inputDigit('2');
      notifier.inputOperator('+');
      notifier.inputDigit('3');
      notifier.inputOperator('*');
      notifier.inputDigit('4');
      notifier.evaluate();
      final state = container.read(calculatorProvider);
      expect(state.display, '14');
    });

    test('complex sequence with parentheses: (2 + 3) * 4', () {
      final notifier = container.read(calculatorProvider.notifier);
      notifier.inputParenthesis(); // (
      notifier.inputDigit('2');
      notifier.inputOperator('+');
      notifier.inputDigit('3');
      notifier.inputParenthesis(); // )
      notifier.inputOperator('*');
      notifier.inputDigit('4');
      notifier.evaluate();
      final state = container.read(calculatorProvider);
      expect(state.display, '20');
    });

    test('scientific notation input: 1.2e3', () {
      // Note: Calculator UI might not have 'e' button yet, 
      // but let's see if we can input it via loadCalculation or if we add a way.
      // For now, let's test if we can evaluate it.
      container.read(calculatorProvider.notifier).loadCalculation('1.2e3');
      container.read(calculatorProvider.notifier).evaluate();
      final state = container.read(calculatorProvider);
      expect(state.display, '1200');
    });
  });
}
