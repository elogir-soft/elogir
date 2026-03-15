import 'package:elogir_calc/features/calculator/screens/calculator_screen.dart';
import 'package:elogir_calc/features/calculator/widgets/calc_button.dart';
import 'package:elogir_calc/features/calculator/widgets/calc_display.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('CalculatorScreen', () {
    testWidgets('renders CalcDisplay and button grid', (tester) async {
      await tester.pumpApp(const CalculatorScreen());
      await tester.pumpAndSettle();

      expect(find.byType(CalcDisplay), findsOneWidget);
      expect(find.byType(CalcButton), findsAtLeast(20));
    });

    testWidgets('shows scientific mode buttons when SCI is toggled', (tester) async {
      await tester.pumpApp(const CalculatorScreen());
      await tester.pumpAndSettle();

      // Initial state: SCI panel not visible
      expect(find.text('sin'), findsNothing);

      // Tap Scientific toggle
      await tester.tap(find.text('Scientific'));
      await tester.pumpAndSettle();

      // SCI panel visible
      expect(find.text('sin'), findsOneWidget);
      expect(find.text('cos'), findsOneWidget);
    });

    testWidgets('pressing digit updates display via CalcDisplay', (tester) async {
      await tester.pumpApp(const CalculatorScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.text('7'));
      await tester.pumpAndSettle();

      // The display should show '7'
      // We search for '7' inside CalcDisplay. It might find 2 (expression and preview).
      expect(
        find.descendant(
          of: find.byType(CalcDisplay),
          matching: find.text('7'),
        ),
        findsAtLeast(1),
      );
    });
  });
}
