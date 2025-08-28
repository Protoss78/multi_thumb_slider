import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_range_slider/src/position_calculator.dart';

void main() {
  group('PositionCalculator Tests', () {
    late GlobalKey sliderKey;
    late PositionCalculator calculator;

    setUp(() {
      sliderKey = GlobalKey();
      calculator = PositionCalculator(sliderKey);
    });

    group('calculateNormalizedPosition', () {
      testWidgets('returns 0.0 when slider key has no context', (
        WidgetTester tester,
      ) async {
        final result = calculator.calculateNormalizedPosition(
          const Offset(100, 100),
        );
        expect(result, equals(0.0));
      });

      testWidgets('calculates normalized position correctly for left edge', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                height: 50,
                child: Container(key: sliderKey),
              ),
            ),
          ),
        );

        final result = calculator.calculateNormalizedPosition(
          const Offset(0, 25),
        );
        expect(result, equals(0.0));
      });

      testWidgets('calculates normalized position correctly for center', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                height: 50,
                child: Container(key: sliderKey),
              ),
            ),
          ),
        );

        final result = calculator.calculateNormalizedPosition(
          const Offset(100, 25),
        );
        expect(result, equals(0.5));
      });

      testWidgets('calculates normalized position correctly for right edge', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                height: 50,
                child: Container(key: sliderKey),
              ),
            ),
          ),
        );

        final result = calculator.calculateNormalizedPosition(
          const Offset(200, 25),
        );
        expect(result, equals(1.0));
      });

      testWidgets('clamps position to 0.0 when position is negative', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                height: 50,
                child: Container(key: sliderKey),
              ),
            ),
          ),
        );

        final result = calculator.calculateNormalizedPosition(
          const Offset(-50, 25),
        );
        expect(result, equals(0.0));
      });

      testWidgets('clamps position to 1.0 when position exceeds width', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                height: 50,
                child: Container(key: sliderKey),
              ),
            ),
          ),
        );

        final result = calculator.calculateNormalizedPosition(
          const Offset(250, 25),
        );
        expect(result, equals(1.0));
      });

      testWidgets('handles different slider widths correctly', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 400,
                height: 50,
                child: Container(key: sliderKey),
              ),
            ),
          ),
        );

        final result = calculator.calculateNormalizedPosition(
          const Offset(200, 25),
        );
        expect(result, equals(0.5));
      });

      testWidgets('handles fractional positions correctly', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 100,
                height: 50,
                child: Container(key: sliderKey),
              ),
            ),
          ),
        );

        final result = calculator.calculateNormalizedPosition(
          const Offset(75, 25),
        );
        expect(result, equals(0.75));
      });
    });

    group('findNearestThumbIndex', () {
      test('finds nearest thumb index correctly', () {
        final positions = [0.2, 0.5, 0.8];

        expect(calculator.findNearestThumbIndex(0.1, positions), equals(0));
        expect(calculator.findNearestThumbIndex(0.3, positions), equals(0));
        expect(calculator.findNearestThumbIndex(0.4, positions), equals(1));
        expect(calculator.findNearestThumbIndex(0.6, positions), equals(1));
        expect(calculator.findNearestThumbIndex(0.7, positions), equals(2));
        expect(calculator.findNearestThumbIndex(0.9, positions), equals(2));
      });

      test('handles exact matches', () {
        final positions = [0.2, 0.5, 0.8];

        expect(calculator.findNearestThumbIndex(0.2, positions), equals(0));
        expect(calculator.findNearestThumbIndex(0.5, positions), equals(1));
        expect(calculator.findNearestThumbIndex(0.8, positions), equals(2));
      });

      test('handles edge cases', () {
        final positions = [0.0, 1.0];

        expect(calculator.findNearestThumbIndex(0.0, positions), equals(0));
        expect(calculator.findNearestThumbIndex(1.0, positions), equals(1));
        expect(
          calculator.findNearestThumbIndex(0.5, positions),
          equals(0),
        ); // Closer to 0.0
      });

      test('handles single thumb', () {
        final positions = [0.5];

        expect(calculator.findNearestThumbIndex(0.0, positions), equals(0));
        expect(calculator.findNearestThumbIndex(0.5, positions), equals(0));
        expect(calculator.findNearestThumbIndex(1.0, positions), equals(0));
      });

      test('handles empty positions list', () {
        final positions = <double>[];

        expect(calculator.findNearestThumbIndex(0.5, positions), equals(0));
      });

      test('handles equidistant positions correctly', () {
        final positions = [0.0, 0.5, 1.0];

        // When position is exactly between two thumbs, should return the first one
        expect(calculator.findNearestThumbIndex(0.25, positions), equals(0));
        expect(calculator.findNearestThumbIndex(0.75, positions), equals(1));
      });

      test('handles negative positions', () {
        final positions = [0.2, 0.5, 0.8];

        expect(calculator.findNearestThumbIndex(-0.1, positions), equals(0));
        expect(calculator.findNearestThumbIndex(-0.5, positions), equals(0));
      });

      test('handles positions greater than 1.0', () {
        final positions = [0.2, 0.5, 0.8];

        expect(calculator.findNearestThumbIndex(1.1, positions), equals(2));
        expect(calculator.findNearestThumbIndex(2.0, positions), equals(2));
      });
    });

    group('calculateLowerBound', () {
      test('returns 0.0 for first thumb', () {
        final positions = [0.2, 0.5, 0.8];

        expect(calculator.calculateLowerBound(0, positions), equals(0.0));
      });

      test('returns previous thumb position for middle thumbs', () {
        final positions = [0.2, 0.5, 0.8];

        expect(calculator.calculateLowerBound(1, positions), equals(0.2));
        expect(calculator.calculateLowerBound(2, positions), equals(0.5));
      });

      test('handles single thumb', () {
        final positions = [0.5];

        expect(calculator.calculateLowerBound(0, positions), equals(0.0));
      });

      test('handles two thumbs', () {
        final positions = [0.3, 0.7];

        expect(calculator.calculateLowerBound(0, positions), equals(0.0));
        expect(calculator.calculateLowerBound(1, positions), equals(0.3));
      });
    });

    group('calculateUpperBound', () {
      test('returns 1.0 for last thumb', () {
        final positions = [0.2, 0.5, 0.8];

        expect(calculator.calculateUpperBound(2, positions), equals(1.0));
      });

      test('returns next thumb position for middle thumbs', () {
        final positions = [0.2, 0.5, 0.8];

        expect(calculator.calculateUpperBound(0, positions), equals(0.5));
        expect(calculator.calculateUpperBound(1, positions), equals(0.8));
      });

      test('handles single thumb', () {
        final positions = [0.5];

        expect(calculator.calculateUpperBound(0, positions), equals(1.0));
      });

      test('handles two thumbs', () {
        final positions = [0.3, 0.7];

        expect(calculator.calculateUpperBound(0, positions), equals(0.7));
        expect(calculator.calculateUpperBound(1, positions), equals(1.0));
      });
    });

    group('Edge Cases and Error Handling', () {
      test('handles single position for boundary calculations', () {
        final positions = [0.5];

        expect(calculator.calculateLowerBound(0, positions), equals(0.0));
        expect(calculator.calculateUpperBound(0, positions), equals(1.0));
      });

      test('handles positions at exact boundaries', () {
        final positions = [0.0, 1.0];

        expect(calculator.calculateLowerBound(0, positions), equals(0.0));
        expect(calculator.calculateLowerBound(1, positions), equals(0.0));
        expect(calculator.calculateUpperBound(0, positions), equals(1.0));
        expect(calculator.calculateUpperBound(1, positions), equals(1.0));
      });

      test('throws RangeError for negative indices', () {
        final positions = [0.2, 0.5, 0.8];

        // For calculateLowerBound(-1, positions): tries to access positions[-2] which throws RangeError
        expect(
          () => calculator.calculateLowerBound(-1, positions),
          throwsRangeError,
        );
        // For calculateUpperBound(-1, positions): tries to access positions[0] which is valid
        expect(calculator.calculateUpperBound(-1, positions), equals(0.2));
      });

      test('throws RangeError for indices beyond list length', () {
        final positions = [0.2, 0.5, 0.8];

        expect(
          () => calculator.calculateLowerBound(5, positions),
          throwsRangeError,
        );
        expect(
          () => calculator.calculateUpperBound(5, positions),
          throwsRangeError,
        );
      });

      test('handles empty list with valid index', () {
        final positions = <double>[];

        expect(calculator.calculateLowerBound(0, positions), equals(0.0));
        // calculateUpperBound(0, []) tries to access positions[1] which throws RangeError
        expect(
          () => calculator.calculateUpperBound(0, positions),
          throwsRangeError,
        );
      });
    });

    group('Integration Tests', () {
      test('boundary calculations work together correctly', () {
        final positions = [0.2, 0.5, 0.8];

        // Test that boundaries are consistent
        for (int i = 0; i < positions.length; i++) {
          final lowerBound = calculator.calculateLowerBound(i, positions);
          final upperBound = calculator.calculateUpperBound(i, positions);

          // Lower bound should be <= upper bound
          expect(lowerBound, lessThanOrEqualTo(upperBound));

          // Current position should be within bounds
          expect(positions[i], greaterThanOrEqualTo(lowerBound));
          expect(positions[i], lessThanOrEqualTo(upperBound));
        }
      });

      test('nearest thumb index works with boundary calculations', () {
        final positions = [0.2, 0.5, 0.8];

        // Test that finding nearest thumb and calculating boundaries work together
        for (
          double testPosition = 0.0;
          testPosition <= 1.0;
          testPosition += 0.1
        ) {
          final nearestIndex = calculator.findNearestThumbIndex(
            testPosition,
            positions,
          );
          final lowerBound = calculator.calculateLowerBound(
            nearestIndex,
            positions,
          );
          final upperBound = calculator.calculateUpperBound(
            nearestIndex,
            positions,
          );

          // The nearest thumb should be within its calculated boundaries
          expect(positions[nearestIndex], greaterThanOrEqualTo(lowerBound));
          expect(positions[nearestIndex], lessThanOrEqualTo(upperBound));
        }
      });

      test('position calculation and nearest thumb work together', () {
        final positions = [0.2, 0.5, 0.8];

        // Test various positions and verify consistency
        final testPositions = [0.0, 0.1, 0.3, 0.4, 0.6, 0.7, 0.9, 1.0];

        for (final testPosition in testPositions) {
          final nearestIndex = calculator.findNearestThumbIndex(
            testPosition,
            positions,
          );
          final actualPosition = positions[nearestIndex];

          // Verify that the found thumb is indeed the closest
          for (int i = 0; i < positions.length; i++) {
            final distanceToNearest = (testPosition - actualPosition).abs();
            final distanceToOther = (testPosition - positions[i]).abs();
            expect(distanceToNearest, lessThanOrEqualTo(distanceToOther));
          }
        }
      });
    });

    group('Constructor and Initialization', () {
      test('creates instance with valid slider key', () {
        final key = GlobalKey();
        final calculator = PositionCalculator(key);

        expect(calculator.sliderKey, equals(key));
      });

      test('can create multiple instances with different keys', () {
        final key1 = GlobalKey();
        final key2 = GlobalKey();

        final calculator1 = PositionCalculator(key1);
        final calculator2 = PositionCalculator(key2);

        expect(calculator1.sliderKey, equals(key1));
        expect(calculator2.sliderKey, equals(key2));
        expect(calculator1.sliderKey, isNot(equals(calculator2.sliderKey)));
      });
    });
  });
}

// Mock class for testing purposes
class MockBuildContext extends BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
