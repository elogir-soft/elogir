import 'package:elogir_calc/features/calculator/engine/calc_engine.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalcEngine Extensive Tests (Python Reference)', () {
    void testExpr(String expression, dynamic expected, {bool useDegrees = true, double tolerance = 1e-10}) {
      test('"$expression"', () {
        final result = CalcEngine.evaluate(expression, useDegrees: useDegrees);
        if (expected is String && expected == "Error") {
          expect(result, isA<CalcError>());
        } else {
          expect(result, isA<CalcSuccess>());
          final success = result as CalcSuccess;
          if (expected is double) {
            expect(success.value, closeTo(expected, tolerance));
          } else if (expected is int) {
            expect(success.value, closeTo(expected.toDouble(), tolerance));
          }
        }
      });
    }

    group('Implicit Multiplication', () {
      testExpr('2pi', 6.283185307179586);
      testExpr('2(3+4)', 14.0);
      testExpr('(2+3)(4+5)', 45.0);
      testExpr('2sin(90)', 2.0);
      testExpr('sin(90)cos(0)', 1.0);
      testExpr('2sqrt(4)', 4.0);
      testExpr('pi e', 8.539734222673566);
    });

    group('Complex Precedence & Associativity', () {
      testExpr('2 + 3 * 4 ^ 2', 50.0);
      testExpr('(2 + 3) * 4 ^ 2', 80.0);
      testExpr('2 ^ 3 ^ 2', 512.0); // Right-associative
      testExpr('10 - 5 - 2', 3.0);  // Left-associative
      testExpr('24 / 4 / 2', 3.0);  // Left-associative
      testExpr('2 ^ (3 ^ 2)', 512.0);
      testExpr('(2 ^ 3) ^ 2', 64.0);
    });

    group('Trigonometry (Degrees)', () {
      testExpr('sin(0)', 0.0);
      testExpr('sin(90)', 1.0);
      testExpr('sin(180)', 0.0);
      testExpr('sin(270)', -1.0);
      testExpr('cos(0)', 1.0);
      testExpr('cos(90)', 0.0);
      testExpr('cos(180)', -1.0);
      testExpr('tan(0)', 0.0);
      testExpr('tan(45)', 1.0);
      testExpr('tan(90)', "Error"); // Undefined
    });

    group('Trigonometry (Radians)', () {
      const pi = 3.141592653589793;
      testExpr('sin(0)', 0.0, useDegrees: false);
      testExpr('sin(pi/2)', 1.0, useDegrees: false);
      testExpr('sin(pi)', 0.0, useDegrees: false);
      testExpr('cos(pi)', -1.0, useDegrees: false);
      testExpr('tan(pi/4)', 1.0, useDegrees: false);
    });

    group('Logarithms', () {
      testExpr('log(10)', 1.0);
      testExpr('log(100)', 2.0);
      testExpr('log(1)', 0.0);
      testExpr('log(0)', "Error");
      testExpr('log(-1)', "Error");
      testExpr('ln(e)', 1.0);
      testExpr('ln(1)', 0.0);
      testExpr('ln(e^2)', 2.0);
    });

    group('Unary Operators & Negation', () {
      // Note: Current implementation treats -2 as a number token.
      // So -2^2 is (-2)^2 = 4. 
      // If we want it to be -4, we'd need to change Tokenizer or Evaluator.
      // Python treats -2**2 as -(2**2) = -4.
      // Let's verify what the current implementation does.
      testExpr('-2^2', 4.0); // Current behavior: Token(-2) ^ Token(2)
      testExpr('-(2^2)', -4.0);
      testExpr('(-2)^2', 4.0);
      testExpr('-sin(90)', -1.0);
      testExpr('2 * -3', -6.0);
    });

    group('Large/Small Numbers & Precision', () {
      testExpr('1e6 * 1e6', 1e12);
      testExpr('1 / 1e6', 1e-6);
      testExpr('sqrt(2) * sqrt(2)', 2.0);
    });
    
    group('Modulo', () {
      testExpr('10 % 3', 1.0);
      testExpr('-10 % 3', 2.0); // Dart & Python behavior
      testExpr('10.5 % 3', 1.5);
    });
  });

  group('CalcEngine.formatResult Extensive Tests', () {
    test('standard numbers', () {
      expect(CalcEngine.formatResult(123), '123');
      expect(CalcEngine.formatResult(123.456), '123.456');
    });

    test('strips trailing zeros', () {
      expect(CalcEngine.formatResult(123.000), '123');
      expect(CalcEngine.formatResult(123.45000), '123.45');
    });

    test('scientific notation for large numbers', () {
      expect(CalcEngine.formatResult(1e12), '1e12');
      expect(CalcEngine.formatResult(1.23e15), '1.23e15');
    });

    test('scientific notation for small numbers', () {
      expect(CalcEngine.formatResult(1e-7), '1e-7');
      expect(CalcEngine.formatResult(0.000000123), '1.23e-7');
    });

    test('special values', () {
      expect(CalcEngine.formatResult(double.nan), 'NaN');
      expect(CalcEngine.formatResult(double.infinity), '∞');
      expect(CalcEngine.formatResult(double.negativeInfinity), '-∞');
    });
    
    test('high precision', () {
       // Should keep up to 12 significant digits
       expect(CalcEngine.formatResult(1.23456789012345), '1.23456789012');
    });
  });
}
