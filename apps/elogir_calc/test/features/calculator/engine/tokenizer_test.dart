import 'package:elogir_calc/features/calculator/engine/tokenizer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tokenizer', () {
    test('simple number', () {
      final tokens = Tokenizer.tokenize('42');
      expect(tokens, [
        const Token(TokenType.number, '42'),
      ]);
    });

    test('decimal number', () {
      final tokens = Tokenizer.tokenize('3.14');
      expect(tokens, [
        const Token(TokenType.number, '3.14'),
      ]);
    });

    test('basic addition', () {
      final tokens = Tokenizer.tokenize('2+3');
      expect(tokens, [
        const Token(TokenType.number, '2'),
        const Token(TokenType.operator, '+'),
        const Token(TokenType.number, '3'),
      ]);
    });

    test('function with parentheses', () {
      final tokens = Tokenizer.tokenize('sin(45)');
      expect(tokens, [
        const Token(TokenType.function, 'sin'),
        const Token(TokenType.leftParen, '('),
        const Token(TokenType.number, '45'),
        const Token(TokenType.rightParen, ')'),
      ]);
    });

    test('pi constant', () {
      final tokens = Tokenizer.tokenize('pi');
      expect(tokens, [
        const Token(TokenType.constant, '\u03C0'),
      ]);
    });

    test('e constant', () {
      final tokens = Tokenizer.tokenize('e');
      expect(tokens, [
        const Token(TokenType.constant, 'e'),
      ]);
    });

    test('implicit multiplication: 2pi', () {
      final tokens = Tokenizer.tokenize('2pi');
      expect(tokens, [
        const Token(TokenType.number, '2'),
        const Token(TokenType.operator, '*'),
        const Token(TokenType.constant, '\u03C0'),
      ]);
    });

    test('implicit multiplication: number before paren', () {
      final tokens = Tokenizer.tokenize('3(4)');
      expect(tokens, [
        const Token(TokenType.number, '3'),
        const Token(TokenType.operator, '*'),
        const Token(TokenType.leftParen, '('),
        const Token(TokenType.number, '4'),
        const Token(TokenType.rightParen, ')'),
      ]);
    });

    test('unary minus at start', () {
      final tokens = Tokenizer.tokenize('-5');
      expect(tokens, [
        const Token(TokenType.number, '-5'),
      ]);
    });

    test('unary minus after operator', () {
      final tokens = Tokenizer.tokenize('3+-5');
      expect(tokens, [
        const Token(TokenType.number, '3'),
        const Token(TokenType.operator, '+'),
        const Token(TokenType.number, '-5'),
      ]);
    });

    test('unary minus before function', () {
      final tokens = Tokenizer.tokenize('-sin(30)');
      expect(tokens, [
        const Token(TokenType.number, '-1'),
        const Token(TokenType.operator, '*'),
        const Token(TokenType.function, 'sin'),
        const Token(TokenType.leftParen, '('),
        const Token(TokenType.number, '30'),
        const Token(TokenType.rightParen, ')'),
      ]);
    });

    test('strips whitespace', () {
      final tokens = Tokenizer.tokenize('2 + 3');
      expect(tokens, [
        const Token(TokenType.number, '2'),
        const Token(TokenType.operator, '+'),
        const Token(TokenType.number, '3'),
      ]);
    });

    test('unknown identifier throws', () {
      expect(
        () => Tokenizer.tokenize('foo'),
        throwsFormatException,
      );
    });

    test('unexpected character throws', () {
      expect(
        () => Tokenizer.tokenize('2&3'),
        throwsFormatException,
      );
    });

    test('sqrt function', () {
      final tokens = Tokenizer.tokenize('sqrt(16)');
      expect(tokens, [
        const Token(TokenType.function, 'sqrt'),
        const Token(TokenType.leftParen, '('),
        const Token(TokenType.number, '16'),
        const Token(TokenType.rightParen, ')'),
      ]);
    });

    test('square root symbol', () {
      final tokens = Tokenizer.tokenize('\u221A(16)');
      expect(tokens, [
        const Token(TokenType.function, 'sqrt'),
        const Token(TokenType.leftParen, '('),
        const Token(TokenType.number, '16'),
        const Token(TokenType.rightParen, ')'),
      ]);
    });

    test('pi symbol', () {
      final tokens = Tokenizer.tokenize('\u03C0');
      expect(tokens, [
        const Token(TokenType.constant, '\u03C0'),
      ]);
    });

    test('complex expression', () {
      final tokens = Tokenizer.tokenize('2*sin(30)+1');
      expect(tokens.length, 8);
      expect(tokens[0], const Token(TokenType.number, '2'));
      expect(
        tokens[1],
        const Token(TokenType.operator, '*'),
      );
      expect(
        tokens[2],
        const Token(TokenType.function, 'sin'),
      );
    });
  });
}
