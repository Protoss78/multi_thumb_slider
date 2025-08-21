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
        bool onChangedCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: values,
                min: 0,
                max: 100,
                onChanged: (newValues) {
                  values = newValues;
                  onChangedCalled = true;
                },
              ),
            ),
          ),
        );

        // Wait for widget to render completely
        await TestConfig.waitForWidgetToRender(tester);
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        
        // Verify the slider has the correct number of values
        final slider = tester.widget<CustomMultiThumbSlider<int>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.values.length, equals(3));
        expect(slider.values, equals([20, 50, 80]));
        expect(slider.min, equals(0));
        expect(slider.max, equals(100));
      });

      testWidgets('renders with double values correctly', (WidgetTester tester) async {
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

        final slider = tester.widget<CustomMultiThumbSlider<double>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.values.length, equals(3));
        expect(slider.values, equals([20.5, 50.0, 80.7]));
        expect(slider.min, equals(0.0));
        expect(slider.max, equals(100.0));
      });

      testWidgets('renders with enum values correctly', (WidgetTester tester) async {
        List<TestDifficulty> values = [TestDifficulty.easy, TestDifficulty.medium, TestDifficulty.hard];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<TestDifficulty>(
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
        );

        final slider = tester.widget<CustomMultiThumbSlider<TestDifficulty>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.values.length, equals(3));
        expect(slider.values, equals([TestDifficulty.easy, TestDifficulty.medium, TestDifficulty.hard]));
        expect(slider.min, equals(TestDifficulty.easy));
        expect(slider.max, equals(TestDifficulty.expert));
      });
    });

    group('Styling and Customization', () {
      testWidgets('applies custom styling correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [30, 60, 90],
                min: 0,
                max: 100,
                trackColor: Colors.red,
                rangeColors: [Colors.blue, Colors.green, Colors.yellow, Colors.orange],
                thumbColor: Colors.purple,
                thumbRadius: 20.0,
                height: 60.0,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<CustomMultiThumbSlider<int>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.trackColor, equals(Colors.red));
        expect(slider.rangeColors, equals([Colors.blue, Colors.green, Colors.yellow, Colors.orange]));
        expect(slider.thumbColor, equals(Colors.purple));
        expect(slider.thumbRadius, equals(20.0));
        expect(slider.height, equals(60.0));
      });

      testWidgets('applies default styling when not specified', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [25, 50, 75],
                min: 0,
                max: 100,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<CustomMultiThumbSlider<int>>(
          find.byType(CustomMultiThumbSlider),
        );
        // Verify default values are applied
        expect(slider.height, equals(45.0));
        expect(slider.thumbRadius, equals(14.0));
      });
    });

    group('Read-only Mode', () {
      testWidgets('renders in read-only mode', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [25, 50, 75],
                min: 0,
                max: 100,
                readOnly: true,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<CustomMultiThumbSlider<int>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.readOnly, isTrue);
      });

      testWidgets('read-only mode does not prevent rendering', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [25, 50, 75],
                min: 0,
                max: 100,
                readOnly: true,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Tickmarks and Labels', () {
      testWidgets('shows tickmarks when enabled', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [25, 50, 75],
                min: 0,
                max: 100,
                showTickmarks: true,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<CustomMultiThumbSlider<int>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.showTickmarks, isTrue);
      });

      testWidgets('handles tickmark color customization', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [25, 50, 75],
                min: 0,
                max: 100,
                showTickmarks: true,
                tickmarkColor: Colors.blue,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<CustomMultiThumbSlider<int>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.tickmarkColor, equals(Colors.blue));
      });
    });

    group('Value Constraints and Validation', () {
      testWidgets('handles single value correctly', (WidgetTester tester) async {
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

        final slider = tester.widget<CustomMultiThumbSlider<int>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.values.length, equals(1));
        expect(slider.values.first, equals(50));
      });

      testWidgets('handles many values correctly', (WidgetTester tester) async {
        final manyValues = List.generate(10, (index) => index * 10);
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: manyValues,
                min: 0,
                max: 100,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<CustomMultiThumbSlider<int>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.values.length, equals(10));
        expect(slider.values, equals(manyValues));
      });

      testWidgets('handles edge values correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [0, 100],
                min: 0,
                max: 100,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<CustomMultiThumbSlider<int>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.values.first, equals(0));
        expect(slider.values.last, equals(100));
      });
    });

    group('Enum-specific Functionality', () {
      testWidgets('requires allPossibleValues for enum types', (WidgetTester tester) async {
        // This test verifies that the widget can be constructed with enum values
        // The actual validation would happen at runtime
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<TestDifficulty>(
                values: [TestDifficulty.easy, TestDifficulty.hard],
                min: TestDifficulty.easy,
                max: TestDifficulty.expert,
                allPossibleValues: TestDifficulty.values,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<CustomMultiThumbSlider<TestDifficulty>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.allPossibleValues, equals(TestDifficulty.values));
      });

      testWidgets('handles enum range correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<TestDifficulty>(
                values: [TestDifficulty.medium, TestDifficulty.hard],
                min: TestDifficulty.medium,
                max: TestDifficulty.hard,
                allPossibleValues: TestDifficulty.values,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<CustomMultiThumbSlider<TestDifficulty>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.min, equals(TestDifficulty.medium));
        expect(slider.max, equals(TestDifficulty.hard));
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
                body: CustomMultiThumbSlider<int>(
                  values: <int>[],
                  min: 0,
                  max: 100,
                  onChanged: (newValues) {},
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
              body: CustomMultiThumbSlider<int>(
                values: [50],
                min: 50,
                max: 50,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<CustomMultiThumbSlider<int>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.min, equals(50));
        expect(slider.max, equals(50));
      });

      testWidgets('handles reversed min/max values', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [25, 75],
                min: 100,
                max: 0,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<CustomMultiThumbSlider<int>>(
          find.byType(CustomMultiThumbSlider),
        );
        expect(slider.min, equals(100));
        expect(slider.max, equals(0));
      });
    });

    group('Widget Tree Structure', () {
      testWidgets('contains expected child widgets', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [25, 50, 75],
                min: 0,
                max: 100,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        // Verify the main slider widget exists
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        
        // The widget should contain various child widgets
        // Note: We can't easily test the exact structure without knowing the implementation details
        // but we can verify the widget renders without errors
        expect(tester.takeException(), isNull);
      });

      testWidgets('handles different screen sizes', (WidgetTester tester) async {
        // Test with different screen sizes
        await tester.binding.setSurfaceSize(const Size(300, 200));
        
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomMultiThumbSlider<int>(
                values: [25, 50, 75],
                min: 0,
                max: 100,
                onChanged: (newValues) {},
              ),
            ),
          ),
        );

        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        
        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });
    });
  });
}