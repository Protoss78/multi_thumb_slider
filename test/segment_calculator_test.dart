import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/src/segment_calculator.dart';
import 'package:multi_thumb_slider/src/constants.dart';

void main() {
  group('SegmentCalculator Tests', () {
    group('calculateSegmentWidths', () {
      test('handles empty values list', () {
        final widths = SegmentCalculator.calculateSegmentWidths<int>([], 0, 100);
        expect(widths, equals([1.0]));
      });

      test('calculates widths for single value correctly', () {
        final widths = SegmentCalculator.calculateSegmentWidths([50], 0, 100);

        expect(widths.length, equals(2));
        expect(widths[0], equals(0.5)); // 0 to 50
        expect(widths[1], equals(0.5)); // 50 to 100
      });

      test('calculates widths for multiple values correctly', () {
        final widths = SegmentCalculator.calculateSegmentWidths([25, 75], 0, 100);

        expect(widths.length, equals(3));
        expect(widths[0], equals(0.25)); // 0 to 25
        expect(widths[1], equals(0.5)); // 25 to 75
        expect(widths[2], equals(0.25)); // 75 to 100
      });

      test('handles unsorted values by sorting them', () {
        final widths = SegmentCalculator.calculateSegmentWidths([75, 25], 0, 100);

        expect(widths.length, equals(3));
        expect(widths[0], equals(0.25)); // 0 to 25 (sorted)
        expect(widths[1], equals(0.5)); // 25 to 75
        expect(widths[2], equals(0.25)); // 75 to 100
      });

      test('works with double values', () {
        final widths = SegmentCalculator.calculateSegmentWidths([25.5, 74.5], 0.0, 100.0);

        expect(widths.length, equals(3));
        expect(widths[0], equals(0.255)); // 0.0 to 25.5
        expect(widths[1], equals(0.49)); // 25.5 to 74.5
        expect(widths[2], equals(0.255)); // 74.5 to 100.0
      });

      test('handles negative ranges', () {
        final widths = SegmentCalculator.calculateSegmentWidths([-25, 25], -50, 50);

        expect(widths.length, equals(3));
        expect(widths[0], equals(0.25)); // -50 to -25
        expect(widths[1], equals(0.5)); // -25 to 25
        expect(widths[2], equals(0.25)); // 25 to 50
      });

      test('handles values at boundaries', () {
        final widths = SegmentCalculator.calculateSegmentWidths([0, 100], 0, 100);

        expect(widths.length, equals(3));
        expect(widths[0], equals(0.0)); // 0 to 0 (no width)
        expect(widths[1], equals(1.0)); // 0 to 100 (full width)
        expect(widths[2], equals(0.0)); // 100 to 100 (no width)
      });

      test('handles duplicate values', () {
        final widths = SegmentCalculator.calculateSegmentWidths([50, 50], 0, 100);

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
        final percentages = SegmentCalculator.calculateSegmentPercentages([25, 75], 0, 100);

        expect(percentages.length, equals(3));
        expect(percentages[0], equals(25.0)); // 25% of total
        expect(percentages[1], equals(50.0)); // 50% of total
        expect(percentages[2], equals(25.0)); // 25% of total
      });

      test('handles empty values list', () {
        final percentages = SegmentCalculator.calculateSegmentPercentages<int>([], 0, 100);
        expect(percentages, equals([100.0]));
      });

      test('works with double values', () {
        final percentages = SegmentCalculator.calculateSegmentPercentages([33.3], 0.0, 100.0);

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
        final labels = SegmentCalculator.createSegmentLabels([25, 75], 0, 100, formatter: (value) => '${value}%');

        expect(labels.length, equals(3));
        expect(labels[0], equals('0% - 25%'));
        expect(labels[1], equals('25% - 75%'));
        expect(labels[2], equals('75% - 100%'));
      });

      test('works with double values', () {
        final labels = SegmentCalculator.createSegmentLabels([25.5, 74.5], 0.0, 100.0);

        expect(labels.length, equals(3));
        expect(labels[0], equals('0.0 - 25.5'));
        expect(labels[1], equals('25.5 - 74.5'));
        expect(labels[2], equals('74.5 - 100.0'));
      });

      test('handles negative ranges', () {
        final labels = SegmentCalculator.createSegmentLabels([-25, 25], -50, 50);

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
          formatter: (value) => '${value}%',
        );
        expect(fromToLabels[0], equals('0% - 50%'));
        expect(fromToLabels[1], equals('50% - 100%'));
      });
    });

    group('Edge Cases and Error Conditions', () {
      test('handles very small differences', () {
        final widths = SegmentCalculator.calculateSegmentWidths([0.001], 0.0, 0.002);

        expect(widths.length, equals(2));
        expect(widths[0], equals(0.5)); // Should handle small numbers
        expect(widths[1], equals(0.5));
      });

      test('handles very large numbers', () {
        final widths = SegmentCalculator.calculateSegmentWidths([500000], 0, 1000000);

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
        final widths = SegmentCalculator.calculateSegmentWidths([50, 50, 50, 50], 0, 100);

        expect(widths.length, equals(5)); // 4 values + 1 creates 5 segments
        expect(widths[0], equals(0.5)); // 0 to 50
        expect(widths[1], equals(0.0)); // 50 to 50 (zero width)
        expect(widths[2], equals(0.0)); // 50 to 50 (zero width)
        expect(widths[3], equals(0.0)); // 50 to 50 (zero width)
        expect(widths[4], equals(0.5)); // 50 to 100
      });

      test('handles many closely spaced values', () {
        final widths = SegmentCalculator.calculateSegmentWidths([49, 50, 51], 0, 100);

        expect(widths.length, equals(4));
        expect(widths[0], equals(0.49)); // 0 to 49
        expect(widths[1], equals(0.01)); // 49 to 50
        expect(widths[2], equals(0.01)); // 50 to 51
        expect(widths[3], equals(0.49)); // 51 to 100
      });
    });
  });
}
