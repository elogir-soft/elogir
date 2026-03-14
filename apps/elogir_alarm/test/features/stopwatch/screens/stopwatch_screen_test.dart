import 'package:elogir_alarm/features/stopwatch/screens/stopwatch_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('StopwatchScreen', () {
    testWidgets('shows initial zero time', (tester) async {
      await tester.pumpApp(const StopwatchScreen());
      await tester.pump();

      expect(find.text('00:00'), findsOneWidget);
      expect(find.text('.00'), findsOneWidget);
    });

    testWidgets('shows Start button initially', (tester) async {
      await tester.pumpApp(const StopwatchScreen());
      await tester.pump();

      expect(find.text('Start'), findsOneWidget);
    });

    testWidgets('does not show Reset or Lap initially', (tester) async {
      await tester.pumpApp(const StopwatchScreen());
      await tester.pump();

      expect(find.text('Reset'), findsNothing);
      expect(find.text('Lap'), findsNothing);
    });
  });
}
