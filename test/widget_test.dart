// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:radio_form_field/main.dart';
import 'package:radio_form_field/radiogroup_form_field.dart';

void main() {
  testWidgets('RadioGroupFormField tests in a Form',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final submitButton = find.byKey(const ValueKey('submitButton'));
    const errorMessage = RadioGroupFormField.defaultSubmitErrorMessage;
    final textField = find.byType(TextFormField);
    final radio = find.byType(Radio<String>).first;

    //initial state:
    expect(find.text('cat'), findsOneWidget);
    expect(find.text(errorMessage), findsNothing);
    expect(find.byType(Radio<String>), findsNWidgets(3));

    // checking submit error:
    await tester.tap(submitButton);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text(errorMessage), findsOneWidget);

    // checking radioSubmit error after text entered in form
    // (still no any Radio item selected):
    await tester.enterText(textField, 'Fluffy');
    await tester.tap(submitButton);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text(errorMessage), findsOneWidget);

    // no error after radio tap:
    await tester.tap(radio);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text(errorMessage), findsNothing);
  });
}
