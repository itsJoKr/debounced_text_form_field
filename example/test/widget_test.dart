import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('validates the email field after the debounce delay', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final field = find.byType(TextFormField);
    expect(field, findsOneWidget);

    await tester.enterText(field, 'invalid');
    await tester.pump();
    expect(find.text('Email is invalid'), findsNothing);

    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('Email is invalid'), findsOneWidget);
  });
}
