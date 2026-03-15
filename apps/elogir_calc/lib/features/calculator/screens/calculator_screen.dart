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
      appBar: const ElogirAppBar(
        title: ElogirText(
          'Calculator',
          variant: ElogirTextVariant.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              flex: 3,
              child: CalcDisplay(
                expression: state.expression,
                display: state.display,
                preview: state.preview,
                hasError: state.hasError,
                justEvaluated: state.justEvaluated,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: theme.spacing.sm,
                horizontal: theme.spacing.md,
              ),
              child: _ModeToggle(
                isScientific: state.isScientific,
                onToggle: calc.toggleScientific,
              ),
            ),
            // Button area (scientific + basic in one flex region)
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.spacing.xs),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final scientificHeight = state.isScientific
                        ? constraints.maxHeight * 3 / 8
                        : 0.0;

                    return Column(
                      children: [
                        // Scientific rows — smooth height + opacity animation
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: scientificHeight,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: state.isScientific ? 1.0 : 0.0,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      CalcButton(
                                        label: state.isDegrees
                                            ? 'DEG'
                                            : 'RAD',
                                        variant: CalcButtonVariant.scientific,
                                        onPressed: calc.toggleAngleMode,
                                      ),
                                      CalcButton(
                                        label: 'sin',
                                        variant: CalcButtonVariant.scientific,
                                        onPressed: () =>
                                            calc.inputFunction('sin'),
                                      ),
                                      CalcButton(
                                        label: 'cos',
                                        variant: CalcButtonVariant.scientific,
                                        onPressed: () =>
                                            calc.inputFunction('cos'),
                                      ),
                                      CalcButton(
                                        label: 'tan',
                                        variant: CalcButtonVariant.scientific,
                                        onPressed: () =>
                                            calc.inputFunction('tan'),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      CalcButton(
                                        label: '√',
                                        variant: CalcButtonVariant.scientific,
                                        onPressed: () =>
                                            calc.inputFunction('sqrt'),
                                      ),
                                      CalcButton(
                                        label: '^',
                                        variant: CalcButtonVariant.scientific,
                                        onPressed: () =>
                                            calc.inputOperator('^'),
                                      ),
                                      CalcButton(
                                        label: 'ln',
                                        variant: CalcButtonVariant.scientific,
                                        onPressed: () =>
                                            calc.inputFunction('ln'),
                                      ),
                                      CalcButton(
                                        label: 'log',
                                        variant: CalcButtonVariant.scientific,
                                        onPressed: () =>
                                            calc.inputFunction('log'),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      CalcButton(
                                        label: 'π',
                                        variant: CalcButtonVariant.scientific,
                                        onPressed: () =>
                                            calc.inputConstant('π'),
                                      ),
                                      CalcButton(
                                        label: 'e',
                                        variant: CalcButtonVariant.scientific,
                                        onPressed: () =>
                                            calc.inputConstant('e'),
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Basic button grid
                        Expanded(
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
                                      onPressed: () =>
                                          calc.inputOperator('%'),
                                    ),
                                    CalcButton(
                                      label: '÷',
                                      variant: CalcButtonVariant.operator,
                                      onPressed: () =>
                                          calc.inputOperator('/'),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    CalcButton(
                                      label: '7',
                                      onPressed: () =>
                                          calc.inputDigit('7'),
                                    ),
                                    CalcButton(
                                      label: '8',
                                      onPressed: () =>
                                          calc.inputDigit('8'),
                                    ),
                                    CalcButton(
                                      label: '9',
                                      onPressed: () =>
                                          calc.inputDigit('9'),
                                    ),
                                    CalcButton(
                                      label: '×',
                                      variant: CalcButtonVariant.operator,
                                      onPressed: () =>
                                          calc.inputOperator('*'),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    CalcButton(
                                      label: '4',
                                      onPressed: () =>
                                          calc.inputDigit('4'),
                                    ),
                                    CalcButton(
                                      label: '5',
                                      onPressed: () =>
                                          calc.inputDigit('5'),
                                    ),
                                    CalcButton(
                                      label: '6',
                                      onPressed: () =>
                                          calc.inputDigit('6'),
                                    ),
                                    CalcButton(
                                      label: '−',
                                      variant: CalcButtonVariant.operator,
                                      onPressed: () =>
                                          calc.inputOperator('-'),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    CalcButton(
                                      label: '1',
                                      onPressed: () =>
                                          calc.inputDigit('1'),
                                    ),
                                    CalcButton(
                                      label: '2',
                                      onPressed: () =>
                                          calc.inputDigit('2'),
                                    ),
                                    CalcButton(
                                      label: '3',
                                      onPressed: () =>
                                          calc.inputDigit('3'),
                                    ),
                                    CalcButton(
                                      label: '+',
                                      variant: CalcButtonVariant.operator,
                                      onPressed: () =>
                                          calc.inputOperator('+'),
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
                                      onPressed: () =>
                                          calc.inputDigit('0'),
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
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeToggle extends StatelessWidget {
  const _ModeToggle({
    required this.isScientific,
    required this.onToggle,
  });

  final bool isScientific;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colors.surfaceContainer,
        borderRadius: theme.radii.full,
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleItem(
              label: 'Basic',
              isSelected: !isScientific,
              onPressed: isScientific ? onToggle : null,
            ),
          ),
          Expanded(
            child: _ToggleItem(
              label: 'Scientific',
              isSelected: isScientific,
              onPressed: !isScientific ? onToggle : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  const _ToggleItem({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return ElogirPressable(
      onPressed: onPressed,
      pressScale: 0.98,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? theme.colors.surface : null,
          borderRadius: theme.radii.full,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.colors.shadow.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: theme.typography.labelLarge.copyWith(
            color: isSelected
                ? theme.colors.onSurface
                : theme.colors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
