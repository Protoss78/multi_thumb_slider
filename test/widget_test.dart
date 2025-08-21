// Minimal Flutter widget tests for the Multi-Thumb Slider
//
// These tests focus on the most basic functionality only.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

void main() {
  group('CustomMultiThumbSlider Widget Tests', () {
    test('Widget class exists', () {
      // Test that the widget class can be referenced
      expect(CustomMultiThumbSlider<int>, isA<Type>());
    });

    test('Widget can be instantiated', () {
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
  });
}
