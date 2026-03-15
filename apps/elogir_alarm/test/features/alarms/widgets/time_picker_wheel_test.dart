import 'package:elogir_alarm/features/alarms/widgets/time_picker_wheel.dart';
import 'package:elogir_ui/elogir_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  group('TimePickerWheel', () {
    testWidgets('renders with initial hour and minute', (tester) async {
      await tester.pumpApp(
        TimePickerWheel(
          hour: 14,
          minute: 30,
          use24HourFormat: true,
          onTimeChanged: (_, __) {},
        ),
      );

      // The colon separator should be visible.
      expect(find.text(':'), findsOneWidget);
    });

    testWidgets('renders without errors', (tester) async {
      await tester.pumpApp(
        TimePickerWheel(
          hour: 0,
          minute: 0,
          use24HourFormat: true,
          onTimeChanged: (_, __) {},
        ),
      );

      expect(find.byType(TimePickerWheel), findsOneWidget);
      // Uses the shared ElogirWheelPicker underneath.
      expect(find.byType(ElogirWheelPicker), findsOneWidget);
    });
  });
}
