import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/src/value_type_handler.dart';

// Test enum for testing enum value handler
enum TestDifficulty { easy, medium, hard, expert }

void main() {
  group('NumericValueHandler Tests', () {
    late NumericValueHandler<int> intHandler;
    late NumericValueHandler<double> doubleHandler;

    setUp(() {
      intHandler = NumericValueHandler<int>();
      doubleHandler = NumericValueHandler<double>();
    });

    group('toNormalized', () {
      test('int handler converts values correctly', () {
        expect(intHandler.toNormalized(0, 0, 100), equals(0.0));
        expect(intHandler.toNormalized(50, 0, 100), equals(0.5));
        expect(intHandler.toNormalized(100, 0, 100), equals(1.0));
        expect(intHandler.toNormalized(25, 0, 100), equals(0.25));
        expect(intHandler.toNormalized(75, 0, 100), equals(0.75));
      });

      test('double handler converts values correctly', () {
        expect(doubleHandler.toNormalized(0.0, 0.0, 100.0), equals(0.0));
        expect(doubleHandler.toNormalized(50.0, 0.0, 100.0), equals(0.5));
        expect(doubleHandler.toNormalized(100.0, 0.0, 100.0), equals(1.0));
        expect(doubleHandler.toNormalized(25.5, 0.0, 100.0), equals(0.255));
        expect(doubleHandler.toNormalized(75.7, 0.0, 100.0), equals(0.757));
      });

      test('handles negative ranges', () {
        expect(intHandler.toNormalized(-50, -100, 0), equals(0.5));
        expect(intHandler.toNormalized(-25, -100, 0), equals(0.75));
        expect(doubleHandler.toNormalized(-50.0, -100.0, 0.0), equals(0.5));
      });

      test('handles reversed ranges', () {
        expect(intHandler.toNormalized(25, 100, 0), equals(0.75));
        expect(doubleHandler.toNormalized(25.0, 100.0, 0.0), equals(0.75));
      });
    });

    group('fromNormalized', () {
      test('int handler converts normalized positions correctly', () {
        expect(intHandler.fromNormalized(0.0, 0, 100), equals(0));
        expect(intHandler.fromNormalized(0.5, 0, 100), equals(50));
        expect(intHandler.fromNormalized(1.0, 0, 100), equals(100));
        expect(intHandler.fromNormalized(0.25, 0, 100), equals(25));
        expect(intHandler.fromNormalized(0.75, 0, 100), equals(75));
      });

      test('double handler converts normalized positions correctly', () {
        expect(doubleHandler.fromNormalized(0.0, 0.0, 100.0), equals(0.0));
        expect(doubleHandler.fromNormalized(0.5, 0.0, 100.0), equals(50.0));
        expect(doubleHandler.fromNormalized(1.0, 0.0, 100.0), equals(100.0));
        expect(doubleHandler.fromNormalized(0.255, 0.0, 100.0), equals(25.5));
        expect(doubleHandler.fromNormalized(0.757, 0.0, 100.0), equals(75.7));
      });

      test('handles negative ranges', () {
        expect(intHandler.fromNormalized(0.5, -100, 0), equals(-50));
        expect(doubleHandler.fromNormalized(0.5, -100.0, 0.0), equals(-50.0));
      });

      test('handles reversed ranges', () {
        expect(intHandler.fromNormalized(0.25, 100, 0), equals(75));
        expect(doubleHandler.fromNormalized(0.25, 100.0, 0.0), equals(75.0));
      });

      test('rounds correctly for int values', () {
        expect(intHandler.fromNormalized(0.333, 0, 100), equals(33));
        expect(intHandler.fromNormalized(0.666, 0, 100), equals(67));
      });
    });

    group('getAllPossibleValues', () {
      test('int handler returns all values in range', () {
        final values = intHandler.getAllPossibleValues(0, 5, null);
        expect(values, equals([0, 1, 2, 3, 4, 5]));
      });

      test('int handler returns single value when min equals max', () {
        final values = intHandler.getAllPossibleValues(10, 10, null);
        expect(values, equals([10]));
      });

      test('int handler returns empty list when min > max', () {
        final values = intHandler.getAllPossibleValues(10, 5, null);
        expect(values, equals([]));
      });

      test('int handler uses custom allPossibleValues when provided', () {
        final customValues = [0, 2, 4, 6, 8, 10];
        final values = intHandler.getAllPossibleValues(0, 10, customValues);
        expect(values, equals(customValues));
      });

      test('double handler returns min and max when no custom values', () {
        final values = doubleHandler.getAllPossibleValues(0.0, 100.0, null);
        expect(values, equals([0.0, 100.0]));
      });

      test('double handler uses custom allPossibleValues when provided', () {
        final customValues = [0.0, 25.0, 50.0, 75.0, 100.0];
        final values = doubleHandler.getAllPossibleValues(
          0.0,
          100.0,
          customValues,
        );
        expect(values, equals(customValues));
      });
    });

    group('shouldShowTickmarks', () {
      test('returns true for numeric types', () {
        expect(intHandler.shouldShowTickmarks(), isTrue);
        expect(doubleHandler.shouldShowTickmarks(), isTrue);
      });
    });

    group('formatValue', () {
      test('formats values correctly', () {
        expect(intHandler.formatValue(42, null), equals('42'));
        expect(doubleHandler.formatValue(42.5, null), equals('42.5'));
      });

      test('uses custom formatter when provided', () {
        String customFormatter(int value) => 'Value: $value';
        String customDoubleFormatter(double value) => 'Double: $value';

        expect(
          intHandler.formatValue(42, customFormatter),
          equals('Value: 42'),
        );
        expect(
          doubleHandler.formatValue(42.5, customDoubleFormatter),
          equals('Double: 42.5'),
        );
      });
    });
  });

  group('EnumValueHandler Tests', () {
    late EnumValueHandler<TestDifficulty> enumHandler;

    setUp(() {
      enumHandler = EnumValueHandler<TestDifficulty>();
    });

    group('toNormalized', () {
      test('converts enum values correctly', () {
        expect(
          enumHandler.toNormalized(
            TestDifficulty.easy,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(0.0),
        );
        expect(
          enumHandler.toNormalized(
            TestDifficulty.medium,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(0.3333333333333333),
        );
        expect(
          enumHandler.toNormalized(
            TestDifficulty.hard,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(0.6666666666666666),
        );
        expect(
          enumHandler.toNormalized(
            TestDifficulty.expert,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(1.0),
        );
      });

      test('handles reversed enum ranges', () {
        expect(
          enumHandler.toNormalized(
            TestDifficulty.expert,
            TestDifficulty.expert,
            TestDifficulty.easy,
          ),
          equals(0.0),
        );
        expect(
          enumHandler.toNormalized(
            TestDifficulty.easy,
            TestDifficulty.expert,
            TestDifficulty.easy,
          ),
          equals(1.0),
        );
      });
    });

    group('fromNormalized', () {
      test('converts normalized positions back to enum values correctly', () {
        // Test with allPossibleValues provided
        final enumHandlerWithValues = EnumValueHandler<TestDifficulty>(
          TestDifficulty.values,
        );

        expect(
          enumHandlerWithValues.fromNormalized(
            0.0,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(TestDifficulty.easy),
        );
        expect(
          enumHandlerWithValues.fromNormalized(
            0.3333333333333333,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(TestDifficulty.medium),
        );
        expect(
          enumHandlerWithValues.fromNormalized(
            0.6666666666666666,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(TestDifficulty.hard),
        );
        expect(
          enumHandlerWithValues.fromNormalized(
            1.0,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(TestDifficulty.expert),
        );
      });

      test('handles edge cases and clamping', () {
        final enumHandlerWithValues = EnumValueHandler<TestDifficulty>(
          TestDifficulty.values,
        );

        // Test values outside the 0.0-1.0 range (should clamp)
        expect(
          enumHandlerWithValues.fromNormalized(
            -0.1,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(TestDifficulty.easy),
        );
        expect(
          enumHandlerWithValues.fromNormalized(
            1.1,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(TestDifficulty.expert),
        );

        // Test intermediate values
        expect(
          enumHandlerWithValues.fromNormalized(
            0.25,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(TestDifficulty.medium),
        );
        expect(
          enumHandlerWithValues.fromNormalized(
            0.75,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(TestDifficulty.hard),
        );
      });

      test('fallback behavior when allPossibleValues not provided', () {
        // Test the fallback behavior when no allPossibleValues is provided
        expect(
          enumHandler.fromNormalized(
            0.5,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(TestDifficulty.easy),
        );
        expect(
          enumHandler.fromNormalized(
            0.0,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(TestDifficulty.easy),
        );
        expect(
          enumHandler.fromNormalized(
            1.0,
            TestDifficulty.easy,
            TestDifficulty.expert,
          ),
          equals(TestDifficulty.easy),
        );
      });
    });

    group('getAllPossibleValues', () {
      test('returns values in range when allPossibleValues provided', () {
        final allValues = TestDifficulty.values;
        final values = enumHandler.getAllPossibleValues(
          TestDifficulty.easy,
          TestDifficulty.hard,
          allValues,
        );
        expect(
          values,
          equals([
            TestDifficulty.easy,
            TestDifficulty.medium,
            TestDifficulty.hard,
          ]),
        );
      });

      test(
        'returns values in reversed range when allPossibleValues provided',
        () {
          final allValues = TestDifficulty.values;
          final values = enumHandler.getAllPossibleValues(
            TestDifficulty.hard,
            TestDifficulty.easy,
            allValues,
          );
          expect(
            values,
            equals([
              TestDifficulty.easy,
              TestDifficulty.medium,
              TestDifficulty.hard,
            ]),
          );
        },
      );

      test('throws error when allPossibleValues is null', () {
        expect(
          () => enumHandler.getAllPossibleValues(
            TestDifficulty.easy,
            TestDifficulty.expert,
            null,
          ),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('filters values correctly based on range', () {
        final allValues = TestDifficulty.values;
        final values = enumHandler.getAllPossibleValues(
          TestDifficulty.medium,
          TestDifficulty.expert,
          allValues,
        );
        expect(
          values,
          equals([
            TestDifficulty.medium,
            TestDifficulty.hard,
            TestDifficulty.expert,
          ]),
        );
      });
    });

    group('shouldShowTickmarks', () {
      test('returns true for enum types', () {
        expect(enumHandler.shouldShowTickmarks(), isTrue);
      });
    });

    group('formatValue', () {
      test('uses custom formatter when provided', () {
        String customFormatter(TestDifficulty value) =>
            'Difficulty: ${value.name}';

        expect(
          enumHandler.formatValue(TestDifficulty.easy, customFormatter),
          equals('Difficulty: easy'),
        );
        expect(
          enumHandler.formatValue(TestDifficulty.hard, customFormatter),
          equals('Difficulty: hard'),
        );
      });
    });
  });

  group('ValueTypeHandler Edge Cases', () {
    test('handles very large numbers', () {
      final intHandler = NumericValueHandler<int>();
      final doubleHandler = NumericValueHandler<double>();

      expect(
        () => intHandler.toNormalized(1000000, 0, 2000000),
        returnsNormally,
      );
      expect(
        () => doubleHandler.toNormalized(1000000.0, 0.0, 2000000.0),
        returnsNormally,
      );

      expect(intHandler.toNormalized(1000000, 0, 2000000), equals(0.5));
      expect(
        doubleHandler.toNormalized(1000000.0, 0.0, 2000000.0),
        equals(0.5),
      );
    });

    test('handles very small numbers', () {
      final doubleHandler = NumericValueHandler<double>();

      expect(
        () => doubleHandler.toNormalized(0.000001, 0.0, 0.000002),
        returnsNormally,
      );
      expect(doubleHandler.toNormalized(0.000001, 0.0, 0.000002), equals(0.5));
    });
  });
}
