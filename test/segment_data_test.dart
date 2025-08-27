import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_range_slider/multi_thumb_range_slider.dart';

void main() {
  group('SliderSegment', () {
    group('constructor', () {
      test('should create SliderSegment with required parameters', () {
        const segment = SliderSegment<int>(startValue: 10, endValue: 20);

        expect(segment.startValue, equals(10));
        expect(segment.endValue, equals(20));
        expect(segment.customDescription, isNull);
      });

      test('should create SliderSegment with custom description', () {
        const segment = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Custom segment');

        expect(segment.startValue, equals(10));
        expect(segment.endValue, equals(20));
        expect(segment.customDescription, equals('Custom segment'));
      });

      test('should work with double values', () {
        const segment = SliderSegment<double>(startValue: 10.5, endValue: 20.7, customDescription: 'Double segment');

        expect(segment.startValue, equals(10.5));
        expect(segment.endValue, equals(20.7));
        expect(segment.customDescription, equals('Double segment'));
      });
    });

    group('width getter', () {
      test('should calculate correct width for int values', () {
        const segment = SliderSegment<int>(startValue: 10, endValue: 30);

        expect(segment.width, equals(20.0));
      });

      test('should calculate correct width for double values', () {
        const segment = SliderSegment<double>(startValue: 10.5, endValue: 30.7);

        expect(segment.width, equals(20.2));
      });

      test('should handle zero width', () {
        const segment = SliderSegment<int>(startValue: 10, endValue: 10);

        expect(segment.width, equals(0.0));
      });

      test('should handle negative width', () {
        const segment = SliderSegment<int>(startValue: 30, endValue: 10);

        expect(segment.width, equals(-20.0));
      });
    });

    group('hasCustomDescription getter', () {
      test('should return false when customDescription is null', () {
        const segment = SliderSegment<int>(startValue: 10, endValue: 20);

        expect(segment.hasCustomDescription, isFalse);
      });

      test('should return false when customDescription is empty', () {
        const segment = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: '');

        expect(segment.hasCustomDescription, isFalse);
      });

      test('should return true when customDescription has content', () {
        const segment = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Custom description');

        expect(segment.hasCustomDescription, isTrue);
      });

      test('should return false when customDescription is only whitespace', () {
        const segment = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: '   ');

        expect(segment.hasCustomDescription, isFalse);
      });
    });

    group('copyWith', () {
      test('should copy segment with new startValue', () {
        const original = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Original');

        final copy = original.copyWith(startValue: 15);

        expect(copy.startValue, equals(15));
        expect(copy.endValue, equals(20));
        expect(copy.customDescription, equals('Original'));
        expect(copy, isNot(same(original)));
      });

      test('should copy segment with new endValue', () {
        const original = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Original');

        final copy = original.copyWith(endValue: 25);

        expect(copy.startValue, equals(10));
        expect(copy.endValue, equals(25));
        expect(copy.customDescription, equals('Original'));
      });

      test('should copy segment with new customDescription', () {
        const original = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Original');

        final copy = original.copyWith(customDescription: 'Updated');

        expect(copy.startValue, equals(10));
        expect(copy.endValue, equals(20));
        expect(copy.customDescription, equals('Updated'));
      });

      test('should copy segment with all new values', () {
        const original = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Original');

        final copy = original.copyWith(startValue: 5, endValue: 15, customDescription: 'Updated');

        expect(copy.startValue, equals(5));
        expect(copy.endValue, equals(15));
        expect(copy.customDescription, equals('Updated'));
      });

      test('should copy segment without changing anything when no parameters provided', () {
        const original = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Original');

        final copy = original.copyWith();

        expect(copy.startValue, equals(10));
        expect(copy.endValue, equals(20));
        expect(copy.customDescription, equals('Original'));
        expect(copy, isNot(same(original)));
      });
    });

    group('equality', () {
      test('should be equal when all properties match', () {
        const segment1 = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Test');

        const segment2 = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Test');

        expect(segment1, equals(segment2));
        expect(segment1.hashCode, equals(segment2.hashCode));
      });

      test('should not be equal when startValue differs', () {
        const segment1 = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Test');

        const segment2 = SliderSegment<int>(startValue: 15, endValue: 20, customDescription: 'Test');

        expect(segment1, isNot(equals(segment2)));
      });

      test('should not be equal when endValue differs', () {
        const segment1 = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Test');

        const segment2 = SliderSegment<int>(startValue: 10, endValue: 25, customDescription: 'Test');

        expect(segment1, isNot(equals(segment2)));
      });

      test('should not be equal when customDescription differs', () {
        const segment1 = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Test1');

        const segment2 = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Test2');

        expect(segment1, isNot(equals(segment2)));
      });

      test('should be equal when both customDescriptions are null', () {
        const segment1 = SliderSegment<int>(startValue: 10, endValue: 20);

        const segment2 = SliderSegment<int>(startValue: 10, endValue: 20);

        expect(segment1, equals(segment2));
      });

      test('should not be equal when comparing to different type', () {
        const segment = SliderSegment<int>(startValue: 10, endValue: 20);

        expect(segment, isNot(equals('not a segment')));
        expect(segment, isNot(equals(42)));
      });
    });

    group('toString', () {
      test('should return formatted string representation', () {
        const segment = SliderSegment<int>(startValue: 10, endValue: 20, customDescription: 'Test segment');

        final result = segment.toString();

        expect(result, contains('SliderSegment'));
        expect(result, contains('startValue: 10'));
        expect(result, contains('endValue: 20'));
        expect(result, contains('customDescription: Test segment'));
      });

      test('should handle null customDescription in toString', () {
        const segment = SliderSegment<int>(startValue: 10, endValue: 20);

        final result = segment.toString();

        expect(result, contains('SliderSegment'));
        expect(result, contains('startValue: 10'));
        expect(result, contains('endValue: 20'));
        expect(result, contains('customDescription: null'));
      });
    });
  });

  group('SegmentDescription', () {
    group('constructor', () {
      test('should create SegmentDescription with required parameters', () {
        const description = SegmentDescription(segmentIndex: 2, description: 'Test description');

        expect(description.segmentIndex, equals(2));
        expect(description.description, equals('Test description'));
      });

      test('should handle empty description', () {
        const description = SegmentDescription(segmentIndex: 0, description: '');

        expect(description.segmentIndex, equals(0));
        expect(description.description, equals(''));
      });

      test('should handle negative segment index', () {
        const description = SegmentDescription(segmentIndex: -1, description: 'Negative index');

        expect(description.segmentIndex, equals(-1));
        expect(description.description, equals('Negative index'));
      });
    });

    group('copyWith', () {
      test('should copy description with new segmentIndex', () {
        const original = SegmentDescription(segmentIndex: 1, description: 'Original description');

        final copy = original.copyWith(segmentIndex: 3);

        expect(copy.segmentIndex, equals(3));
        expect(copy.description, equals('Original description'));
        expect(copy, isNot(same(original)));
      });

      test('should copy description with new description text', () {
        const original = SegmentDescription(segmentIndex: 1, description: 'Original description');

        final copy = original.copyWith(description: 'Updated description');

        expect(copy.segmentIndex, equals(1));
        expect(copy.description, equals('Updated description'));
      });

      test('should copy description with both new values', () {
        const original = SegmentDescription(segmentIndex: 1, description: 'Original description');

        final copy = original.copyWith(segmentIndex: 5, description: 'Updated description');

        expect(copy.segmentIndex, equals(5));
        expect(copy.description, equals('Updated description'));
      });

      test('should copy description without changing anything when no parameters provided', () {
        const original = SegmentDescription(segmentIndex: 1, description: 'Original description');

        final copy = original.copyWith();

        expect(copy.segmentIndex, equals(1));
        expect(copy.description, equals('Original description'));
        expect(copy, isNot(same(original)));
      });
    });

    group('equality', () {
      test('should be equal when all properties match', () {
        const description1 = SegmentDescription(segmentIndex: 2, description: 'Test description');

        const description2 = SegmentDescription(segmentIndex: 2, description: 'Test description');

        expect(description1, equals(description2));
        expect(description1.hashCode, equals(description2.hashCode));
      });

      test('should not be equal when segmentIndex differs', () {
        const description1 = SegmentDescription(segmentIndex: 1, description: 'Test description');

        const description2 = SegmentDescription(segmentIndex: 2, description: 'Test description');

        expect(description1, isNot(equals(description2)));
      });

      test('should not be equal when description differs', () {
        const description1 = SegmentDescription(segmentIndex: 1, description: 'Description 1');

        const description2 = SegmentDescription(segmentIndex: 1, description: 'Description 2');

        expect(description1, isNot(equals(description2)));
      });

      test('should not be equal when comparing to different type', () {
        const description = SegmentDescription(segmentIndex: 1, description: 'Test');

        expect(description, isNot(equals('not a description')));
        expect(description, isNot(equals(42)));
      });
    });

    group('toString', () {
      test('should return formatted string representation', () {
        const description = SegmentDescription(segmentIndex: 3, description: 'Test description text');

        final result = description.toString();

        expect(result, contains('SegmentDescription'));
        expect(result, contains('segmentIndex: 3'));
        expect(result, contains('description: Test description text'));
      });

      test('should handle empty description in toString', () {
        const description = SegmentDescription(segmentIndex: 0, description: '');

        final result = description.toString();

        expect(result, contains('SegmentDescription'));
        expect(result, contains('segmentIndex: 0'));
        expect(result, contains('description: '));
      });
    });
  });
}
