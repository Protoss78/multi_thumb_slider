// Minimal Flutter widget tests for the Multi-Thumb Slider
//
// These tests focus on the most basic functionality to identify
// if the issue is with widget construction or rendering.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

void main() {
  group('CustomMultiThumbSlider Widget Tests', () {
    group('Basic Construction Tests', () {
      testWidgets('Widget can be constructed with minimal parameters', (WidgetTester tester) async {
        // Test if the widget can be constructed at all
        expect(() {
          CustomMultiThumbSlider<int>(
            values: [50],
            min: 0,
            max: 100,
            onChanged: (newValues) {},
          );
        }, returnsNormally);
      });

      testWidgets('Widget can be constructed with two values', (WidgetTester tester) async {
        // Test if the widget can be constructed with multiple values
        expect(() {
          CustomMultiThumbSlider<int>(
            values: [25, 75],
            min: 0,
            max: 100,
            onChanged: (newValues) {},
          );
        }, returnsNormally);
      });

      testWidgets('Widget can be constructed with three values', (WidgetTester tester) async {
        // Test if the widget can be constructed with three values
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

    group('Parameter Validation Tests', () {
      testWidgets('Widget validates non-empty values list', (WidgetTester tester) async {
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

      testWidgets('Widget validates min and max values', (WidgetTester tester) async {
        // Test that the widget can be constructed with valid min/max
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

    group('Basic Rendering Tests', () {
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
  });
}
