import 'dart:math' as math;

import 'package:elogir_calc/features/calculator/engine/calc_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalcEngine', () {
    group('basic arithmetic', () {
      test('addition', () {
        final result = CalcEngine.evaluate('2+3');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '5');
      });

      test('subtraction', () {
        final result = CalcEngine.evaluate('10-4');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '6');
      });

      test('multiplication', () {
        final result = CalcEngine.evaluate('6*7');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '42');
      });

      test('division', () {
        final result = CalcEngine.evaluate('15/4');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '3.75');
      });

      test('modulo', () {
        final result = CalcEngine.evaluate('10%3');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '1');
      });

      test('exponentiation', () {
        final result = CalcEngine.evaluate('2^10');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '1024');
      });

      test('decimal numbers', () {
        final result = CalcEngine.evaluate('1.5+2.3');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '3.8');
      });

      test('negative numbers', () {
        final result = CalcEngine.evaluate('-5+3');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '-2');
      });
    });

    group('operator precedence', () {
      test('multiplication before addition', () {
        final result = CalcEngine.evaluate('2+3*4');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '14');
      });

      test('parentheses override precedence', () {
        final result = CalcEngine.evaluate('(2+3)*4');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '20');
      });

      test('nested parentheses', () {
        final result = CalcEngine.evaluate('((2+3)*4)+1');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '21');
      });

      test('right-associative exponentiation', () {
        // 2^3^2 should be 2^(3^2) = 2^9 = 512
        final result = CalcEngine.evaluate('2^3^2');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '512');
      });
    });

    group('scientific functions (degrees)', () {
      test('sin(30) = 0.5', () {
        final result = CalcEngine.evaluate('sin(30)');
        expect(result, isA<CalcSuccess>());
        expect(
          (result as CalcSuccess).value,
          closeTo(0.5, 1e-10),
        );
      });

      test('cos(60) = 0.5', () {
        final result = CalcEngine.evaluate('cos(60)');
        expect(result, isA<CalcSuccess>());
        expect(
          (result as CalcSuccess).value,
          closeTo(0.5, 1e-10),
        );
      });

      test('tan(45) = 1', () {
        final result = CalcEngine.evaluate('tan(45)');
        expect(result, isA<CalcSuccess>());
        expect(
          (result as CalcSuccess).value,
          closeTo(1, 1e-10),
        );
      });

      test('sin(0) = 0', () {
        final result = CalcEngine.evaluate('sin(0)');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).value, 0);
      });

      test('cos(0) = 1', () {
        final result = CalcEngine.evaluate('cos(0)');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).value, 1);
      });
    });

    group('scientific functions (radians)', () {
      test('sin(pi/2) = 1', () {
        final result = CalcEngine.evaluate(
          'sin(pi/2)',
          useDegrees: false,
        );
        expect(result, isA<CalcSuccess>());
        expect(
          (result as CalcSuccess).value,
          closeTo(1, 1e-10),
        );
      });
    });

    group('log and ln', () {
      test('log(100) = 2', () {
        final result = CalcEngine.evaluate('log(100)');
        expect(result, isA<CalcSuccess>());
        expect(
          (result as CalcSuccess).value,
          closeTo(2, 1e-10),
        );
      });

      test('ln(e) = 1', () {
        final result = CalcEngine.evaluate('ln(e)');
        expect(result, isA<CalcSuccess>());
        expect(
          (result as CalcSuccess).value,
          closeTo(1, 1e-10),
        );
      });

      test('log of negative errors', () {
        final result = CalcEngine.evaluate('log(-1)');
        expect(result, isA<CalcError>());
      });
    });

    group('sqrt', () {
      test('sqrt(16) = 4', () {
        final result = CalcEngine.evaluate('sqrt(16)');
        expect(result, isA<CalcSuccess>());
        expect((result as CalcSuccess).formatted, '4');
      });

      test('sqrt of negative errors', () {
        final result = CalcEngine.evaluate('sqrt(-1)');
        expect(result, isA<CalcError>());
      });
    });

    group('constants', () {
      test('pi value', () {
        final result = CalcEngine.evaluate('pi');
        expect(result, isA<CalcSuccess>());
        expect(
          (result as CalcSuccess).value,
          closeTo(math.pi, 1e-10),
        );
      });

      test('e value', () {
        final result = CalcEngine.evaluate('e');
        expect(result, isA<CalcSuccess>());
        expect(
          (result as CalcSuccess).value,
          closeTo(math.e, 1e-10),
        );
      });

      test('implicit multiplication with pi', () {
        final result = CalcEngine.evaluate('2pi');
        expect(result, isA<CalcSuccess>());
        expect(
          (result as CalcSuccess).value,
          closeTo(2 * math.pi, 1e-10),
        );
      });
    });

    group('edge cases', () {
      test('division by zero', () {
        final result = CalcEngine.evaluate('1/0');
        expect(result, isA<CalcError>());
        expect(
          (result as CalcError).message,
          'Division by zero',
        );
      });

      test('empty expression', () {
        final result = CalcEngine.evaluate('');
        expect(result, isA<CalcError>());
      });

      test('whitespace only', () {
        final result = CalcEngine.evaluate('   ');
        expect(result, isA<CalcError>());
      });

      test('tan(90) is undefined', () {
        final result = CalcEngine.evaluate('tan(90)');
        expect(result, isA<CalcError>());
      });

      test('mismatched parentheses', () {
        final result = CalcEngine.evaluate('(2+3');
        expect(result, isA<CalcError>());
      });
    });

    group('formatResult', () {
      test('integer result', () {
        expect(CalcEngine.formatResult(42), '42');
      });

      test('decimal result strips trailing zeros', () {
        expect(CalcEngine.formatResult(3.5), '3.5');
      });

      test('negative zero becomes zero', () {
        expect(CalcEngine.formatResult(-0.0), '0');
      });
    });
  });
}
