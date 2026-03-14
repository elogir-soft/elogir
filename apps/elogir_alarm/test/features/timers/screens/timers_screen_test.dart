import 'package:elogir_alarm/features/timers/screens/timers_screen.dart';
import 'package:elogir_alarm/features/timers/widgets/duration_input.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('TimersScreen', () {
    testWidgets('renders duration input and start button', (tester) async {
      await tester.pumpApp(const TimersScreen());
      await tester.pump();

      expect(find.byType(DurationInput), findsOneWidget);
      expect(find.text('Start'), findsOneWidget);
    });

    testWidgets('renders Quick Start section at bottom', (tester) async {
      await tester.pumpApp(const TimersScreen());
      await tester.pump();

      expect(find.text('Quick Start'), findsOneWidget);
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
