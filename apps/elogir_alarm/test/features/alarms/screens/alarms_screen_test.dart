import 'package:elogir_alarm/features/alarms/providers/alarm_repository_provider.dart';
import 'package:elogir_alarm/features/alarms/screens/alarms_screen.dart';
import 'package:elogir_alarm/features/alarms/widgets/alarm_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/alarm_fixtures.dart';
import '../../../helpers/mocks.dart';
import '../../../helpers/pump_app.dart';

void main() {
  late MockAlarmRepository mockRepo;

  setUp(() {
    mockRepo = MockAlarmRepository();
  });

  group('AlarmsScreen', () {
    testWidgets('shows empty state when no alarms', (tester) async {
      when(() => mockRepo.watchAll())
          .thenAnswer((_) => Stream.value([]));

      await tester.pumpApp(
        const AlarmsScreen(),
        overrides: [
          alarmRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );
      await tester.pumpAndSettle();

      expect(find.text('No alarms set'), findsOneWidget);
      expect(find.text('Add Alarm'), findsOneWidget);
    });

    testWidgets('shows alarm cards', (tester) async {
      when(() => mockRepo.watchAll())
          .thenAnswer((_) => Stream.value(sampleAlarms()));

      await tester.pumpApp(
        const AlarmsScreen(),
        overrides: [
          alarmRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );
      await tester.pumpAndSettle();

      expect(find.byType(AlarmCard), findsNWidgets(3));
    });

    testWidgets('shows alarm time and labels', (tester) async {
      when(() => mockRepo.watchAll())
          .thenAnswer((_) => Stream.value(sampleAlarms()));

      await tester.pumpApp(
        const AlarmsScreen(),
        overrides: [
          alarmRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );
      await tester.pumpAndSettle();

      expect(find.text('08:00'), findsOneWidget);
      expect(find.text('Wake Up'), findsOneWidget);
    });
  });
}
