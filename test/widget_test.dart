// Minimal Flutter widget tests for the Multi-Thumb Slider
//
// These tests focus on the most basic functionality with the simplest possible parameters
// to identify any fundamental issues with the widget.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

void main() {
  group('CustomMultiThumbSlider Widget Tests', () {
    group('Basic Rendering Tests', () {
      testWidgets('Int slider renders with minimal parameters', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [50],
                    min: 0,
                    max: 100,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for widget to render completely
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('Int slider with two values renders with minimal parameters', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [25, 75],
                    min: 0,
                    max: 100,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for widget to render completely
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('Int slider with three values renders with minimal parameters', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [20, 50, 80],
                    min: 0,
                    max: 100,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for widget to render completely
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Configuration Tests', () {
      testWidgets('Slider with custom height renders with minimal parameters', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [25, 50, 75],
                    min: 0,
                    max: 100,
                    height: 60.0,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('Slider with custom thumb radius renders with minimal parameters', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [25, 50, 75],
                    min: 0,
                    max: 100,
                    thumbRadius: 20.0,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Feature Tests', () {
      testWidgets('Read-only slider renders with minimal parameters', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [25, 50, 75],
                    min: 0,
                    max: 100,
                    readOnly: true,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('Slider with tickmarks renders with minimal parameters', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [25, 50, 75],
                    min: 0,
                    max: 100,
                    showTickmarks: true,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Value Handling Tests', () {
      testWidgets('Single value slider renders with minimal parameters', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [50],
                    min: 0,
                    max: 100,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('Many values slider renders with minimal parameters', (WidgetTester tester) async {
        final manyValues = List.generate(5, (index) => (index + 1) * 20);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: manyValues,
                    min: 0,
                    max: 100,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Edge Cases Tests', () {
      testWidgets('Min equals max slider renders with minimal parameters', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [50],
                    min: 50,
                    max: 50,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('Reversed min/max slider renders with minimal parameters', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [25, 75],
                    min: 100,
                    max: 0,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });
  });
}
