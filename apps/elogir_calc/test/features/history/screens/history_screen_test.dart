import 'dart:async';

import 'package:elogir_calc/features/history/models/calculation.dart';
import 'package:elogir_calc/features/history/providers/history_provider.dart';
import 'package:elogir_calc/features/history/screens/history_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('HistoryScreen', () {
    testWidgets('shows empty state when no history',
        (tester) async {
      await tester.pumpApp(
        const HistoryScreen(),
        overrides: [
          historyProvider.overrideWith(
            (ref) => Stream.value(<Calculation>[]),
          ),
        ],
      );
      await tester.pumpAndSettle();

      expect(
        find.text('No calculations yet'),
        findsOneWidget,
      );
    });

    testWidgets('shows history entries', (tester) async {
      final entries = [
        Calculation(
          id: 'test-1',
          expression: '2+3',
          result: '5',
          createdAt: DateTime(2026, 3, 15),
        ),
        Calculation(
          id: 'test-2',
          expression: '10*4',
          result: '40',
          createdAt: DateTime(2026, 3, 15, 10),
        ),
      ];

      await tester.pumpApp(
        const HistoryScreen(),
        overrides: [
          historyProvider.overrideWith(
            (ref) => Stream.value(entries),
          ),
        ],
      );
      await tester.pumpAndSettle();

      expect(find.text('2+3'), findsOneWidget);
      expect(find.text('= 5'), findsOneWidget);
      expect(find.text('10*4'), findsOneWidget);
      expect(find.text('= 40'), findsOneWidget);
    });

    testWidgets('shows clear button', (tester) async {
      await tester.pumpApp(
        const HistoryScreen(),
        overrides: [
          historyProvider.overrideWith(
            (ref) => Stream.value(<Calculation>[]),
          ),
        ],
      );
      await tester.pumpAndSettle();

      expect(find.text('Clear'), findsOneWidget);
    });
  });
}
