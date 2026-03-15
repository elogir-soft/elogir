import 'package:elogir_calc/features/calculator/engine/evaluator.dart';
import 'package:elogir_calc/features/calculator/engine/tokenizer.dart';

/// Result of a calculation: success with a formatted value,
/// or an error with a message.
sealed class CalcResult {
  /// Creates a [CalcResult].
  const CalcResult();
}

/// A successful calculation result.
class CalcSuccess extends CalcResult {
  /// Creates a [CalcSuccess] with [value] and [formatted].
  const CalcSuccess(this.value, this.formatted);

  /// The numeric result.
  final double value;

  /// The formatted string for display.
  final String formatted;
}

/// An error during calculation.
class CalcError extends CalcResult {
  /// Creates a [CalcError] with a [message].
  const CalcError(this.message);

  /// The error message.
  final String message;
}

/// Pure calculator engine. Tokenizes and evaluates a string expression.
class CalcEngine {
  const CalcEngine._();

  /// Evaluate [expression] and return a [CalcResult].
  ///
  /// [useDegrees] controls trig function angle mode.
  static CalcResult evaluate(String expression, {bool useDegrees = true}) {
    if (expression.trim().isEmpty) {
      return const CalcError('Empty expression');
    }

    try {
      final tokens = Tokenizer.tokenize(expression);
      final value = Evaluator.evaluate(tokens, useDegrees: useDegrees);
      return CalcSuccess(value, formatResult(value));
    } on FormatException catch (e) {
      return CalcError(e.message);
    }
  }

  /// Format a double result for display.
  ///
  /// - Strips trailing zeros
  /// - Uses scientific notation for very large/small values
  /// - Up to 12 significant digits
  static String formatResult(double value) {
    if (value.isNaN) return 'NaN';
    if (value.isInfinite) {
      return value.isNegative ? '-\u221E' : '\u221E';
    }

    // Scientific notation for very large/small numbers
    if (value != 0 &&
        (value.abs() >= 1e12 ||
            value.abs() < 1e-6)) {
      return _formatScientific(value);
    }

    // Check if it's a whole number
    if (value == value.truncateToDouble() &&
        value.abs() < 1e15) {
      return value.toInt().toString();
    }

    // Format with up to 12 significant digits and strip trailing zeros
    var result = value.toStringAsPrecision(12);
    // Strip trailing zeros after decimal point
    if (result.contains('.')) {
      result = result.replaceAll(RegExp(r'0+$'), '');
      result = result.replaceAll(RegExp(r'\.$'), '');
    }
    return result;
  }

  static String _formatScientific(double value) {
    final s = value.toStringAsPrecision(10);
    // If it already has 'e', clean it up
    if (s.contains('e')) {
      final parts = s.split('e');
      var mantissa = parts[0];
      if (mantissa.contains('.')) {
        mantissa = mantissa.replaceAll(RegExp(r'0+$'), '');
        mantissa = mantissa.replaceAll(RegExp(r'\.$'), '');
      }
      var exponent = parts[1];
      // Remove leading '+' from exponent (e.g. e+12 -> e12)
      if (exponent.startsWith('+')) {
        exponent = exponent.substring(1);
      }
      // Remove redundant zeros in exponent (e.g. e05 -> e5)
      // but keep 0 if it's 0.
      try {
        if (exponent.startsWith('-')) {
          exponent = '-${int.parse(exponent.substring(1))}';
        } else {
          exponent = int.parse(exponent).toString();
        }
      } catch (_) {
        // Fallback to original
      }

      if (exponent == '0') return mantissa;
      return '${mantissa}e$exponent';
    }
    return s;
  }
}
