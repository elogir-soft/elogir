import 'package:elogir_alarm/features/alarms/widgets/alarm_card.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/alarm_fixtures.dart';
import '../../../helpers/pump_app.dart';

void main() {
  group('AlarmCard', () {
    testWidgets('displays alarm time', (tester) async {
      final alarm = createAlarm(hour: 7, minute: 30);
      await tester.pumpApp(
        AlarmCard(
          alarm: alarm,
          onToggle: (_) {},
          onTap: () {},
          onDelete: () {},
        ),
      );

      expect(find.text('07:30'), findsOneWidget);
    });

    testWidgets('displays alarm label', (tester) async {
      final alarm = createAlarm(label: 'Morning');
      await tester.pumpApp(
        AlarmCard(
          alarm: alarm,
          onToggle: (_) {},
          onTap: () {},
          onDelete: () {},
        ),
      );

      expect(find.text('Morning'), findsOneWidget);
    });

    testWidgets('hides label when empty', (tester) async {
      final alarm = createAlarm(label: '');
      await tester.pumpApp(
        AlarmCard(
          alarm: alarm,
          onToggle: (_) {},
          onTap: () {},
          onDelete: () {},
        ),
      );

      // Only the time and countdown should be visible.
      expect(find.text('08:00'), findsOneWidget);
    });
  });
}
