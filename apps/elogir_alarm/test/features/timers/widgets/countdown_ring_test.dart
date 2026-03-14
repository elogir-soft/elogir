import 'package:elogir_alarm/features/timers/widgets/countdown_ring.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('CountdownRing', () {
    testWidgets('renders with zero progress', (tester) async {
      await tester.pumpApp(
        const CountdownRing(
          progress: 0,
          remaining: Duration(minutes: 5),
        ),
      );

      expect(find.text('05:00'), findsOneWidget);
    });

    testWidgets('renders with half progress', (tester) async {
      await tester.pumpApp(
        const CountdownRing(
          progress: 0.5,
          remaining: Duration(minutes: 2, seconds: 30),
        ),
      );

      expect(find.text('02:30'), findsOneWidget);
    });

    testWidgets('displays optional label', (tester) async {
      await tester.pumpApp(
        const CountdownRing(
          progress: 0.3,
          remaining: Duration(minutes: 3),
          label: 'Tea',
        ),
      );

      expect(find.text('Tea'), findsOneWidget);
    });

    testWidgets('renders at custom size', (tester) async {
      await tester.pumpApp(
        const CountdownRing(
          progress: 0,
          remaining: Duration(minutes: 1),
          size: 100,
        ),
      );

      expect(find.byType(CountdownRing), findsOneWidget);
    });
  });
}
