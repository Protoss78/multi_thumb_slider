import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

void main() {
  group('CustomMultiThumbSlider Component Tests', () {
    group('Basic Construction', () {
      testWidgets('Widget can be constructed with single value', (WidgetTester tester) async {
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
  });
}