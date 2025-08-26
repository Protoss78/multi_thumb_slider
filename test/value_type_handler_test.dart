import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/src/value_type_handler.dart';

// Test enum for testing purposes
enum TestDifficulty { easy, medium, hard, expert }

void main() {
  group('ValueTypeHandler Tests', () {
    group('NumericValueHandler Tests', () {
      group('Integer Handler', () {
        late NumericValueHandler<int> handler;

        setUp(() {
          handler = NumericValueHandler<int>();
        });

        test('converts int value to normalized position correctly', () {
          expect(handler.toNormalized(0, 0, 100), equals(0.0));
          expect(handler.toNormalized(50, 0, 100), equals(0.5));
          expect(handler.toNormalized(100, 0, 100), equals(1.0));
          expect(handler.toNormalized(25, 0, 100), equals(0.25));
          expect(handler.toNormalized(75, 0, 100), equals(0.75));
        });

        test('converts int value to normalized position with different ranges', () {
          expect(handler.toNormalized(5, 0, 10), equals(0.5));
          expect(handler.toNormalized(150, 100, 200), equals(0.5));
          expect(handler.toNormalized(-50, -100, 0), equals(0.5));
        });

        test('converts normalized position back to int value correctly', () {
          expect(handler.fromNormalized(0.0, 0, 100), equals(0));
          expect(handler.fromNormalized(0.5, 0, 100), equals(50));
          expect(handler.fromNormalized(1.0, 0, 100), equals(100));
          expect(handler.fromNormalized(0.25, 0, 100), equals(25));
          expect(handler.fromNormalized(0.75, 0, 100), equals(75));
        });

        test('rounds normalized position correctly for int values', () {
          expect(handler.fromNormalized(0.234, 0, 100), equals(23));
          expect(handler.fromNormalized(0.567, 0, 100), equals(57));
          expect(handler.fromNormalized(0.999, 0, 100), equals(100));
        });

        test('handles negative int ranges correctly', () {
          expect(handler.toNormalized(-50, -100, 0), equals(0.5));
          expect(handler.fromNormalized(0.5, -100, 0), equals(-50));
          expect(handler.toNormalized(-75, -100, -50), equals(0.5));
          expect(handler.fromNormalized(0.5, -100, -50), equals(-75));
        });

        test('gets all possible int values in range', () {
          final values = handler.getAllPossibleValues(0, 5, null);
          expect(values, equals([0, 1, 2, 3, 4, 5]));
        });

        test('gets all possible int values with large range', () {
          final values = handler.getAllPossibleValues(98, 102, null);
          expect(values, equals([98, 99, 100, 101, 102]));
        });

        test('uses provided allPossibleValues when given', () {
          final providedValues = [10, 20, 30];
          final values = handler.getAllPossibleValues(0, 100, providedValues);
          expect(values, equals(providedValues));
        });

        test('should show tickmarks for int handler', () {
          expect(handler.shouldShowTickmarks(), isTrue);
        });

        test('formats int values correctly', () {
          expect(handler.formatValue(42, null), equals('42'));
          expect(handler.formatValue(-15, null), equals('-15'));
        });

        test('uses custom formatter when provided', () {
          String customFormatter(int value) => 'Value: $value';
          expect(handler.formatValue(42, customFormatter), equals('Value: 42'));
        });
      });

      group('Double Handler', () {
        late NumericValueHandler<double> handler;

        setUp(() {
          handler = NumericValueHandler<double>();
        });

        test('converts double value to normalized position correctly', () {
          expect(handler.toNormalized(0.0, 0.0, 100.0), equals(0.0));
          expect(handler.toNormalized(50.0, 0.0, 100.0), equals(0.5));
          expect(handler.toNormalized(100.0, 0.0, 100.0), equals(1.0));
          expect(handler.toNormalized(25.5, 0.0, 100.0), equals(0.255));
        });

        test('converts normalized position back to double value correctly', () {
          expect(handler.fromNormalized(0.0, 0.0, 100.0), equals(0.0));
          expect(handler.fromNormalized(0.5, 0.0, 100.0), equals(50.0));
          expect(handler.fromNormalized(1.0, 0.0, 100.0), equals(100.0));
          expect(handler.fromNormalized(0.255, 0.0, 100.0), equals(25.5));
        });

        test('handles very small double values', () {
          expect(handler.toNormalized(0.001, 0.0, 0.002), equals(0.5));
          expect(handler.fromNormalized(0.5, 0.0, 0.002), equals(0.001));
        });

        test('gets minimal double values (min and max only)', () {
          final values = handler.getAllPossibleValues(0.0, 100.0, null);
          expect(values, equals([0.0, 100.0]));
        });

        test('uses provided allPossibleValues when given for doubles', () {
          final providedValues = [10.5, 20.7, 30.2];
          final values = handler.getAllPossibleValues(0.0, 100.0, providedValues);
          expect(values, equals(providedValues));
        });

        test('should show tickmarks for double handler', () {
          expect(handler.shouldShowTickmarks(), isTrue);
        });

        test('formats double values correctly', () {
          expect(handler.formatValue(42.5, null), equals('42.5'));
          expect(handler.formatValue(-15.75, null), equals('-15.75'));
        });

        test('uses custom formatter for doubles when provided', () {
          String customFormatter(double value) => value.toStringAsFixed(1);
          expect(handler.formatValue(42.567, customFormatter), equals('42.6'));
        });
      });
    });

    group('EnumValueHandler Tests', () {
      group('Basic Enum Operations', () {
        late EnumValueHandler<TestDifficulty> handler;
        late List<TestDifficulty> allValues;

        setUp(() {
          allValues = TestDifficulty.values;
          handler = EnumValueHandler<TestDifficulty>(allValues);
        });

        test('converts enum value to normalized position correctly', () {
          expect(handler.toNormalized(TestDifficulty.easy, TestDifficulty.easy, TestDifficulty.expert), equals(0.0));
          expect(
            handler.toNormalized(TestDifficulty.medium, TestDifficulty.easy, TestDifficulty.expert),
            equals(1.0 / 3.0),
          );
          expect(
            handler.toNormalized(TestDifficulty.hard, TestDifficulty.easy, TestDifficulty.expert),
            equals(2.0 / 3.0),
          );
          expect(handler.toNormalized(TestDifficulty.expert, TestDifficulty.easy, TestDifficulty.expert), equals(1.0));
        });

        test('converts normalized position back to enum value correctly', () {
          expect(handler.fromNormalized(0.0, TestDifficulty.easy, TestDifficulty.expert), equals(TestDifficulty.easy));
          expect(
            handler.fromNormalized(0.33, TestDifficulty.easy, TestDifficulty.expert),
            equals(TestDifficulty.medium),
          );
          expect(handler.fromNormalized(0.67, TestDifficulty.easy, TestDifficulty.expert), equals(TestDifficulty.hard));
          expect(
            handler.fromNormalized(1.0, TestDifficulty.easy, TestDifficulty.expert),
            equals(TestDifficulty.expert),
          );
        });

        test('handles partial enum ranges correctly', () {
          expect(handler.toNormalized(TestDifficulty.medium, TestDifficulty.medium, TestDifficulty.hard), equals(0.0));
          expect(handler.toNormalized(TestDifficulty.hard, TestDifficulty.medium, TestDifficulty.hard), equals(1.0));
        });

        test('gets all possible enum values in range', () {
          final values = handler.getAllPossibleValues(TestDifficulty.easy, TestDifficulty.expert, allValues);
          expect(values, equals(allValues));
        });

        test('gets partial enum values in range', () {
          final values = handler.getAllPossibleValues(TestDifficulty.medium, TestDifficulty.hard, allValues);
          expect(values, equals([TestDifficulty.medium, TestDifficulty.hard]));
        });

        test('handles reversed enum ranges', () {
          final values = handler.getAllPossibleValues(TestDifficulty.hard, TestDifficulty.medium, allValues);
          expect(values, equals([TestDifficulty.medium, TestDifficulty.hard]));
        });

        test('throws error when allPossibleValues is null', () {
          expect(
            () => handler.getAllPossibleValues(TestDifficulty.easy, TestDifficulty.expert, null),
            throwsArgumentError,
          );
        });

        test('should show tickmarks for enum handler', () {
          expect(handler.shouldShowTickmarks(), isTrue);
        });

        test('formats enum values correctly', () {
          expect(handler.formatValue(TestDifficulty.easy, null), equals('easy'));
          expect(handler.formatValue(TestDifficulty.expert, null), equals('expert'));
        });

        test('uses custom formatter for enums when provided', () {
          String customFormatter(TestDifficulty value) => value.name.toUpperCase();
          expect(handler.formatValue(TestDifficulty.easy, customFormatter), equals('EASY'));
        });
      });

      group('Enum Handler Without Predefined Values', () {
        late EnumValueHandler<TestDifficulty> handler;

        setUp(() {
          handler = EnumValueHandler<TestDifficulty>();
        });

        test('handles fromNormalized without allPossibleValues', () {
          final result = handler.fromNormalized(0.5, TestDifficulty.easy, TestDifficulty.expert);
          expect(result, equals(TestDifficulty.easy)); // Falls back to min
        });

        test('handles edge cases in fromNormalized without allPossibleValues', () {
          expect(
            handler.fromNormalized(0.0, TestDifficulty.medium, TestDifficulty.hard),
            equals(TestDifficulty.medium),
          );
          // The handler without allPossibleValues falls back to closest min/max comparison
          final result = handler.fromNormalized(1.0, TestDifficulty.medium, TestDifficulty.hard);
          expect(result, isIn([TestDifficulty.medium, TestDifficulty.hard]));
        });
      });
    });

    group('GenericValueHandler Tests', () {
      group('Numeric Types in Generic Handler', () {
        late GenericValueHandler<int> intHandler;
        late GenericValueHandler<double> doubleHandler;

        setUp(() {
          intHandler = GenericValueHandler<int>();
          doubleHandler = GenericValueHandler<double>();
        });

        test('handles int values like NumericValueHandler', () {
          expect(intHandler.toNormalized(50, 0, 100), equals(0.5));
          expect(intHandler.fromNormalized(0.5, 0, 100), equals(50));
        });

        test('handles double values like NumericValueHandler', () {
          expect(doubleHandler.toNormalized(50.0, 0.0, 100.0), equals(0.5));
          expect(doubleHandler.fromNormalized(0.5, 0.0, 100.0), equals(50.0));
        });

        test('gets all possible int values', () {
          final values = intHandler.getAllPossibleValues(0, 3, null);
          expect(values, equals([0, 1, 2, 3]));
        });

        test('gets minimal double values', () {
          final values = doubleHandler.getAllPossibleValues(0.0, 100.0, null);
          expect(values, equals([0.0, 100.0]));
        });
      });

      group('Enum Types in Generic Handler', () {
        late GenericValueHandler<TestDifficulty> handler;
        late List<TestDifficulty> allValues;

        setUp(() {
          allValues = TestDifficulty.values;
          handler = GenericValueHandler<TestDifficulty>(allValues);
        });

        test('handles enum values like EnumValueHandler', () {
          expect(
            handler.toNormalized(TestDifficulty.medium, TestDifficulty.easy, TestDifficulty.expert),
            equals(1.0 / 3.0),
          );
        });

        test('converts normalized position back to enum with allPossibleValues', () {
          expect(
            handler.fromNormalized(0.33, TestDifficulty.easy, TestDifficulty.expert),
            equals(TestDifficulty.medium),
          );
        });

        test('handles enum without allPossibleValues', () {
          final handlerWithoutValues = GenericValueHandler<TestDifficulty>();
          final result = handlerWithoutValues.fromNormalized(0.5, TestDifficulty.easy, TestDifficulty.expert);
          // The generic handler without allPossibleValues uses distance comparison
          expect(result, isIn([TestDifficulty.easy, TestDifficulty.expert]));
        });

        test('gets all possible enum values', () {
          final values = handler.getAllPossibleValues(TestDifficulty.easy, TestDifficulty.expert, allValues);
          expect(values, equals(allValues));
        });
      });

      group('Generic Types in Generic Handler', () {
        late GenericValueHandler<String> handler;

        setUp(() {
          handler = GenericValueHandler<String>();
        });

        test('handles unknown types with fallback behavior', () {
          expect(handler.toNormalized('middle', 'start', 'end'), equals(0.5));
          expect(handler.fromNormalized(0.5, 'start', 'end'), equals('start'));
        });

        test('gets fallback values for unknown types', () {
          final values = handler.getAllPossibleValues('start', 'end', null);
          expect(values, equals(['start', 'end']));
        });

        test('uses provided values for unknown types', () {
          final providedValues = ['a', 'b', 'c'];
          final values = handler.getAllPossibleValues('start', 'end', providedValues);
          expect(values, equals(providedValues));
        });

        test('should show tickmarks for generic handler', () {
          expect(handler.shouldShowTickmarks(), isTrue);
        });

        test('formats generic values correctly', () {
          expect(handler.formatValue('test', null), equals('test'));
        });
      });

      group('Value Formatting in Generic Handler', () {
        test('formats numeric values correctly', () {
          final intHandler = GenericValueHandler<int>();
          final doubleHandler = GenericValueHandler<double>();

          expect(intHandler.formatValue(42, null), equals('42'));
          expect(doubleHandler.formatValue(42.5, null), equals('42.5'));
        });

        test('formats enum values correctly', () {
          final handler = GenericValueHandler<TestDifficulty>();
          expect(handler.formatValue(TestDifficulty.easy, null), equals('easy'));
        });

        test('uses custom formatters', () {
          final handler = GenericValueHandler<int>();
          String customFormatter(int value) => 'Custom: $value';
          expect(handler.formatValue(42, customFormatter), equals('Custom: 42'));
        });
      });
    });

    group('ValueTypeHandlerFactory Tests', () {
      test('creates generic handler by default', () {
        final handler = ValueTypeHandlerFactory.create<int>();
        expect(handler, isA<GenericValueHandler<int>>());
      });

      test('creates generic handler for double type', () {
        final handler = ValueTypeHandlerFactory.create<double>();
        expect(handler, isA<GenericValueHandler<double>>());
      });

      test('creates generic handler for enum type', () {
        final handler = ValueTypeHandlerFactory.create<TestDifficulty>();
        expect(handler, isA<GenericValueHandler<TestDifficulty>>());
      });

      test('creates handler with context', () {
        final allValues = TestDifficulty.values;
        final handler = ValueTypeHandlerFactory.createWithContext<TestDifficulty>(allPossibleValues: allValues);
        expect(handler, isA<GenericValueHandler<TestDifficulty>>());

        // Verify that the context is used
        final values = handler.getAllPossibleValues(TestDifficulty.easy, TestDifficulty.expert, null);
        expect(values, equals(allValues));
      });

      test('creates handler without context', () {
        final handler = ValueTypeHandlerFactory.createWithContext<int>();
        expect(handler, isA<GenericValueHandler<int>>());
      });
    });

    group('Edge Cases and Error Handling', () {
      test('handles zero range in numeric handler', () {
        final handler = NumericValueHandler<int>();
        // Zero range results in division by zero, which produces NaN
        final result = handler.toNormalized(5, 5, 5);
        expect(result.isNaN, isTrue);
      });

      test('handles very small ranges in numeric handler', () {
        final handler = NumericValueHandler<double>();
        expect(handler.toNormalized(0.0001, 0.0, 0.0002), equals(0.5));
      });

      test('handles boundary values correctly', () {
        final handler = NumericValueHandler<int>();
        expect(handler.fromNormalized(-0.1, 0, 100), equals(-10));
        expect(handler.fromNormalized(1.1, 0, 100), equals(110));
      });

      test('handles single enum value range', () {
        final handler = EnumValueHandler<TestDifficulty>(TestDifficulty.values);
        // Single enum value range also results in division by zero (NaN)
        final result = handler.toNormalized(TestDifficulty.easy, TestDifficulty.easy, TestDifficulty.easy);
        expect(result.isNaN, isTrue);
      });

      test('enum handler with empty allPossibleValues', () {
        final handler = EnumValueHandler<TestDifficulty>([]);
        expect(handler.fromNormalized(0.5, TestDifficulty.easy, TestDifficulty.expert), equals(TestDifficulty.easy));
      });

      test('generic handler handles mixed type scenarios', () {
        final handler = GenericValueHandler<dynamic>();
        expect(handler.toNormalized('test', 'start', 'end'), equals(0.5));
        expect(handler.formatValue('anything', null), equals('anything'));
      });
    });

    group('Performance and Memory', () {
      test('numeric handler efficiently handles large int ranges', () {
        final handler = NumericValueHandler<int>();
        final values = handler.getAllPossibleValues(0, 10000, null);
        expect(values.length, equals(10001));
        expect(values.first, equals(0));
        expect(values.last, equals(10000));
      });

      test('double handler does not enumerate large ranges', () {
        final handler = NumericValueHandler<double>();
        final values = handler.getAllPossibleValues(0.0, 10000.0, null);
        expect(values.length, equals(2)); // Only min and max
        expect(values, equals([0.0, 10000.0]));
      });

      test('enum handler filters values efficiently', () {
        final allValues = TestDifficulty.values;
        final handler = EnumValueHandler<TestDifficulty>(allValues);
        final values = handler.getAllPossibleValues(TestDifficulty.medium, TestDifficulty.hard, allValues);
        expect(values.length, equals(2));
        expect(values, equals([TestDifficulty.medium, TestDifficulty.hard]));
      });
    });

    group('Type Safety', () {
      test('numeric handler maintains type consistency', () {
        final intHandler = NumericValueHandler<int>();
        final doubleHandler = NumericValueHandler<double>();

        final intResult = intHandler.fromNormalized(0.5, 0, 100);
        final doubleResult = doubleHandler.fromNormalized(0.5, 0.0, 100.0);

        expect(intResult, isA<int>());
        expect(doubleResult, isA<double>());
      });

      test('enum handler maintains enum type consistency', () {
        final handler = EnumValueHandler<TestDifficulty>(TestDifficulty.values);
        final result = handler.fromNormalized(0.5, TestDifficulty.easy, TestDifficulty.expert);
        expect(result, isA<TestDifficulty>());
      });

      test('generic handler maintains type consistency for known types', () {
        final intHandler = GenericValueHandler<int>();
        final enumHandler = GenericValueHandler<TestDifficulty>(TestDifficulty.values);

        final intResult = intHandler.fromNormalized(0.5, 0, 100);
        final enumResult = enumHandler.fromNormalized(0.5, TestDifficulty.easy, TestDifficulty.expert);

        expect(intResult, isA<int>());
        expect(enumResult, isA<TestDifficulty>());
      });
    });

    group('Precision and Accuracy', () {
      test('maintains precision in double calculations', () {
        final handler = NumericValueHandler<double>();
        const double precision = 0.000001;

        expect(handler.toNormalized(33.333333, 0.0, 100.0), closeTo(0.33333333, precision));
        expect(handler.fromNormalized(0.33333333, 0.0, 100.0), closeTo(33.333333, precision));
      });

      test('rounds int values consistently', () {
        final handler = NumericValueHandler<int>();

        expect(handler.fromNormalized(0.499, 0, 100), equals(50));
        expect(handler.fromNormalized(0.501, 0, 100), equals(50));
        expect(handler.fromNormalized(0.994, 0, 100), equals(99));
        expect(handler.fromNormalized(0.996, 0, 100), equals(100));
      });

      test('enum handler provides consistent index mapping', () {
        final handler = EnumValueHandler<TestDifficulty>(TestDifficulty.values);

        // Test round-trip consistency
        for (final difficulty in TestDifficulty.values) {
          final normalized = handler.toNormalized(difficulty, TestDifficulty.easy, TestDifficulty.expert);
          final roundTrip = handler.fromNormalized(normalized, TestDifficulty.easy, TestDifficulty.expert);
          expect(roundTrip, equals(difficulty));
        }
      });
    });
  });
}
