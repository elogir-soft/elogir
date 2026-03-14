import 'package:elogir_alarm/features/stopwatch/widgets/stopwatch_display.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('StopwatchDisplay', () {
    testWidgets('shows 00:00.00 at zero', (tester) async {
      await tester.pumpApp(
        const StopwatchDisplay(elapsed: Duration.zero),
      );

      expect(find.text('00:00'), findsOneWidget);
      expect(find.text('.00'), findsOneWidget);
    });

    testWidgets('shows correct time for 1:23.45', (tester) async {
      await tester.pumpApp(
        const StopwatchDisplay(
          elapsed: Duration(minutes: 1, seconds: 23, milliseconds: 450),
        ),
      );

      expect(find.text('01:23'), findsOneWidget);
      expect(find.text('.45'), findsOneWidget);
    });

    testWidgets('renders without errors when running', (tester) async {
      await tester.pumpApp(
        const StopwatchDisplay(
          elapsed: Duration(seconds: 5),
          isRunning: true,
        ),
      );

      expect(find.byType(StopwatchDisplay), findsOneWidget);
    });
  });
}
