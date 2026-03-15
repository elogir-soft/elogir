import 'package:elogir_calc/features/calculator/engine/calc_engine.dart';
import 'package:elogir_calc/features/calculator/models/calculator_state.dart';
import 'package:elogir_calc/features/history/models/calculation.dart';
import 'package:elogir_calc/features/history/providers/history_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'calculator_provider.g.dart';

const _uuid = Uuid();

@Riverpod(keepAlive: true)
class Calculator extends _$Calculator {
  @override
  CalculatorState build() => const CalculatorState();

  void inputDigit(String digit) {
    var expr = state.expression;
    if (state.justEvaluated) {
      // After pressing =, a new digit starts a fresh expression
      expr = '';
    }
    state = state.copyWith(
      expression: expr + digit,
      display: expr + digit,
      justEvaluated: false,
      hasError: false,
    );
    _updatePreview();
  }

  void inputDecimal() {
    var expr = state.expression;
    if (state.justEvaluated) {
      expr = '0';
    }
    // Don't add decimal if the current number already has one
    final lastNumberStart = _lastNumberStart(expr);
    final lastNumber = expr.substring(lastNumberStart);
    if (lastNumber.contains('.')) return;

    // If expression is empty or ends with an operator, add leading zero
    if (expr.isEmpty || _endsWithOperator(expr)) {
      expr += '0';
    }
    state = state.copyWith(
      expression: '$expr.',
      display: '$expr.',
      justEvaluated: false,
      hasError: false,
    );
    _updatePreview();
  }

  void inputOperator(String op) {
    var expr = state.expression;
    if (state.justEvaluated && state.preview.isNotEmpty) {
      // After =, continue from the result
      expr = state.preview;
    }
    if (expr.isEmpty && op != '-') return;

    // Replace trailing operator
    if (_endsWithOperator(expr) && op != '-') {
      expr = expr.substring(0, expr.length - 1);
    }

    state = state.copyWith(
      expression: expr + op,
      display: expr + op,
      justEvaluated: false,
      hasError: false,
    );
  }

  void inputFunction(String fn) {
    var expr = state.expression;
    if (state.justEvaluated) {
      expr = '';
    }
    state = state.copyWith(
      expression: '$expr$fn(',
      display: '$expr$fn(',
      justEvaluated: false,
      hasError: false,
    );
  }

  void inputConstant(String constant) {
    var expr = state.expression;
    if (state.justEvaluated) {
      expr = '';
    }
    state = state.copyWith(
      expression: expr + constant,
      display: expr + constant,
      justEvaluated: false,
      hasError: false,
    );
    _updatePreview();
  }

  void inputParenthesis() {
    var expr = state.expression;
    if (state.justEvaluated) {
      expr = '';
    }

    // Count open vs close parens to decide which to insert
    final openCount = expr.split('(').length - 1;
    final closeCount = expr.split(')').length - 1;

    String paren;
    if (openCount <= closeCount ||
        expr.isEmpty ||
        _endsWithOperator(expr) ||
        expr.endsWith('(')) {
      paren = '(';
    } else {
      paren = ')';
    }

    state = state.copyWith(
      expression: expr + paren,
      display: expr + paren,
      justEvaluated: false,
      hasError: false,
    );
    _updatePreview();
  }

  void evaluate() {
    final expr = state.expression;
    if (expr.isEmpty) return;

    final result = CalcEngine.evaluate(expr, useDegrees: state.isDegrees);
    switch (result) {
      case CalcSuccess(:final formatted):
        // Save to history
        final repo = ref.read(historyRepositoryProvider);
        repo.insert(
          Calculation(
            id: _uuid.v4(),
            expression: expr,
            result: formatted,
            createdAt: DateTime.now(),
          ),
        );
        state = state.copyWith(
          display: formatted,
          preview: formatted,
          justEvaluated: true,
          hasError: false,
        );
      case CalcError(:final message):
        state = state.copyWith(
          display: message,
          preview: '',
          hasError: true,
          justEvaluated: false,
        );
    }
  }

  void clear() {
    state = const CalculatorState().copyWith(
      isScientific: state.isScientific,
      isDegrees: state.isDegrees,
    );
  }

  void backspace() {
    if (state.justEvaluated || state.hasError) {
      clear();
      return;
    }
    final expr = state.expression;
    if (expr.isEmpty) return;

    // Check if we're deleting a function name + paren like "sin("
    final functions = ['sin(', 'cos(', 'tan(', 'log(', 'ln(', 'sqrt('];
    var newExpr = expr;
    var found = false;
    for (final fn in functions) {
      if (expr.endsWith(fn)) {
        newExpr = expr.substring(0, expr.length - fn.length);
        found = true;
        break;
      }
    }
    if (!found) {
      newExpr = expr.substring(0, expr.length - 1);
    }

    state = state.copyWith(
      expression: newExpr,
      display: newExpr.isEmpty ? '0' : newExpr,
      hasError: false,
    );
    _updatePreview();
  }

  void toggleScientific() {
    state = state.copyWith(isScientific: !state.isScientific);
  }

  void toggleAngleMode() {
    state = state.copyWith(isDegrees: !state.isDegrees);
    _updatePreview();
  }

  void loadCalculation(String expression) {
    state = state.copyWith(
      expression: expression,
      display: expression,
      preview: '',
      justEvaluated: false,
      hasError: false,
    );
    _updatePreview();
  }

  void _updatePreview() {
    final expr = state.expression;
    if (expr.isEmpty) {
      state = state.copyWith(preview: '');
      return;
    }

    final result = CalcEngine.evaluate(expr, useDegrees: state.isDegrees);
    switch (result) {
      case CalcSuccess(:final formatted):
        state = state.copyWith(preview: formatted);
      case CalcError():
        state = state.copyWith(preview: '');
    }
  }

  bool _endsWithOperator(String expr) {
    if (expr.isEmpty) return false;
    final last = expr[expr.length - 1];
    return '+-*/^%'.contains(last);
  }

  int _lastNumberStart(String expr) {
    for (var i = expr.length - 1; i >= 0; i--) {
      final c = expr[i];
      if (!'0123456789.'.contains(c)) return i + 1;
    }
    return 0;
  }
}
