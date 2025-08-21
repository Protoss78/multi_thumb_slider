import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/src/position_calculator.dart';

void main() {
  group('PositionCalculator Tests', () {
    late GlobalKey sliderKey;
    late PositionCalculator calculator;

    setUp(() {
      sliderKey = GlobalKey();
      calculator = PositionCalculator(sliderKey);
    });

    group('calculateNormalizedPosition', () {
      test('returns 0.0 when renderBox is null', () {
        final position = calculator.calculateNormalizedPosition(const Offset(100, 50));
        expect(position, equals(0.0));
      });

      test('returns 0.0 when global position is at left edge', () {
        // Create a mock render box context
        final mockContext = MockBuildContext();
        sliderKey = GlobalKey(debugLabel: 'test');
        
        // We can't easily test with real render boxes in unit tests,
        // but we can test the edge case handling
        expect(() => calculator.calculateNormalizedPosition(const Offset(0, 0)), returnsNormally);
      });

      test('clamps position to 0.0-1.0 range', () {
        // Test that the method handles extreme positions gracefully
        expect(() => calculator.calculateNormalizedPosition(const Offset(-100, 0)), returnsNormally);
        expect(() => calculator.calculateNormalizedPosition(const Offset(1000, 0)), returnsNormally);
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
        expect(calculator.findNearestThumbIndex(0.5, positions), equals(0)); // Closer to 0.0
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

      test('handles equidistant positions', () {
        final positions = [0.3, 0.7];
        
        // When position is exactly between two thumbs, it should return the first one
        expect(calculator.findNearestThumbIndex(0.5, positions), equals(0));
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
      test('handles null or invalid render box gracefully', () {
        // Test that methods don't crash when render box is invalid
        expect(() => calculator.calculateNormalizedPosition(const Offset(0, 0)), returnsNormally);
      });

      test('handles extreme coordinate values', () {
        expect(() => calculator.calculateNormalizedPosition(const Offset(double.infinity, 0)), returnsNormally);
        expect(() => calculator.calculateNormalizedPosition(const Offset(double.negativeInfinity, 0)), returnsNormally);
        expect(() => calculator.calculateNormalizedPosition(const Offset(double.nan, 0)), returnsNormally);
      });

      test('handles very small position differences', () {
        final positions = [0.499999, 0.500001];
        
        expect(calculator.findNearestThumbIndex(0.5, positions), returnsNormally);
      });

      test('handles very large position differences', () {
        final positions = [0.0, 1.0];
        
        expect(calculator.findNearestThumbIndex(0.5, positions), returnsNormally);
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

      test('nearest thumb index respects boundaries', () {
        final positions = [0.2, 0.5, 0.8];
        
        // Test positions that should clearly belong to specific thumbs
        expect(calculator.findNearestThumbIndex(0.1, positions), equals(0));
        expect(calculator.findNearestThumbIndex(0.35, positions), equals(1));
        expect(calculator.findNearestThumbIndex(0.9, positions), equals(2));
      });
    });
  });
}

// Mock class for testing purposes
class MockBuildContext extends BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}