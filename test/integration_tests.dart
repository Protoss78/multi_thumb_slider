import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

void main() {
  group('CustomMultiThumbSlider Integration Tests', () {
    group('Basic Functionality', () {
      testWidgets('renders with single int value and minimal parameters', (WidgetTester tester) async {
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

      testWidgets('renders with two int values and minimal parameters', (WidgetTester tester) async {
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

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('renders with three int values and minimal parameters', (WidgetTester tester) async {
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

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders without errors
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Basic Configuration', () {
      testWidgets('custom height renders with minimal parameters', (WidgetTester tester) async {
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

      testWidgets('custom thumb radius renders with minimal parameters', (WidgetTester tester) async {
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

    group('Basic Features', () {
      testWidgets('read-only mode renders with minimal parameters', (WidgetTester tester) async {
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

      testWidgets('tickmarks render with minimal parameters', (WidgetTester tester) async {
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

    group('Value Handling', () {
      testWidgets('single value renders with minimal parameters', (WidgetTester tester) async {
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

      testWidgets('multiple values render with minimal parameters', (WidgetTester tester) async {
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

    group('Edge Cases', () {
      testWidgets('min equals max renders with minimal parameters', (WidgetTester tester) async {
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

      testWidgets('reversed min/max renders with minimal parameters', (WidgetTester tester) async {
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