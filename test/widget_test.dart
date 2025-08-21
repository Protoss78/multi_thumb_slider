// This is a basic Flutter widget test for the Multi-Thumb Slider.
//
// To perform an interaction with a widget, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:multi_thumb_slider/multi_thumb_slider.dart';

// Test enum for difficulty levels
enum Difficulty { easy, medium, hard, expert }

void main() {
  group('CustomMultiThumbSlider Tests', () {
    testWidgets('Int slider renders correctly', (WidgetTester tester) async {
      List<int> values = [20, 50, 80];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomMultiThumbSlider.withInt(
              values: values,
              onChanged: (newValues) {
                values = newValues;
              },
            ),
          ),
        ),
      );

      // Verify that the slider renders
      expect(
        find.byWidgetPredicate((widget) => widget.runtimeType.toString().startsWith('CustomMultiThumbSlider')),
        findsOneWidget,
      );

      // Verify that the slider has the correct number of values
      final slider = tester.widget<CustomMultiThumbSlider>(
        find.byWidgetPredicate((widget) => widget.runtimeType.toString().startsWith('CustomMultiThumbSlider')),
      );
      expect(slider.values.length, equals(3));
    });

    testWidgets('Double slider renders correctly', (WidgetTester tester) async {
      List<double> values = [20.5, 50.0, 80.7];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomMultiThumbSlider<double>(
              values: values,
              min: 0.0,
              max: 100.0,
              onChanged: (newValues) {
                values = newValues;
              },
            ),
          ),
        ),
      );

      // Verify that the slider renders
      expect(
        find.byWidgetPredicate((widget) => widget.runtimeType.toString().startsWith('CustomMultiThumbSlider')),
        findsOneWidget,
      );

      // Verify that the slider has the correct number of values
      final slider = tester.widget<CustomMultiThumbSlider>(
        find.byWidgetPredicate((widget) => widget.runtimeType.toString().startsWith('CustomMultiThumbSlider')),
      );
      expect(slider.values.length, equals(3));
    });

    testWidgets('Enum slider renders correctly', (WidgetTester tester) async {
      List<Difficulty> values = [Difficulty.easy, Difficulty.medium, Difficulty.hard];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomMultiThumbSlider<Difficulty>(
              values: values,
              min: Difficulty.easy,
              max: Difficulty.expert,
              onChanged: (newValues) {
                values = newValues;
              },
            ),
          ),
        ),
      );

      // Verify that the slider renders
      expect(
        find.byWidgetPredicate((widget) => widget.runtimeType.toString().startsWith('CustomMultiThumbSlider')),
        findsOneWidget,
      );

      // Verify that the slider has the correct number of values
      final slider = tester.widget<CustomMultiThumbSlider>(
        find.byWidgetPredicate((widget) => widget.runtimeType.toString().startsWith('CustomMultiThumbSlider')),
      );
      expect(slider.values.length, equals(3));
    });

    testWidgets('Read-only slider renders correctly', (WidgetTester tester) async {
      List<int> values = [25, 50, 75];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomMultiThumbSlider.withInt(
              values: values,
              readOnly: true,
              onChanged: (newValues) {
                values = newValues;
              },
            ),
          ),
        ),
      );

      // Verify that the slider renders
      expect(
        find.byWidgetPredicate((widget) => widget.runtimeType.toString().startsWith('CustomMultiThumbSlider')),
        findsOneWidget,
      );

      // Verify that the slider has the correct number of values
      final slider = tester.widget<CustomMultiThumbSlider>(
        find.byWidgetPredicate((widget) => widget.runtimeType.toString().startsWith('CustomMultiThumbSlider')),
      );
      expect(slider.values.length, equals(3));
    });

    testWidgets('Custom styling renders correctly', (WidgetTester tester) async {
      List<int> values = [30, 60, 90];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomMultiThumbSlider.withInt(
              values: values,
              trackColor: Colors.red,
              rangeColors: [Colors.blue, Colors.green, Colors.yellow, Colors.orange],
              thumbColor: Colors.purple,
              thumbRadius: 20.0,
              height: 60.0,
              onChanged: (newValues) {
                values = newValues;
              },
            ),
          ),
        ),
      );

      // Verify that the slider renders
      expect(
        find.byWidgetPredicate((widget) => widget.runtimeType.toString().startsWith('CustomMultiThumbSlider')),
        findsOneWidget,
      );

      // Verify that the slider has the correct number of values
      final slider = tester.widget<CustomMultiThumbSlider>(
        find.byWidgetPredicate((widget) => widget.runtimeType.toString().startsWith('CustomMultiThumbSlider')),
      );
      expect(slider.values.length, equals(3));
    });
  });
}
