import 'package:elogir_alarm/features/alarms/widgets/day_of_week_selector.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('DayOfWeekSelector', () {
    testWidgets('renders 7 day labels', (tester) async {
      await tester.pumpApp(
        DayOfWeekSelector(
          selectedDays: const [],
          onChanged: (_) {},
        ),
      );

      // M, T, W, T, F, S, S (some duplicate letters)
      expect(find.text('M'), findsOneWidget);
      expect(find.text('W'), findsOneWidget);
      expect(find.text('F'), findsOneWidget);
    });

    testWidgets('calls onChanged when day is tapped', (tester) async {
      List<int>? result;
      await tester.pumpApp(
        DayOfWeekSelector(
          selectedDays: const [],
          onChanged: (days) => result = days,
        ),
      );

      // Tap the first day (Monday = M)
      await tester.tap(find.text('M'));
      await tester.pumpAndSettle();

      expect(result, contains(0));
    });

    testWidgets('deselects when tapping selected day', (tester) async {
      List<int>? result;
      await tester.pumpApp(
        DayOfWeekSelector(
          selectedDays: const [0],
          onChanged: (days) => result = days,
        ),
      );

      await tester.tap(find.text('M'));
      await tester.pumpAndSettle();

      expect(result, isNot(contains(0)));
    });
  });
}
