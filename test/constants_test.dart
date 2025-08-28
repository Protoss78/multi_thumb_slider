import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_range_slider/src/constants.dart';

void main() {
  group('SliderConstants Tests', () {
    group('Default Dimensions', () {
      test('has correct default height', () {
        expect(SliderConstants.defaultHeight, equals(45.0));
      });

      test('has correct default thumb radius', () {
        expect(SliderConstants.defaultThumbRadius, equals(14.0));
      });

      test('has correct default track height', () {
        expect(SliderConstants.defaultTrackHeight, equals(8.0));
      });

      test('has correct default tickmark size', () {
        expect(SliderConstants.defaultTickmarkSize, equals(8.0));
      });

      test('has correct default tickmark label size', () {
        expect(SliderConstants.defaultTickmarkLabelSize, equals(10.0));
      });

      test('has correct default tooltip text size', () {
        expect(SliderConstants.defaultTooltipTextSize, equals(12.0));
      });
    });

    group('Default Positioning', () {
      test('has correct default tickmark position', () {
        expect(
          SliderConstants.defaultTickmarkPosition,
          equals(TickmarkPosition.below),
        );
      });

      test('has correct default tickmark spacing', () {
        expect(SliderConstants.defaultTickmarkSpacing, equals(8.0));
      });

      test('has correct default label spacing', () {
        expect(SliderConstants.defaultLabelSpacing, equals(4.0));
      });
    });

    group('Default Intervals', () {
      test('has correct default tickmark interval', () {
        expect(SliderConstants.defaultTickmarkInterval, equals(1));
      });

      test('has correct default tickmark label interval', () {
        expect(SliderConstants.defaultTickmarkLabelInterval, equals(5));
      });
    });

    group('Default Colors', () {
      test('has correct default track color', () {
        expect(
          SliderConstants.defaultTrackColor,
          equals(const Color(0xFFE0E0E0)),
        );
      });

      test('has correct default thumb color', () {
        expect(SliderConstants.defaultThumbColor, equals(Colors.white));
      });

      test('has correct default tickmark color', () {
        expect(SliderConstants.defaultTickmarkColor, equals(Colors.grey));
      });

      test('has correct default tickmark label color', () {
        expect(SliderConstants.defaultTickmarkLabelColor, equals(Colors.grey));
      });

      test('has correct default tooltip color', () {
        expect(SliderConstants.defaultTooltipColor, equals(Colors.black87));
      });

      test('has correct default tooltip text color', () {
        expect(SliderConstants.defaultTooltipTextColor, equals(Colors.white));
      });
    });

    group('Default Range Colors', () {
      test('has correct default range colors list', () {
        const expectedColors = [
          Colors.greenAccent,
          Colors.blueAccent,
          Colors.orangeAccent,
          Colors.redAccent,
        ];

        expect(SliderConstants.defaultRangeColors, equals(expectedColors));
        expect(SliderConstants.defaultRangeColors.length, equals(4));
      });

      test('range colors contains expected color types', () {
        for (final color in SliderConstants.defaultRangeColors) {
          expect(color, isA<Color>());
        }
      });
    });

    group('Default Segment Display Dimensions', () {
      test('has correct default segment height', () {
        expect(SliderConstants.defaultSegmentHeight, equals(60.0));
      });

      test('has correct default segment card padding', () {
        expect(SliderConstants.defaultSegmentCardPadding, equals(8.0));
      });

      test('has correct default segment card margin', () {
        expect(SliderConstants.defaultSegmentCardMargin, equals(2.0));
      });

      test('has correct default segment card border radius', () {
        expect(SliderConstants.defaultSegmentCardBorderRadius, equals(8.0));
      });

      test('has correct default segment text size', () {
        expect(SliderConstants.defaultSegmentTextSize, equals(12.0));
      });
    });

    group('Default Segment Display Content Type', () {
      test('has correct default segment content type', () {
        expect(
          SliderConstants.defaultSegmentContentType,
          equals(SegmentContentType.fromToRange),
        );
      });
    });

    group('Default Segment Display Colors', () {
      test('has correct default segment background color', () {
        expect(
          SliderConstants.defaultSegmentBackgroundColor,
          equals(const Color(0xFFF5F5F5)),
        );
      });

      test('has correct default segment border color', () {
        expect(
          SliderConstants.defaultSegmentBorderColor,
          equals(const Color(0xFFE0E0E0)),
        );
      });

      test('has correct default segment text color', () {
        expect(
          SliderConstants.defaultSegmentTextColor,
          equals(const Color(0xFF424242)),
        );
      });

      test('has correct default segment card background color', () {
        expect(
          SliderConstants.defaultSegmentCardBackgroundColor,
          equals(const Color(0xFFF5F5F5)),
        );
      });

      test('has correct default segment card border color', () {
        expect(
          SliderConstants.defaultSegmentCardBorderColor,
          equals(const Color(0xFFE0E0E0)),
        );
      });
    });

    group('Default Segment Display Text Properties', () {
      test('has correct default segment text weight', () {
        expect(
          SliderConstants.defaultSegmentTextWeight,
          equals(FontWeight.normal),
        );
      });

      test('has correct default show segment borders', () {
        expect(SliderConstants.defaultShowSegmentBorders, equals(true));
      });

      test('has correct default show segment backgrounds', () {
        expect(SliderConstants.defaultShowSegmentBackgrounds, equals(true));
      });
    });

    group('Segment Edit Mode Constants', () {
      test('has correct default segment add button color', () {
        expect(
          SliderConstants.defaultSegmentAddButtonColor,
          equals(Colors.green),
        );
      });

      test('has correct default segment remove button color', () {
        expect(
          SliderConstants.defaultSegmentRemoveButtonColor,
          equals(Colors.red),
        );
      });

      test('has correct default segment button size', () {
        expect(SliderConstants.defaultSegmentButtonSize, equals(20.0));
      });
    });

    group('Enum Definitions', () {
      test('TickmarkPosition enum has all expected values', () {
        const expectedValues = [
          TickmarkPosition.above,
          TickmarkPosition.below,
          TickmarkPosition.onTrack,
        ];

        expect(TickmarkPosition.values, equals(expectedValues));
        expect(TickmarkPosition.values.length, equals(3));
      });

      test('SegmentContentType enum has all expected values', () {
        const expectedValues = [
          SegmentContentType.fromToRange,
          SegmentContentType.toRange,
          SegmentContentType.width,
        ];

        expect(SegmentContentType.values, equals(expectedValues));
        expect(SegmentContentType.values.length, equals(3));
      });
    });

    group('Value Types and Consistency', () {
      test('all dimension constants are positive numbers', () {
        expect(SliderConstants.defaultHeight, greaterThan(0));
        expect(SliderConstants.defaultThumbRadius, greaterThan(0));
        expect(SliderConstants.defaultTrackHeight, greaterThan(0));
        expect(SliderConstants.defaultTickmarkSize, greaterThan(0));
        expect(SliderConstants.defaultTickmarkLabelSize, greaterThan(0));
        expect(SliderConstants.defaultTooltipTextSize, greaterThan(0));
        expect(SliderConstants.defaultTickmarkSpacing, greaterThan(0));
        expect(SliderConstants.defaultLabelSpacing, greaterThan(0));
        expect(SliderConstants.defaultSegmentHeight, greaterThan(0));
        expect(SliderConstants.defaultSegmentCardPadding, greaterThan(0));
        expect(SliderConstants.defaultSegmentCardMargin, greaterThan(0));
        expect(SliderConstants.defaultSegmentCardBorderRadius, greaterThan(0));
        expect(SliderConstants.defaultSegmentTextSize, greaterThan(0));
        expect(SliderConstants.defaultSegmentButtonSize, greaterThan(0));
      });

      test('all interval constants are positive integers', () {
        expect(SliderConstants.defaultTickmarkInterval, greaterThan(0));
        expect(SliderConstants.defaultTickmarkLabelInterval, greaterThan(0));
        expect(SliderConstants.defaultTickmarkInterval, isA<int>());
        expect(SliderConstants.defaultTickmarkLabelInterval, isA<int>());
      });

      test('all color constants are Color objects', () {
        expect(SliderConstants.defaultTrackColor, isA<Color>());
        expect(SliderConstants.defaultThumbColor, isA<Color>());
        expect(SliderConstants.defaultTickmarkColor, isA<Color>());
        expect(SliderConstants.defaultTickmarkLabelColor, isA<Color>());
        expect(SliderConstants.defaultTooltipColor, isA<Color>());
        expect(SliderConstants.defaultTooltipTextColor, isA<Color>());
        expect(SliderConstants.defaultSegmentBackgroundColor, isA<Color>());
        expect(SliderConstants.defaultSegmentBorderColor, isA<Color>());
        expect(SliderConstants.defaultSegmentTextColor, isA<Color>());
        expect(SliderConstants.defaultSegmentCardBackgroundColor, isA<Color>());
        expect(SliderConstants.defaultSegmentCardBorderColor, isA<Color>());
        expect(SliderConstants.defaultSegmentAddButtonColor, isA<Color>());
        expect(SliderConstants.defaultSegmentRemoveButtonColor, isA<Color>());
      });

      test('boolean constants have correct types', () {
        expect(SliderConstants.defaultShowSegmentBorders, isA<bool>());
        expect(SliderConstants.defaultShowSegmentBackgrounds, isA<bool>());
      });

      test('enum constants have correct types', () {
        expect(
          SliderConstants.defaultTickmarkPosition,
          isA<TickmarkPosition>(),
        );
        expect(
          SliderConstants.defaultSegmentContentType,
          isA<SegmentContentType>(),
        );
        expect(SliderConstants.defaultSegmentTextWeight, isA<FontWeight>());
      });
    });

    group('Logical Consistency', () {
      test('thumb radius is reasonable compared to track height', () {
        // Thumb should be larger than track height for good UX
        expect(
          SliderConstants.defaultThumbRadius,
          greaterThan(SliderConstants.defaultTrackHeight / 2),
        );
      });

      test('tickmark size is reasonable compared to track height', () {
        // Tickmarks should be similar size to track height
        expect(
          SliderConstants.defaultTickmarkSize,
          lessThanOrEqualTo(SliderConstants.defaultTrackHeight * 2),
        );
      });

      test('text sizes are in reasonable range', () {
        // Text sizes should be reasonable for UI
        expect(
          SliderConstants.defaultTickmarkLabelSize,
          greaterThanOrEqualTo(8.0),
        );
        expect(
          SliderConstants.defaultTickmarkLabelSize,
          lessThanOrEqualTo(20.0),
        );
        expect(
          SliderConstants.defaultTooltipTextSize,
          greaterThanOrEqualTo(8.0),
        );
        expect(SliderConstants.defaultTooltipTextSize, lessThanOrEqualTo(20.0));
        expect(
          SliderConstants.defaultSegmentTextSize,
          greaterThanOrEqualTo(8.0),
        );
        expect(SliderConstants.defaultSegmentTextSize, lessThanOrEqualTo(20.0));
      });

      test('spacing values are reasonable', () {
        // Spacing should be positive but not too large
        expect(SliderConstants.defaultTickmarkSpacing, lessThanOrEqualTo(20.0));
        expect(SliderConstants.defaultLabelSpacing, lessThanOrEqualTo(20.0));
        expect(
          SliderConstants.defaultSegmentCardPadding,
          lessThanOrEqualTo(20.0),
        );
        expect(
          SliderConstants.defaultSegmentCardMargin,
          lessThanOrEqualTo(10.0),
        );
      });

      test('label interval is greater than or equal to tickmark interval', () {
        // Generally you want fewer labels than tickmarks
        expect(
          SliderConstants.defaultTickmarkLabelInterval,
          greaterThanOrEqualTo(SliderConstants.defaultTickmarkInterval),
        );
      });
    });
  });
}
