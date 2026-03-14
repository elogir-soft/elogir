import 'package:elogir_alarm/features/timers/screens/timers_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('TimersScreen', () {
    testWidgets('renders Quick Start section', (tester) async {
      await tester.pumpApp(const TimersScreen());
      await tester.pump();

      expect(find.text('Quick Start'), findsOneWidget);
    });

    testWidgets('renders Custom section', (tester) async {
      await tester.pumpApp(const TimersScreen());
      await tester.pump();

      expect(find.text('Custom'), findsOneWidget);
      expect(find.text('Start'), findsOneWidget);
    });

    testWidgets('renders preset buttons', (tester) async {
      await tester.pumpApp(const TimersScreen());
      await tester.pump();

      expect(find.text('1 min'), findsOneWidget);
      expect(find.text('5 min'), findsOneWidget);
      expect(find.text('1 hr'), findsOneWidget);
    });
  });
}
