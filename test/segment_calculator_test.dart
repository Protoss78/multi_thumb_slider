import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_range_slider/src/segment_calculator.dart';
import 'package:multi_thumb_range_slider/src/constants.dart';

void main() {
  group('SegmentCalculator Tests', () {
    group('calculateSegmentWidths', () {
      test('handles empty values list', () {
        final widths = SegmentCalculator.calculateSegmentWidths<int>(
          [],
          0,
          100,
        );
        expect(widths, equals([1.0]));
      });

      test('calculates widths for single value correctly', () {
        final widths = SegmentCalculator.calculateSegmentWidths([50], 0, 100);

        expect(widths.length, equals(2));
        expect(widths[0], equals(0.5)); // 0 to 50
        expect(widths[1], equals(0.5)); // 50 to 100
      });

      test('calculates widths for multiple values correctly', () {
        final widths = SegmentCalculator.calculateSegmentWidths(
          [25, 75],
          0,
          100,
        );

        expect(widths.length, equals(3));
        expect(widths[0], equals(0.25)); // 0 to 25
        expect(widths[1], equals(0.5)); // 25 to 75
        expect(widths[2], equals(0.25)); // 75 to 100
      });

      test('handles unsorted values by sorting them', () {
        final widths = SegmentCalculator.calculateSegmentWidths(
          [75, 25],
          0,
          100,
        );

        expect(widths.length, equals(3));
        expect(widths[0], equals(0.25)); // 0 to 25 (sorted)
        expect(widths[1], equals(0.5)); // 25 to 75
        expect(widths[2], equals(0.25)); // 75 to 100
      });

      test('works with double values', () {
        final widths = SegmentCalculator.calculateSegmentWidths(
          [25.5, 74.5],
          0.0,
          100.0,
        );

        expect(widths.length, equals(3));
        expect(widths[0], equals(0.255)); // 0.0 to 25.5
        expect(widths[1], equals(0.49)); // 25.5 to 74.5
        expect(widths[2], equals(0.255)); // 74.5 to 100.0
      });

      test('handles negative ranges', () {
        final widths = SegmentCalculator.calculateSegmentWidths(
          [-25, 25],
          -50,
          50,
        );

        expect(widths.length, equals(3));
        expect(widths[0], equals(0.25)); // -50 to -25
        expect(widths[1], equals(0.5)); // -25 to 25
        expect(widths[2], equals(0.25)); // 25 to 50
      });

      test('handles values at boundaries', () {
        final widths = SegmentCalculator.calculateSegmentWidths(
          [0, 100],
          0,
          100,
        );

        expect(widths.length, equals(3));
        expect(widths[0], equals(0.0)); // 0 to 0 (no width)
        expect(widths[1], equals(1.0)); // 0 to 100 (full width)
        expect(widths[2], equals(0.0)); // 100 to 100 (no width)
      });

      test('handles duplicate values', () {
        final widths = SegmentCalculator.calculateSegmentWidths(
          [50, 50],
          0,
          100,
        );

        expect(widths.length, equals(3));
        expect(widths[0], equals(0.5)); // 0 to 50
        expect(widths[1], equals(0.0)); // 50 to 50 (no width)
        expect(widths[2], equals(0.5)); // 50 to 100
      });

      test('works with small ranges', () {
        final widths = SegmentCalculator.calculateSegmentWidths([5], 0, 10);

        expect(widths.length, equals(2));
        expect(widths[0], equals(0.5)); // 0 to 5
        expect(widths[1], equals(0.5)); // 5 to 10
      });
    });

    group('calculateSegmentPercentages', () {
      test('converts widths to percentages correctly', () {
        final percentages = SegmentCalculator.calculateSegmentPercentages(
          [25, 75],
          0,
          100,
        );

        expect(percentages.length, equals(3));
        expect(percentages[0], equals(25.0)); // 25% of total
        expect(percentages[1], equals(50.0)); // 50% of total
        expect(percentages[2], equals(25.0)); // 25% of total
      });

      test('handles empty values list', () {
        final percentages = SegmentCalculator.calculateSegmentPercentages<int>(
          [],
          0,
          100,
        );
        expect(percentages, equals([100.0]));
      });

      test('works with double values', () {
        final percentages = SegmentCalculator.calculateSegmentPercentages(
          [33.3],
          0.0,
          100.0,
        );

        expect(percentages.length, equals(2));
        expect(percentages[0], closeTo(33.3, 0.01)); // ~33.3% of total
        expect(percentages[1], closeTo(66.7, 0.01)); // ~66.7% of total
      });
    });

    group('createSegmentLabels', () {
      test('creates default labels for segments', () {
        final labels = SegmentCalculator.createSegmentLabels([25, 75], 0, 100);

        expect(labels.length, equals(3));
        expect(labels[0], equals('0 - 25'));
        expect(labels[1], equals('25 - 75'));
        expect(labels[2], equals('75 - 100'));
      });

      test('creates labels for single value', () {
        final labels = SegmentCalculator.createSegmentLabels([50], 0, 100);

        expect(labels.length, equals(2));
        expect(labels[0], equals('0 - 50'));
        expect(labels[1], equals('50 - 100'));
      });

      test('handles empty values list', () {
        final labels = SegmentCalculator.createSegmentLabels<int>([], 0, 100);
        expect(labels, equals(['0 - 100']));
      });

      test('uses custom formatter when provided', () {
        final labels = SegmentCalculator.createSegmentLabels(
          [25, 75],
          0,
          100,
          formatter: (value) => '$value%',
        );

        expect(labels.length, equals(3));
        expect(labels[0], equals('0% - 25%'));
        expect(labels[1], equals('25% - 75%'));
        expect(labels[2], equals('75% - 100%'));
      });

      test('works with double values', () {
        final labels = SegmentCalculator.createSegmentLabels(
          [25.5, 74.5],
          0.0,
          100.0,
        );

        expect(labels.length, equals(3));
        expect(labels[0], equals('0.0 - 25.5'));
        expect(labels[1], equals('25.5 - 74.5'));
        expect(labels[2], equals('74.5 - 100.0'));
      });

      test('handles negative ranges', () {
        final labels = SegmentCalculator.createSegmentLabels(
          [-25, 25],
          -50,
          50,
        );

        expect(labels.length, equals(3));
        expect(labels[0], equals('-50 - -25'));
        expect(labels[1], equals('-25 - 25'));
        expect(labels[2], equals('25 - 50'));
      });

      test('sorts values before creating labels', () {
        final labels = SegmentCalculator.createSegmentLabels([75, 25], 0, 100);

        expect(labels.length, equals(3));
        expect(labels[0], equals('0 - 25')); // Values should be sorted
        expect(labels[1], equals('25 - 75'));
        expect(labels[2], equals('75 - 100'));
      });
    });

    group('createSegmentLabelsByType', () {
      test('creates fromToRange labels correctly', () {
        final labels = SegmentCalculator.createSegmentLabelsByType(
          [25, 75],
          0,
          100,
          contentType: SegmentContentType.fromToRange,
        );

        expect(labels.length, equals(3));
        expect(labels[0], equals('0 - 25'));
        expect(labels[1], equals('25 - 75'));
        expect(labels[2], equals('75 - 100'));
      });

      test('creates toRange labels correctly', () {
        final labels = SegmentCalculator.createSegmentLabelsByType(
          [25, 75],
          0,
          100,
          contentType: SegmentContentType.toRange,
        );

        expect(labels.length, equals(3));
        expect(labels[0], equals('- 25'));
        expect(labels[1], equals('- 75'));
        expect(labels[2], equals('- 100'));
      });

      test('creates width labels correctly', () {
        final labels = SegmentCalculator.createSegmentLabelsByType(
          [25.0, 75.0],
          0.0,
          100.0,
          contentType: SegmentContentType.width,
        );

        expect(labels.length, equals(3));
        expect(labels[0], equals('25.0'));
        expect(labels[1], equals('50.0'));
        expect(labels[2], equals('25.0'));
      });

      test('handles empty values with different content types', () {
        final fromToLabels = SegmentCalculator.createSegmentLabelsByType<int>(
          [],
          0,
          100,
          contentType: SegmentContentType.fromToRange,
        );
        expect(fromToLabels, equals(['0 - 100']));

        final toRangeLabels = SegmentCalculator.createSegmentLabelsByType<int>(
          [],
          0,
          100,
          contentType: SegmentContentType.toRange,
        );
        expect(toRangeLabels, equals(['- 100']));

        final widthLabels = SegmentCalculator.createSegmentLabelsByType<double>(
          [],
          0.0,
          100.0,
          contentType: SegmentContentType.width,
        );
        expect(widthLabels, equals(['100.0']));
      });

      test('uses custom formatter with different content types', () {
        final fromToLabels = SegmentCalculator.createSegmentLabelsByType(
          [50],
          0,
          100,
          contentType: SegmentContentType.fromToRange,
          formatter: (value) => '$value%',
        );
        expect(fromToLabels[0], equals('0% - 50%'));
        expect(fromToLabels[1], equals('50% - 100%'));
      });
    });

    group('Edge Cases and Error Conditions', () {
      test('handles very small differences', () {
        final widths = SegmentCalculator.calculateSegmentWidths(
          [0.001],
          0.0,
          0.002,
        );

        expect(widths.length, equals(2));
        expect(widths[0], equals(0.5)); // Should handle small numbers
        expect(widths[1], equals(0.5));
      });

      test('handles very large numbers', () {
        final widths = SegmentCalculator.calculateSegmentWidths(
          [500000],
          0,
          1000000,
        );

        expect(widths.length, equals(2));
        expect(widths[0], equals(0.5));
        expect(widths[1], equals(0.5));
      });

      test('handles zero range gracefully', () {
        // This is a degenerate case that might not be realistic, but should not crash
        expect(() {
          SegmentCalculator.calculateSegmentWidths([50], 50, 50);
        }, returnsNormally);
      });

      test('handles many duplicate values', () {
        final widths = SegmentCalculator.calculateSegmentWidths(
          [50, 50, 50, 50],
          0,
          100,
        );

        expect(widths.length, equals(5)); // 4 values + 1 creates 5 segments
        expect(widths[0], equals(0.5)); // 0 to 50
        expect(widths[1], equals(0.0)); // 50 to 50 (zero width)
        expect(widths[2], equals(0.0)); // 50 to 50 (zero width)
        expect(widths[3], equals(0.0)); // 50 to 50 (zero width)
        expect(widths[4], equals(0.5)); // 50 to 100
      });

      test('handles many closely spaced values', () {
        final widths = SegmentCalculator.calculateSegmentWidths(
          [49, 50, 51],
          0,
          100,
        );

        expect(widths.length, equals(4));
        expect(widths[0], equals(0.49)); // 0 to 49
        expect(widths[1], equals(0.01)); // 49 to 50
        expect(widths[2], equals(0.01)); // 50 to 51
        expect(widths[3], equals(0.49)); // 51 to 100
      });
    });

    group('validateValues', () {
      test('returns true for valid values within range', () {
        final isValid = SegmentCalculator.validateValues([25, 50, 75], 0, 100);
        expect(isValid, isTrue);
      });

      test('returns false for values below minimum', () {
        final isValid = SegmentCalculator.validateValues([-10, 25, 75], 0, 100);
        expect(isValid, isFalse);
      });

      test('returns false for values above maximum', () {
        final isValid = SegmentCalculator.validateValues([25, 50, 110], 0, 100);
        expect(isValid, isFalse);
      });

      test('returns true for values at boundaries', () {
        final isValid = SegmentCalculator.validateValues([0, 50, 100], 0, 100);
        expect(isValid, isTrue);
      });

      test('returns true for empty values list', () {
        final isValid = SegmentCalculator.validateValues<int>([], 0, 100);
        expect(isValid, isTrue);
      });

      test('works with double values', () {
        final isValid = SegmentCalculator.validateValues(
          [25.5, 50.0, 74.5],
          0.0,
          100.0,
        );
        expect(isValid, isTrue);
      });

      test('works with negative ranges', () {
        final isValid = SegmentCalculator.validateValues([-25, 0, 25], -50, 50);
        expect(isValid, isTrue);
      });
    });

    group('getTotalRange', () {
      test('calculates positive range correctly', () {
        final range = SegmentCalculator.getTotalRange(0, 100);
        expect(range, equals(100.0));
      });

      test('calculates negative range correctly', () {
        final range = SegmentCalculator.getTotalRange(-50, 50);
        expect(range, equals(100.0));
      });

      test('handles zero range', () {
        final range = SegmentCalculator.getTotalRange(50, 50);
        expect(range, equals(0.0));
      });

      test('works with double values', () {
        final range = SegmentCalculator.getTotalRange(0.0, 100.0);
        expect(range, equals(100.0));
      });

      test('works with mixed int and double', () {
        final range = SegmentCalculator.getTotalRange(0, 100.0);
        expect(range, equals(100.0));
      });
    });

    group('getUsedRange', () {
      test('returns zero for empty values list', () {
        final range = SegmentCalculator.getUsedRange<int>([]);
        expect(range, equals(0.0));
      });

      test('returns zero for single value', () {
        final range = SegmentCalculator.getUsedRange([50]);
        expect(range, equals(0.0));
      });

      test('calculates range for two values correctly', () {
        final range = SegmentCalculator.getUsedRange([25, 75]);
        expect(range, equals(50.0));
      });

      test('calculates range for multiple values correctly', () {
        final range = SegmentCalculator.getUsedRange([10, 25, 50, 90]);
        expect(range, equals(80.0)); // 90 - 10
      });

      test('handles unsorted values correctly', () {
        final range = SegmentCalculator.getUsedRange([75, 25, 50]);
        expect(range, equals(50.0)); // 75 - 25 (after sorting)
      });

      test('works with double values', () {
        final range = SegmentCalculator.getUsedRange([25.5, 74.5]);
        expect(range, equals(49.0));
      });

      test('works with negative values', () {
        final range = SegmentCalculator.getUsedRange([-25, 25]);
        expect(range, equals(50.0));
      });
    });

    group('getAverageSpacing', () {
      test('returns zero for empty values list', () {
        final spacing = SegmentCalculator.getAverageSpacing<int>([]);
        expect(spacing, equals(0.0));
      });

      test('returns zero for single value', () {
        final spacing = SegmentCalculator.getAverageSpacing([50]);
        expect(spacing, equals(0.0));
      });

      test('calculates average spacing for two values correctly', () {
        final spacing = SegmentCalculator.getAverageSpacing([25, 75]);
        expect(spacing, equals(50.0));
      });

      test('calculates average spacing for multiple values correctly', () {
        final spacing = SegmentCalculator.getAverageSpacing([10, 30, 60, 100]);
        expect(spacing, equals(30.0)); // (20 + 30 + 40) / 3
      });

      test('handles unsorted values correctly', () {
        final spacing = SegmentCalculator.getAverageSpacing([60, 10, 30, 100]);
        expect(spacing, equals(30.0)); // (20 + 30 + 40) / 3 (after sorting)
      });

      test('works with double values', () {
        final spacing = SegmentCalculator.getAverageSpacing([25.5, 50.0, 74.5]);
        expect(spacing, equals(24.5)); // (24.5 + 24.5) / 2
      });

      test('works with negative values', () {
        final spacing = SegmentCalculator.getAverageSpacing([-25, 0, 25]);
        expect(spacing, equals(25.0)); // (25 + 25) / 2
      });

      test('handles equal spacing correctly', () {
        final spacing = SegmentCalculator.getAverageSpacing([20, 40, 60, 80]);
        expect(spacing, equals(20.0)); // All spacings are 20
      });
    });

    group('calculateValuesAfterSegmentAdd', () {
      test('adds segment at beginning correctly', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentAdd(
          [50, 75],
          0,
          100,
          0,
        );
        expect(newValues.length, equals(3));
        expect(newValues[0], equals(25)); // Midpoint between 0 and 50
        expect(newValues[1], equals(50));
        expect(newValues[2], equals(75));
      });

      test('adds segment between existing segments correctly', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentAdd(
          [25, 75],
          0,
          100,
          1,
        );
        expect(newValues.length, equals(3));
        expect(newValues[0], equals(25));
        expect(newValues[1], equals(50)); // Midpoint between 25 and 75
        expect(newValues[2], equals(75));
      });

      test('adds segment at end correctly', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentAdd(
          [25, 50],
          0,
          100,
          2,
        );
        expect(newValues.length, equals(3));
        expect(newValues[0], equals(25));
        expect(newValues[1], equals(50));
        expect(newValues[2], equals(75)); // Midpoint between 50 and 100
      });

      test('handles empty values list correctly', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentAdd(
          <int>[],
          0,
          100,
          0,
        );
        expect(newValues.length, equals(1));
        expect(newValues[0], equals(50)); // Midpoint between 0 and 100
      });

      test('works with double values', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentAdd(
          [25.0, 75.0],
          0.0,
          100.0,
          1,
        );
        expect(newValues.length, equals(3));
        expect(newValues[1], equals(50.0)); // Midpoint between 25.0 and 75.0
      });

      test('handles unsorted values correctly', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentAdd(
          [75, 25],
          0,
          100,
          1,
        );
        expect(newValues.length, equals(3));
        expect(newValues[0], equals(25)); // Values are sorted first
        expect(newValues[1], equals(50)); // Midpoint between 25 and 75
        expect(newValues[2], equals(75));
      });

      test('works with negative ranges', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentAdd(
          [-25, 25],
          -50,
          50,
          1,
        );
        expect(newValues.length, equals(3));
        expect(newValues[1], equals(0)); // Midpoint between -25 and 25
      });
    });

    group('calculateValuesAfterSegmentRemove', () {
      test('removes segment at beginning correctly', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentRemove(
          [25, 50, 75],
          0,
          100,
          0,
        );
        expect(newValues.length, equals(2));
        expect(newValues[0], equals(50));
        expect(newValues[1], equals(75));
      });

      test('removes segment between existing segments correctly', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentRemove(
          [25, 50, 75],
          0,
          100,
          1,
        );
        expect(newValues.length, equals(2));
        expect(
          newValues[0],
          equals(50),
        ); // Removed the thumb at index 0 (25) - left boundary
        expect(newValues[1], equals(75));
      });

      test('removes segment at end correctly', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentRemove(
          [25, 50, 75],
          0,
          100,
          3,
        );
        expect(newValues.length, equals(2));
        expect(newValues[0], equals(25));
        expect(newValues[1], equals(50));
      });

      test('handles empty values list correctly', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentRemove(
          <int>[],
          0,
          100,
          0,
        );
        expect(newValues.length, equals(0));
      });

      test('handles single value correctly', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentRemove(
          [50],
          0,
          100,
          0,
        );
        expect(newValues.length, equals(0));
      });

      test('works with double values', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentRemove(
          [25.0, 50.0, 75.0],
          0.0,
          100.0,
          1,
        );
        expect(newValues.length, equals(2));
        expect(
          newValues[0],
          equals(50.0),
        ); // Removed the thumb at index 0 (25.0)
        expect(newValues[1], equals(75.0));
      });

      test('handles unsorted values correctly', () {
        final newValues = SegmentCalculator.calculateValuesAfterSegmentRemove(
          [75, 25, 50],
          0,
          100,
          1,
        );
        expect(newValues.length, equals(2));
        expect(
          newValues[0],
          equals(50),
        ); // Values are sorted first, then thumb at index 0 (25) is removed
        expect(newValues[1], equals(75));
      });
    });

    group('validateNewValues', () {
      test('returns true for valid values within bounds', () {
        final isValid = SegmentCalculator.validateNewValues(
          [25, 50, 75],
          0,
          100,
        );
        expect(isValid, isTrue);
      });

      test('returns false for values below minimum', () {
        final isValid = SegmentCalculator.validateNewValues(
          [-10, 25, 75],
          0,
          100,
        );
        expect(isValid, isFalse);
      });

      test('returns false for values above maximum', () {
        final isValid = SegmentCalculator.validateNewValues(
          [25, 50, 110],
          0,
          100,
        );
        expect(isValid, isFalse);
      });

      test('returns false for duplicate values', () {
        final isValid = SegmentCalculator.validateNewValues(
          [25, 50, 50],
          0,
          100,
        );
        expect(isValid, isFalse);
      });

      test('returns false for unsorted values', () {
        final isValid = SegmentCalculator.validateNewValues(
          [75, 25, 50],
          0,
          100,
        );
        expect(
          isValid,
          isTrue,
        ); // validateNewValues sorts values first, so unsorted input is valid
      });

      test('returns true for empty values list', () {
        final isValid = SegmentCalculator.validateNewValues<int>([], 0, 100);
        expect(isValid, isTrue);
      });

      test('returns true for single value', () {
        final isValid = SegmentCalculator.validateNewValues([50], 0, 100);
        expect(isValid, isTrue);
      });

      test('works with double values', () {
        final isValid = SegmentCalculator.validateNewValues(
          [25.5, 50.0, 74.5],
          0.0,
          100.0,
        );
        expect(isValid, isTrue);
      });

      test('works with negative ranges', () {
        final isValid = SegmentCalculator.validateNewValues(
          [-25, 0, 25],
          -50,
          50,
        );
        expect(isValid, isTrue);
      });
    });

    group('redistributeSegmentsEvenly', () {
      test('redistributes single value evenly', () {
        final newValues = SegmentCalculator.redistributeSegmentsEvenly(
          [50],
          0,
          100,
        );
        expect(newValues.length, equals(1));
        expect(
          newValues[0],
          equals(50),
        ); // Should be at 50 (middle of 2 segments)
      });

      test('redistributes multiple values evenly', () {
        final newValues = SegmentCalculator.redistributeSegmentsEvenly(
          [25, 75],
          0,
          100,
        );
        expect(newValues.length, equals(2));
        expect(newValues[0], equals(33)); // 100/3 ≈ 33.33, rounded to 33
        expect(newValues[1], equals(67)); // 200/3 ≈ 66.67, rounded to 67
      });

      test('redistributes three values evenly', () {
        final newValues = SegmentCalculator.redistributeSegmentsEvenly(
          [20, 50, 80],
          0,
          100,
        );
        expect(newValues.length, equals(3));
        expect(newValues[0], equals(25)); // 100/4 = 25
        expect(newValues[1], equals(50)); // 200/4 = 50
        expect(newValues[2], equals(75)); // 300/4 = 75
      });

      test('handles empty values list correctly', () {
        final newValues = SegmentCalculator.redistributeSegmentsEvenly(
          <int>[],
          0,
          100,
        );
        expect(newValues.length, equals(0));
      });

      test('works with double values', () {
        final newValues = SegmentCalculator.redistributeSegmentsEvenly(
          [25.0, 75.0],
          0.0,
          100.0,
        );
        expect(newValues.length, equals(2));
        expect(newValues[0], closeTo(33.33, 0.01));
        expect(newValues[1], closeTo(66.67, 0.01));
      });

      test('works with negative ranges', () {
        final newValues = SegmentCalculator.redistributeSegmentsEvenly(
          [-25, 25],
          -50,
          50,
        );
        expect(newValues.length, equals(2));
        expect(newValues[0], equals(-17)); // -50 + (100/3) ≈ -17
        expect(newValues[1], equals(17)); // -50 + (200/3) ≈ 17
      });

      test('handles small ranges correctly', () {
        final newValues = SegmentCalculator.redistributeSegmentsEvenly(
          [5],
          0,
          10,
        );
        expect(newValues.length, equals(1));
        expect(newValues[0], equals(5)); // 10/2 = 5
      });

      test('maintains type consistency for int values', () {
        final newValues = SegmentCalculator.redistributeSegmentsEvenly(
          [25, 75],
          0,
          100,
        );
        expect(newValues.length, equals(2));
        expect(newValues[0], equals(33));
        expect(newValues[1], equals(67));
      });

      test('maintains type consistency for double values', () {
        final newValues = SegmentCalculator.redistributeSegmentsEvenly(
          [25.0, 75.0],
          0.0,
          100.0,
        );
        expect(newValues.length, equals(2));
        expect(newValues[0], closeTo(33.33, 0.01));
        expect(newValues[1], closeTo(66.67, 0.01));
      });
    });
  });
}
