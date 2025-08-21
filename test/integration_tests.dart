import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

void main() {
  group('CustomMultiThumbSlider Integration Tests', () {
    group('Basic Instantiation', () {
      test('Widget can be instantiated with single value', () {
        // Test if the widget can be instantiated at all
        expect(() {
          CustomMultiThumbSlider<int>(
            values: [50],
            min: 0,
            max: 100,
            onChanged: (newValues) {},
          );
        }, returnsNormally);
      });

      test('Widget can be instantiated with two values', () {
        // Test if the widget can be instantiated with multiple values
        expect(() {
          CustomMultiThumbSlider<int>(
            values: [25, 75],
            min: 0,
            max: 100,
            onChanged: (newValues) {},
          );
        }, returnsNormally);
      });

      test('Widget can be instantiated with three values', () {
        // Test if the widget can be instantiated with three values
        expect(() {
          CustomMultiThumbSlider<int>(
            values: [20, 50, 80],
            min: 0,
            max: 100,
            onChanged: (newValues) {},
          );
        }, returnsNormally);
      });
    });

    group('Basic Widget Tree Integration', () {
      testWidgets('Widget can be added to widget tree', (WidgetTester tester) async {
        // Test if the widget can be added to the widget tree without crashing
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [50],
                min: 0,
                max: 100,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        // Just verify the widget was added to the tree
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('Widget can be added to widget tree with multiple values', (WidgetTester tester) async {
        // Test if the widget can be added to the widget tree with multiple values
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [25, 75],
                min: 0,
                max: 100,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        // Just verify the widget was added to the tree
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Parameter Validation', () {
      test('Widget validates non-empty values list', () {
        // Test that the widget properly validates the values list
        expect(() {
          CustomMultiThumbSlider<int>(
            values: <int>[],
            min: 0,
            max: 100,
            onChanged: (newValues) {},
          );
        }, throwsAssertionError);
      });

      test('Widget validates min and max values', () {
        // Test that the widget can be instantiated with valid min/max
        expect(() {
          CustomMultiThumbSlider<int>(
            values: [50],
            min: 0,
            max: 100,
            onChanged: (newValues) {},
          );
        }, returnsNormally);
      });
    });
  });
}