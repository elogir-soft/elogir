import 'package:flutter_test/flutter_test.dart';
import 'package:elogir_notes/main.dart';

void main() {
  testWidgets('Notes app renders landing screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ElogirNotesApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Notes'), findsOneWidget);
    expect(find.text('Welcome to Elogir Notes'), findsOneWidget);
  });
}
