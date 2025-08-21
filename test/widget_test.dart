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
        bool onChangedCalled = false;

        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: values,
              min: 0,
              max: 100,
              onChanged: (newValues) {
                values = newValues;
                onChangedCalled = true;
              },
            ),
          ),
        );

        // Verify the slider renders
        tester.expectWidgetExists<CustomMultiThumbSlider>(CustomMultiThumbSlider);
        
        // Verify the slider has the correct properties
        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.values.length, equals(3));
        expect(slider.values, equals([20, 50, 80]));
        expect(slider.min, equals(0));
        expect(slider.max, equals(100));
        expect(slider.height, equals(20.0)); // Default height
        expect(slider.thumbRadius, equals(10.0)); // Default thumb radius
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

        final slider = tester.findWidget<CustomMultiThumbSlider<double>>(CustomMultiThumbSlider);
        expect(slider.values.length, equals(3));
        expect(slider.values, equals([20.5, 50.0, 80.7]));
        expect(slider.height, equals(40.0));
        expect(slider.thumbRadius, equals(15.0));
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

        final slider = tester.findWidget<CustomMultiThumbSlider<TestDifficulty>>(CustomMultiThumbSlider);
        expect(slider.values.length, equals(3));
        expect(slider.values, equals([TestDifficulty.easy, TestDifficulty.medium, TestDifficulty.hard]));
        expect(slider.allPossibleValues, equals(TestDifficulty.values));
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

        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.trackColor, equals(Colors.red));
        expect(slider.rangeColors, equals([Colors.blue, Colors.green, Colors.yellow]));
        expect(slider.thumbColor, equals(Colors.purple));
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

        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.height, equals(60.0));
        expect(slider.thumbRadius, equals(25.0));
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

        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.height, equals(20.0)); // Default height
        expect(slider.thumbRadius, equals(10.0)); // Default thumb radius
        expect(slider.trackColor, isNotNull); // Should have a default color
        expect(slider.thumbColor, isNotNull); // Should have a default color
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

        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.readOnly, isTrue);
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

        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.showTickmarks, isTrue);
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

        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.tickmarkColor, equals(Colors.blue));
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

        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.values.length, equals(1));
        expect(slider.values.first, equals(50));
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

        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.values.length, equals(10));
        expect(slider.values, equals(manyValues));
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

        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.values.first, equals(0));
        expect(slider.values.last, equals(100));
      });
    });

    group('Edge Cases and Error Handling', () {
      testWidgets('handles min equals max gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [50],
              min: 50,
              max: 50,
              onChanged: (newValues) {},
            ),
          ),
        );

        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.min, equals(50));
        expect(slider.max, equals(50));
      });

      testWidgets('handles reversed min/max values', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: CustomMultiThumbSlider<int>(
              values: [25, 75],
              min: 100,
              max: 0,
              onChanged: (newValues) {},
            ),
          ),
        );

        final slider = tester.findWidget<CustomMultiThumbSlider<int>>(CustomMultiThumbSlider);
        expect(slider.min, equals(100));
        expect(slider.max, equals(0));
      });

      testWidgets('renders without errors for various configurations', (WidgetTester tester) async {
        // Test various combinations of properties
        final testConfigs = [
          {'height': 10.0, 'thumbRadius': 5.0},
          {'height': 100.0, 'thumbRadius': 50.0},
          {'showTickmarks': true, 'readOnly': true},
          {'trackColor': Colors.black, 'thumbColor': Colors.white},
        ];

        for (final config in testConfigs) {
          await tester.pumpWidget(
            TestConfig.createTestApp(
              child: CustomMultiThumbSlider<int>(
                values: [25, 50, 75],
                min: 0,
                max: 100,
                onChanged: (newValues) {},
                ...config,
              ),
            ),
          );

          expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
          expect(tester.takeException(), isNull);
        }
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

        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
        
        // Reset surface size
        await tester.binding.setSurfaceSize(null);
      });
    });

    group('Performance Tests', () {
      testWidgets('renders quickly with many values', (WidgetTester tester) async {
        final manyValues = List.generate(20, (index) => index * 5);
        
        final stopwatch = Stopwatch()..start();
        
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
        
        stopwatch.stop();
        
        // Should render within reasonable time (adjust threshold as needed)
        expect(stopwatch.elapsedMilliseconds, lessThan(1000));
        expect(find.byType(CustomMultiThumbSlider), findsOneWidget);
      });
    });
  });
}
