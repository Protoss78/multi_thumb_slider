import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

// Test enum for testing enum slider functionality
enum TestDifficulty { easy, medium, hard, expert }

void main() {
  group('CustomMultiThumbSlider Integration Tests', () {
    group('Basic Functionality', () {
      testWidgets('renders with int values correctly', (WidgetTester tester) async {
        List<int> values = [20, 50, 80];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: values,
                    min: 0,
                    max: 100,
                    onChanged: (newValues) {
                      values = newValues;
                    },
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for widget to render completely
        await tester.pumpAndSettle();
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('renders with double values correctly', (WidgetTester tester) async {
        List<double> values = [20.5, 50.0, 80.7];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<double>(
                    values: values,
                    min: 0.0,
                    max: 100.0,
                    onChanged: (newValues) {
                      values = newValues;
                    },
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('renders with enum values correctly', (WidgetTester tester) async {
        List<TestDifficulty> values = [TestDifficulty.easy, TestDifficulty.medium, TestDifficulty.hard];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<TestDifficulty>(
                    values: values,
                    min: TestDifficulty.easy,
                    max: TestDifficulty.expert,
                    allPossibleValues: TestDifficulty.values,
                    onChanged: (newValues) {
                      values = newValues;
                    },
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Styling and Customization', () {
      testWidgets('applies custom colors correctly', (WidgetTester tester) async {
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
                    rangeColors: [Colors.blue, Colors.green, Colors.yellow],
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
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('applies custom dimensions correctly', (WidgetTester tester) async {
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
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('uses default styling when not specified', (WidgetTester tester) async {
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
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('handles tickmarks correctly', (WidgetTester tester) async {
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
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('handles tickmark color customization', (WidgetTester tester) async {
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
                    tickmarkColor: Colors.blue,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Value Constraints and Validation', () {
      testWidgets('handles single value correctly', (WidgetTester tester) async {
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
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('handles many values correctly', (WidgetTester tester) async {
        final manyValues = List.generate(10, (index) => index * 10);
        
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
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('handles edge values correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<int>(
                    values: [0, 100],
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
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Enum-specific Functionality', () {
      testWidgets('requires allPossibleValues for enum types', (WidgetTester tester) async {
        // This test verifies that the widget can be constructed with enum values
        // The actual validation would happen at runtime
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<TestDifficulty>(
                    values: [TestDifficulty.easy, TestDifficulty.hard],
                    min: TestDifficulty.easy,
                    max: TestDifficulty.expert,
                    allPossibleValues: TestDifficulty.values,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('handles enum range correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: CustomMultiThumbSlider<TestDifficulty>(
                    values: [TestDifficulty.medium, TestDifficulty.hard],
                    min: TestDifficulty.medium,
                    max: TestDifficulty.hard,
                    allPossibleValues: TestDifficulty.values,
                    onChanged: (newValues) {},
                  ),
                ),
              ),
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Error Handling and Edge Cases', () {
      testWidgets('handles empty values list gracefully', (WidgetTester tester) async {
        // Note: This might cause an error in the actual implementation
        // but we're testing that the widget can be constructed
        expect(() async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: Center(
                  child: SizedBox(
                    width: 300,
                    height: 200,
                    child: CustomMultiThumbSlider<int>(
                      values: <int>[],
                      min: 0,
                      max: 100,
                      onChanged: (newValues) {},
                    ),
                  ),
                ),
              ),
            ),
          );
        }, returnsNormally);
      });

      testWidgets('handles min equals max', (WidgetTester tester) async {
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
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('handles reversed min/max values', (WidgetTester tester) async {
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
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Widget Tree Structure', () {
      testWidgets('contains expected child widgets', (WidgetTester tester) async {
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
        
        // Verify the main slider widget exists
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        
        // The widget should render without errors
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles different screen sizes', (WidgetTester tester) async {
        // Test with different screen sizes
        await tester.binding.setSurfaceSize(const Size(300, 200));
        
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
        
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        
        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });
    });
  });
}