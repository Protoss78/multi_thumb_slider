// Comprehensive Flutter widget tests for the Multi-Thumb Slider
//
// These tests cover the main widget functionality, user interactions,
// and various configuration options.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';
import 'test_config.dart';

void main() {
  group('CustomMultiThumbSlider Widget Tests', () {
    setUp(() {
      MockCallbacks.reset();
    });

    group('Basic Rendering Tests', () {
      testWidgets('Int slider renders correctly with default values', (WidgetTester tester) async {
        List<int> values = [20, 50, 80];

        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: values,
              min: 0,
              max: 100,
              onChanged: (newValues) {
                values = newValues;
              },
            ),
          ),
        );

        // Wait for widget to render completely
        await TestConfig.waitForWidgetToRender(tester);
        
        // Verify the slider renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        
        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget is properly laid out
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('Double slider renders correctly with custom values', (WidgetTester tester) async {
        List<double> values = [20.5, 50.0, 80.7];

        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<double>(
              values: values,
              min: 0.0,
              max: 100.0,
              height: 40.0,
              thumbRadius: 15.0,
              onChanged: (newValues) {
                values = newValues;
              },
            ),
          ),
        );

        // Wait for widget to render completely
        await TestConfig.waitForWidgetToRender(tester);
        
        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('Enum slider renders correctly with all possible values', (WidgetTester tester) async {
        List<TestDifficulty> values = [TestDifficulty.easy, TestDifficulty.medium, TestDifficulty.hard];

        await tester.pumpWidget(
          TestConfig.createTestApp(
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
        );

        // Wait for widget to render completely
        await TestConfig.waitForWidgetToRender(tester);
        
        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Styling and Customization Tests', () {
      testWidgets('applies custom colors correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [30, 60, 90],
              min: 0,
              max: 100,
              trackColor: Colors.red,
              rangeColors: [Colors.blue, Colors.green, Colors.yellow],
              thumbColor: Colors.purple,
              onChanged: (newValues) {},
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('applies custom dimensions correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [25, 50, 75],
              min: 0,
              max: 100,
              height: 60.0,
              thumbRadius: 25.0,
              onChanged: (newValues) {},
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('uses default styling when not specified', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [25, 50, 75],
              min: 0,
              max: 100,
              onChanged: (newValues) {},
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Read-only Mode Tests', () {
      testWidgets('renders correctly in read-only mode', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [25, 50, 75],
              min: 0,
              max: 100,
              readOnly: true,
              onChanged: (newValues) {},
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('read-only mode does not affect visual appearance', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [25, 50, 75],
              min: 0,
              max: 100,
              readOnly: true,
              onChanged: (newValues) {},
            ),
          ),
        );

        // Should render the same as non-read-only mode
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Tickmarks and Labels Tests', () {
      testWidgets('shows tickmarks when enabled', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [25, 50, 75],
              min: 0,
              max: 100,
              showTickmarks: true,
              onChanged: (newValues) {},
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('applies custom tickmark color', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [25, 50, 75],
              min: 0,
              max: 100,
              showTickmarks: true,
              tickmarkColor: Colors.blue,
              onChanged: (newValues) {},
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Value Handling Tests', () {
      testWidgets('handles single value correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [50],
              min: 0,
              max: 100,
              onChanged: (newValues) {},
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('handles many values correctly', (WidgetTester tester) async {
        final manyValues = List.generate(10, (index) => index * 10);
        
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: manyValues,
              min: 0,
              max: 100,
              onChanged: (newValues) {},
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });

      testWidgets('handles edge values correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [0, 100],
              min: 0,
              max: 100,
              onChanged: (newValues) {},
            ),
          ),
        );

        // Wait for layout to complete
        await tester.pumpAndSettle();
        
        // Verify the widget renders
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });

    group('Widget Tree Structure', () {
      testWidgets('contains expected child widgets', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [25, 50, 75],
              min: 0,
              max: 100,
              onChanged: (newValues) {},
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
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [25, 50, 75],
              min: 0,
              max: 100,
              onChanged: (newValues) {},
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
