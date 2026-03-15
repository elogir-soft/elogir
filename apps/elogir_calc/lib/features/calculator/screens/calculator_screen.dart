import 'package:elogir_calc/features/calculator/providers/calculator_provider.dart';
import 'package:elogir_calc/features/calculator/widgets/calc_button.dart';
import 'package:elogir_calc/features/calculator/widgets/calc_display.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Main calculator screen with display and button grid.
class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorProvider);
    final calc = ref.read(calculatorProvider.notifier);
    final theme = ElogirTheme.of(context);

    return ElogirScaffold(
      appBar: ElogirAppBar(
        title: const ElogirText(
          'Calculator',
          variant: ElogirTextVariant.titleLarge,
        ),
        trailing: ElogirPressable(
          onPressed: calc.toggleScientific,
          pressScale: 0.9,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.sm,
            ),
            child: Text(
              state.isScientific ? 'BASIC' : 'SCI',
              style: theme.typography.labelLarge.copyWith(
                color: theme.colors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm),
                child: CalcDisplay(
                  expression: state.expression,
                  display: state.display,
                  preview: state.preview,
                  hasError: state.hasError,
                  justEvaluated: state.justEvaluated,
                ),
              ),
            ),
            // Scientific rows
            ElogirAnimatedVisibility(
              visible: state.isScientific,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.xs),
                child: Column(
                  children: [
                    // Angle mode toggle
                    Row(
                      children: [
                        CalcButton(
                          label: state.isDegrees ? 'DEG' : 'RAD',
                          variant: CalcButtonVariant.scientific,
                          onPressed: calc.toggleAngleMode,
                        ),
                        CalcButton(
                          label: 'sin',
                          variant: CalcButtonVariant.scientific,
                          onPressed: () => calc.inputFunction('sin'),
                        ),
                        CalcButton(
                          label: 'cos',
                          variant: CalcButtonVariant.scientific,
                          onPressed: () => calc.inputFunction('cos'),
                        ),
                        CalcButton(
                          label: 'tan',
                          variant: CalcButtonVariant.scientific,
                          onPressed: () => calc.inputFunction('tan'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CalcButton(
                          label: '√',
                          variant: CalcButtonVariant.scientific,
                          onPressed: () => calc.inputFunction('sqrt'),
                        ),
                        CalcButton(
                          label: '^',
                          variant: CalcButtonVariant.scientific,
                          onPressed: () => calc.inputOperator('^'),
                        ),
                        CalcButton(
                          label: 'ln',
                          variant: CalcButtonVariant.scientific,
                          onPressed: () => calc.inputFunction('ln'),
                        ),
                        CalcButton(
                          label: 'log',
                          variant: CalcButtonVariant.scientific,
                          onPressed: () => calc.inputFunction('log'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CalcButton(
                          label: 'π',
                          variant: CalcButtonVariant.scientific,
                          onPressed: () => calc.inputConstant('π'),
                        ),
                        CalcButton(
                          label: 'e',
                          variant: CalcButtonVariant.scientific,
                          onPressed: () => calc.inputConstant('e'),
                        ),
                        CalcButton(
                          label: '(',
                          variant: CalcButtonVariant.scientific,
                          onPressed: calc.inputParenthesis,
                        ),
                        CalcButton(
                          label: ')',
                          variant: CalcButtonVariant.scientific,
                          onPressed: calc.inputParenthesis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Basic button grid
            Expanded(
              flex: state.isScientific ? 3 : 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.xs),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CalcButton(
                            label: 'AC',
                            variant: CalcButtonVariant.clear,
                            onPressed: calc.clear,
                          ),
                          CalcButton(
                            label: '( )',
                            variant: CalcButtonVariant.scientific,
                            onPressed: calc.inputParenthesis,
                          ),
                          CalcButton(
                            label: '%',
                            variant: CalcButtonVariant.operator,
                            onPressed: () => calc.inputOperator('%'),
                          ),
                          CalcButton(
                            label: '÷',
                            variant: CalcButtonVariant.operator,
                            onPressed: () => calc.inputOperator('/'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcButton(
                            label: '7',
                            onPressed: () => calc.inputDigit('7'),
                          ),
                          CalcButton(
                            label: '8',
                            onPressed: () => calc.inputDigit('8'),
                          ),
                          CalcButton(
                            label: '9',
                            onPressed: () => calc.inputDigit('9'),
                          ),
                          CalcButton(
                            label: '×',
                            variant: CalcButtonVariant.operator,
                            onPressed: () => calc.inputOperator('*'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcButton(
                            label: '4',
                            onPressed: () => calc.inputDigit('4'),
                          ),
                          CalcButton(
                            label: '5',
                            onPressed: () => calc.inputDigit('5'),
                          ),
                          CalcButton(
                            label: '6',
                            onPressed: () => calc.inputDigit('6'),
                          ),
                          CalcButton(
                            label: '−',
                            variant: CalcButtonVariant.operator,
                            onPressed: () => calc.inputOperator('-'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcButton(
                            label: '1',
                            onPressed: () => calc.inputDigit('1'),
                          ),
                          CalcButton(
                            label: '2',
                            onPressed: () => calc.inputDigit('2'),
                          ),
                          CalcButton(
                            label: '3',
                            onPressed: () => calc.inputDigit('3'),
                          ),
                          CalcButton(
                            label: '+',
                            variant: CalcButtonVariant.operator,
                            onPressed: () => calc.inputOperator('+'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          CalcButton(
                            label: '⌫',
                            variant: CalcButtonVariant.scientific,
                            onPressed: calc.backspace,
                          ),
                          CalcButton(
                            label: '0',
                            onPressed: () => calc.inputDigit('0'),
                          ),
                          CalcButton(
                            label: '.',
                            onPressed: calc.inputDecimal,
                          ),
                          CalcButton(
                            label: '=',
                            variant: CalcButtonVariant.equals,
                            onPressed: calc.evaluate,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
