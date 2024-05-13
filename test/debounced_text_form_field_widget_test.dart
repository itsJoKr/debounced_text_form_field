import 'package:debounced_text_form_field/debounced_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Error is not shown immediately but after the debounce delay', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DebouncedTextFormField(
            validator: (value) => value!.length < 5 ? 'Too short' : null,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'Hi');
    await tester.pumpAndSettle();
    expect(find.text('Too short'), findsNothing);

    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Too short'), findsOne);
  });

  testWidgets('Error is hidden immediately after correct input', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DebouncedTextFormField(
            validator: (value) => value!.length < 5 ? 'Too short' : null,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'Hi');
    await tester.pumpAndSettle();
    expect(find.text('Too short'), findsNothing);

    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Too short'), findsOne);

    await tester.enterText(find.byType(TextFormField), 'Enough');
    await tester.pumpAndSettle();
    expect(find.text('Too short'), findsNothing);
  });
}
