import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

void main() {
  group('CustomMultiThumbSlider Component Tests', () {
    group('Basic Component Rendering', () {
      testWidgets('slider renders with valid parameters', (WidgetTester tester) async {
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

      testWidgets('slider with custom colors renders with valid parameters', (WidgetTester tester) async {
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
                    trackColor: Colors.red,
                    rangeColors: [Colors.blue, Colors.green],
                    thumbColor: Colors.purple,
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

      testWidgets('slider with custom dimensions renders with valid parameters', (WidgetTester tester) async {
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
                    thumbRadius: 25.0,
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

    group('Feature Rendering', () {
      testWidgets('read-only slider renders with valid parameters', (WidgetTester tester) async {
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

      testWidgets('slider with tickmarks renders with valid parameters', (WidgetTester tester) async {
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
      testWidgets('single value slider renders with valid parameters', (WidgetTester tester) async {
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

      testWidgets('multiple values slider renders with valid parameters', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [10, 30, 50, 70, 90],
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
      testWidgets('min equals max slider renders with valid parameters', (WidgetTester tester) async {
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

      testWidgets('reversed range slider renders with valid parameters', (WidgetTester tester) async {
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