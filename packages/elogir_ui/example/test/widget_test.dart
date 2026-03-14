import 'package:flutter_test/flutter_test.dart';

import 'package:elogir_ui_example/main.dart';

void main() {
  testWidgets('Example app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const ExampleApp());
    // Advance past stagger/fade-in timers without settling infinite animations
    // (spinners, progress bar shimmer).
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('elogir_ui Demo'), findsOneWidget);
  });
}
