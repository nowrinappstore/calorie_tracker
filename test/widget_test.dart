import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calorie_tracker/main.dart';

void main() {
  testWidgets('Adding food updates total and remaining calories',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CalorieTrackerApp());

    expect(find.text('Calorie Tracker'), findsOneWidget);
    expect(find.text('No food added yet.\nTap "Add Food" to get started.'),
        findsOneWidget);

    await tester.tap(find.text('Add Food'));
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextFormField, 'Food Name'), 'Apple');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Calories (kcal)'), '95');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.text('Apple'), findsOneWidget);
    expect(find.text('95'), findsOneWidget);
    expect(find.text('1905'), findsOneWidget);
  });

  testWidgets('Add food dialog validates empty input',
      (WidgetTester tester) async {
    await tester.pumpWidget(const CalorieTrackerApp());

    await tester.tap(find.text('Add Food'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a food name'), findsOneWidget);
    expect(find.text('Please enter the calorie amount'), findsOneWidget);
  });
}