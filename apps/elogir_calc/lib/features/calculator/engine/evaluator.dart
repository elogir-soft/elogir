import 'dart:math' as math;

import 'package:elogir_calc/features/calculator/engine/tokenizer.dart';

/// Shunting-yard evaluator for tokenized calculator expressions.
///
/// Supports:
/// - Basic arithmetic: +, -, *, /, %, ^
/// - Functions: sin, cos, tan, log, ln, sqrt
/// - Constants: π, e
/// - Trig in degrees (default) or radians
class Evaluator {
  const Evaluator._();

  /// Evaluate a list of tokens, returning the numeric result.
  ///
  /// [useDegrees] controls whether trig functions use degrees (true)
  /// or radians (false).
  ///
  /// Throws [FormatException] for malformed expressions.
  static double evaluate(List<Token> tokens, {bool useDegrees = true}) {
    if (tokens.isEmpty) {
      throw const FormatException('Empty expression');
    }

    // Shunting-yard: convert infix to postfix (RPN)
    final output = <Token>[];
    final operators = <Token>[];

    for (final token in tokens) {
      switch (token.type) {
        case TokenType.number:
        case TokenType.constant:
          output.add(token);

        case TokenType.function:
          operators.add(token);

        case TokenType.operator:
          while (operators.isNotEmpty &&
              operators.last.type != TokenType.leftParen &&
              _shouldPopOperator(operators.last, token)) {
            output.add(operators.removeLast());
          }
          operators.add(token);

        case TokenType.leftParen:
          operators.add(token);

        case TokenType.rightParen:
          while (operators.isNotEmpty &&
              operators.last.type != TokenType.leftParen) {
            output.add(operators.removeLast());
          }
          if (operators.isEmpty) {
            throw const FormatException('Mismatched parentheses');
          }
          operators.removeLast(); // remove the left paren
          // If there's a function on top, pop it to output
          if (operators.isNotEmpty &&
              operators.last.type == TokenType.function) {
            output.add(operators.removeLast());
          }
      }
    }

    while (operators.isNotEmpty) {
      final op = operators.removeLast();
      if (op.type == TokenType.leftParen) {
        throw const FormatException('Mismatched parentheses');
      }
      output.add(op);
    }

    // Evaluate RPN
    final stack = <double>[];

    for (final token in output) {
      switch (token.type) {
        case TokenType.number:
          stack.add(double.parse(token.value));

        case TokenType.constant:
          stack.add(_constantValue(token.value));

        case TokenType.operator:
          if (stack.length < 2) {
            throw const FormatException('Invalid expression');
          }
          final b = stack.removeLast();
          final a = stack.removeLast();
          stack.add(_applyOperator(token.value, a, b));

        case TokenType.function:
          if (stack.isEmpty) {
            throw const FormatException('Invalid expression');
          }
          final arg = stack.removeLast();
          stack.add(
            _applyFunction(
              token.value,
              arg,
              useDegrees: useDegrees,
            ),
          );

        case TokenType.leftParen:
        case TokenType.rightParen:
          throw const FormatException('Unexpected parenthesis in RPN');
      }
    }

    if (stack.length != 1) {
      throw const FormatException('Invalid expression');
    }

    return stack.first;
  }

  static bool _shouldPopOperator(Token stackTop, Token current) {
    if (stackTop.type == TokenType.function) return true;
    if (stackTop.type != TokenType.operator) return false;

    final stackPrec = _precedence(stackTop.value);
    final currentPrec = _precedence(current.value);

    // Right-associative: ^ does NOT pop same-precedence ^
    if (current.value == '^') {
      return stackPrec > currentPrec;
    }
    return stackPrec >= currentPrec;
  }

  static int _precedence(String op) {
    return switch (op) {
      '+' || '-' => 1,
      '*' || '/' || '%' => 2,
      '^' => 3,
      _ => 0,
    };
  }

  static double _constantValue(String name) {
    return switch (name) {
      '\u03C0' => math.pi,
      'e' => math.e,
      _ => throw FormatException('Unknown constant: $name'),
    };
  }

  static double _applyOperator(String op, double a, double b) {
    return switch (op) {
      '+' => a + b,
      '-' => a - b,
      '*' => a * b,
      '/' => b == 0
          ? throw const FormatException('Division by zero')
          : a / b,
      '%' => b == 0
          ? throw const FormatException('Division by zero')
          : a % b,
      '^' => math.pow(a, b).toDouble(),
      _ => throw FormatException('Unknown operator: $op'),
    };
  }

  static double _applyFunction(
    String name,
    double arg, {
    required bool useDegrees,
  }) {
    final radArg = useDegrees ? arg * math.pi / 180 : arg;

    return switch (name) {
      'sin' => _roundNearZero(math.sin(radArg)),
      'cos' => _roundNearZero(math.cos(radArg)),
      'tan' => _isTanUndefined(
            arg,
            useDegrees: useDegrees,
          )
              ? throw const FormatException(
                  'Undefined (tan at 90/270)',
                )
              : _roundNearZero(math.tan(radArg)),
      'log' => arg <= 0
          ? throw const FormatException(
              'Logarithm of non-positive number',
            )
          : math.log(arg) / math.ln10,
      'ln' => arg <= 0
          ? throw const FormatException(
              'Logarithm of non-positive number',
            )
          : math.log(arg),
      'sqrt' => arg < 0
          ? throw const FormatException(
              'Square root of negative number',
            )
          : math.sqrt(arg),
      _ => throw FormatException(
          'Unknown function: $name',
        ),
    };
  }

  /// Round values very close to zero (floating point artifacts).
  static double _roundNearZero(double value) {
    if (value.abs() < 1e-12) return 0;
    return value;
  }

  /// Check if tan is at an undefined point (90°, 270°, etc.).
  static bool _isTanUndefined(double arg, {required bool useDegrees}) {
    if (!useDegrees) {
      // Check if arg is an odd multiple of π/2
      final normalized = (arg / (math.pi / 2)).round();
      if ((normalized % 2).abs() == 1 &&
          (arg - normalized * math.pi / 2).abs() < 1e-10) {
        return true;
      }
      return false;
    }
    // In degrees, check for 90, 270, -90, etc.
    final mod = arg % 360;
    final normalized = mod < 0 ? mod + 360 : mod;
    return (normalized - 90).abs() < 1e-10 ||
        (normalized - 270).abs() < 1e-10;
  }
}
