import 'package:meta/meta.dart';

/// Token types for the calculator expression parser.
enum TokenType {
  /// Numeric literal.
  number,

  /// Arithmetic operator.
  operator,

  /// Mathematical function (sin, cos, etc.).
  function,

  /// Mathematical constant (pi, e).
  constant,

  /// Left parenthesis.
  leftParen,

  /// Right parenthesis.
  rightParen,
}

/// A single token from a calculator expression.
@immutable
class Token {
  /// Creates a token with a [type] and string [value].
  const Token(this.type, this.value);

  /// The type of this token.
  final TokenType type;

  /// The string value of this token.
  final String value;

  @override
  String toString() => 'Token($type, $value)';

  @override
  bool operator ==(Object other) =>
      other is Token &&
      other.type == type &&
      other.value == value;

  @override
  int get hashCode => Object.hash(type, value);
}

/// Tokenizes a calculator expression string into tokens.
///
/// Handles numbers, operators (+,-,*,/,^,%), functions
/// (sin, cos, tan, log, ln, sqrt), constants (pi, e),
/// parentheses, unary minus, and implicit multiplication.
class Tokenizer {
  const Tokenizer._();

  static const _functions = {
    'sin',
    'cos',
    'tan',
    'log',
    'ln',
    'sqrt',
  };
  static const _operators = {'+', '-', '*', '/', '^', '%'};

  /// Tokenize [input] into a list of [Token]s.
  ///
  /// Throws [FormatException] for unrecognized characters.
  static List<Token> tokenize(String input) {
    final tokens = <Token>[];
    final chars = input;
    var i = 0;

    while (i < chars.length) {
      final c = chars[i];

      if (c == ' ' || c == '\t' || c == '\r' || c == '\n') {
        i++;
        continue;
      }

      if (_isDigit(c) || _isLeadingDot(chars, i)) {
        i = _readNumber(chars, i, tokens);
        continue;
      }

      if (c == '\u221A') {
        _maybeInsertMultiply(tokens);
        tokens.add(
          const Token(TokenType.function, 'sqrt'),
        );
        i++;
        continue;
      }

      if (c == '\u03C0') {
        _maybeInsertMultiply(tokens);
        tokens.add(
          const Token(TokenType.constant, '\u03C0'),
        );
        i++;
        continue;
      }

      if (_isAlpha(c)) {
        i = _readWord(chars, i, tokens);
        continue;
      }

      if (c == '(') {
        _maybeInsertMultiply(tokens);
        tokens.add(
          const Token(TokenType.leftParen, '('),
        );
        i++;
        continue;
      }

      if (c == ')') {
        tokens.add(
          const Token(TokenType.rightParen, ')'),
        );
        i++;
        continue;
      }

      if (_operators.contains(c)) {
        i = _readOperator(chars, i, c, tokens);
        continue;
      }

      throw FormatException('Unexpected character: $c');
    }

    return tokens;
  }

  static bool _isLeadingDot(String chars, int i) =>
      chars[i] == '.' &&
      i + 1 < chars.length &&
      _isDigit(chars[i + 1]);

  static int _readNumber(
    String chars,
    int start,
    List<Token> tokens,
  ) {
    var i = start;
    while (i < chars.length &&
        (_isDigit(chars[i]) || chars[i] == '.')) {
      i++;
    }

    // Handle scientific notation: 1e6, 1.2e-5
    if (i < chars.length && (chars[i] == 'e' || chars[i] == 'E')) {
      // Look ahead to see if it's an exponent or the 'e' constant
      if (i + 1 < chars.length) {
        var j = i + 1;
        // Optional sign for exponent
        if (chars[j] == '+' || chars[j] == '-') {
          j++;
        }
        if (j < chars.length && _isDigit(chars[j])) {
          // It's an exponent
          i = j;
          while (i < chars.length && _isDigit(chars[i])) {
            i++;
          }
        }
      }
    }

    _maybeInsertMultiply(tokens);
    tokens.add(
      Token(TokenType.number, chars.substring(start, i)),
    );
    return i;
  }

  static int _readWord(
    String chars,
    int start,
    List<Token> tokens,
  ) {
    var i = start;
    while (i < chars.length && _isAlpha(chars[i])) {
      i++;
    }
    final word = chars.substring(start, i);

    if (_functions.contains(word)) {
      _maybeInsertMultiply(tokens);
      tokens.add(Token(TokenType.function, word));
    } else if (word == 'pi') {
      _maybeInsertMultiply(tokens);
      tokens.add(
        const Token(TokenType.constant, '\u03C0'),
      );
    } else if (word == 'e') {
      _maybeInsertMultiply(tokens);
      tokens.add(
        const Token(TokenType.constant, 'e'),
      );
    } else {
      throw FormatException('Unknown identifier: $word');
    }
    return i;
  }

  static int _readOperator(
    String chars,
    int i,
    String c,
    List<Token> tokens,
  ) {
    if (c == '-' && _isUnaryPosition(tokens)) {
      return _readUnaryMinus(chars, i, tokens);
    }
    tokens.add(Token(TokenType.operator, c));
    return i + 1;
  }

  static int _readUnaryMinus(
    String chars,
    int i,
    List<Token> tokens,
  ) {
    // Check if next char starts a number.
    if (i + 1 < chars.length &&
        (_isDigit(chars[i + 1]) || chars[i + 1] == '.')) {
      // Negative number literal.
      final numStart = i + 1;
      var j = numStart;
      while (j < chars.length &&
          (_isDigit(chars[j]) || chars[j] == '.')) {
        j++;
      }
      _maybeInsertMultiply(tokens);
      tokens.add(
        Token(
          TokenType.number,
          '-${chars.substring(numStart, j)}',
        ),
      );
      return j;
    }
    // Unary negation: insert -1 * ...
    _maybeInsertMultiply(tokens);
    tokens
      ..add(const Token(TokenType.number, '-1'))
      ..add(const Token(TokenType.operator, '*'));
    return i + 1;
  }

  /// Insert implicit multiplication when a value-like
  /// token precedes another value-like token.
  static void _maybeInsertMultiply(List<Token> tokens) {
    if (tokens.isEmpty) return;
    final last = tokens.last;
    if (last.type == TokenType.number ||
        last.type == TokenType.constant ||
        last.type == TokenType.rightParen) {
      tokens.add(
        const Token(TokenType.operator, '*'),
      );
    }
  }

  static bool _isUnaryPosition(List<Token> tokens) {
    if (tokens.isEmpty) return true;
    final last = tokens.last;
    return last.type == TokenType.operator ||
        last.type == TokenType.leftParen ||
        last.type == TokenType.function;
  }

  static bool _isDigit(String c) {
    final code = c.codeUnitAt(0);
    return code >= 48 && code <= 57;
  }

  static bool _isAlpha(String c) {
    final code = c.codeUnitAt(0);
    return (code >= 65 && code <= 90) ||
        (code >= 97 && code <= 122);
  }
}
