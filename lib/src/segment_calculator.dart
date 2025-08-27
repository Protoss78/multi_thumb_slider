import 'constants.dart';

/// Utility class for calculating segment widths and properties for sliders
class SegmentCalculator {
  /// Calculates the relative widths of segments created by slider values
  ///
  /// Takes a list of slider values and calculates the width of each segment
  /// between the minimum value, each slider thumb, and the maximum value.
  ///
  /// Returns a list of normalized widths (0.0 to 1.0) representing the
  /// relative size of each segment.
  static List<double> calculateSegmentWidths<T extends num>(
    List<T> values,
    T min,
    T max,
  ) {
    if (values.isEmpty) {
      return [1.0]; // Single segment if no values
    }

    // Sort values to ensure proper order
    final sortedValues = List<T>.from(values)..sort();

    final List<double> segmentWidths = [];
    final double totalRange = (max - min).toDouble();

    // First segment: from min to first value
    segmentWidths.add((sortedValues.first - min) / totalRange);

    // Middle segments: between consecutive values
    for (int i = 0; i < sortedValues.length - 1; i++) {
      final double width = (sortedValues[i + 1] - sortedValues[i]) / totalRange;
      segmentWidths.add(width);
    }

    // Last segment: from last value to max
    segmentWidths.add((max - sortedValues.last) / totalRange);

    return segmentWidths;
  }

  /// Calculates the percentage each segment represents
  static List<double> calculateSegmentPercentages<T extends num>(
    List<T> values,
    T min,
    T max,
  ) {
    final widths = calculateSegmentWidths(values, min, max);
    return widths.map((width) => width * 100.0).toList();
  }

  /// Creates descriptive labels for segments
  static List<String> createSegmentLabels<T extends num>(
    List<T> values,
    T min,
    T max, {
    String Function(T)? formatter,
  }) {
    if (values.isEmpty) {
      return [
        '${_formatValue(min, formatter)} - ${_formatValue(max, formatter)}',
      ];
    }

    final sortedValues = List<T>.from(values)..sort();
    final List<String> labels = [];

    // First segment label
    labels.add(
      '${_formatValue(min, formatter)} - ${_formatValue(sortedValues.first, formatter)}',
    );

    // Middle segment labels
    for (int i = 0; i < sortedValues.length - 1; i++) {
      labels.add(
        '${_formatValue(sortedValues[i], formatter)} - ${_formatValue(sortedValues[i + 1], formatter)}',
      );
    }

    // Last segment label
    labels.add(
      '${_formatValue(sortedValues.last, formatter)} - ${_formatValue(max, formatter)}',
    );

    return labels;
  }

  /// Creates segment labels based on content type
  static List<String> createSegmentLabelsByType<T extends num>(
    List<T> values,
    T min,
    T max, {
    required SegmentContentType contentType,
    String Function(T)? formatter,
  }) {
    if (values.isEmpty) {
      switch (contentType) {
        case SegmentContentType.fromToRange:
          return [
            '${_formatValue(min, formatter)} - ${_formatValue(max, formatter)}',
          ];
        case SegmentContentType.toRange:
          return ['- ${_formatValue(max, formatter)}'];
        case SegmentContentType.width:
          final width = (max - min).toDouble();
          return [_formatValue(width as T, formatter)];
      }
    }

    final sortedValues = List<T>.from(values)..sort();
    final List<String> labels = [];

    // First segment
    switch (contentType) {
      case SegmentContentType.fromToRange:
        labels.add(
          '${_formatValue(min, formatter)} - ${_formatValue(sortedValues.first, formatter)}',
        );
        break;
      case SegmentContentType.toRange:
        labels.add('- ${_formatValue(sortedValues.first, formatter)}');
        break;
      case SegmentContentType.width:
        final width = (sortedValues.first - min).toDouble();
        labels.add(_formatValue(width as T, formatter));
        break;
    }

    // Middle segments
    for (int i = 0; i < sortedValues.length - 1; i++) {
      switch (contentType) {
        case SegmentContentType.fromToRange:
          labels.add(
            '${_formatValue(sortedValues[i], formatter)} - ${_formatValue(sortedValues[i + 1], formatter)}',
          );
          break;
        case SegmentContentType.toRange:
          labels.add('- ${_formatValue(sortedValues[i + 1], formatter)}');
          break;
        case SegmentContentType.width:
          final width = (sortedValues[i + 1] - sortedValues[i]).toDouble();
          labels.add(_formatValue(width as T, formatter));
          break;
      }
    }

    // Last segment
    switch (contentType) {
      case SegmentContentType.fromToRange:
        labels.add(
          '${_formatValue(sortedValues.last, formatter)} - ${_formatValue(max, formatter)}',
        );
        break;
      case SegmentContentType.toRange:
        labels.add('- ${_formatValue(max, formatter)}');
        break;
      case SegmentContentType.width:
        final width = (max - sortedValues.last).toDouble();
        labels.add(_formatValue(width as T, formatter));
        break;
    }

    return labels;
  }

  /// Helper method to format values using provided formatter or default
  static String _formatValue<T>(T value, String Function(T)? formatter) {
    return formatter?.call(value) ?? value.toString();
  }

  /// Validates that slider values are within the min-max range
  static bool validateValues<T extends num>(List<T> values, T min, T max) {
    return values.every((value) => value >= min && value <= max);
  }

  /// Returns the total range covered by the slider
  static double getTotalRange<T extends num>(T min, T max) {
    return (max - min).toDouble();
  }

  /// Returns the range covered by the slider values (from min value to max value)
  static double getUsedRange<T extends num>(List<T> values) {
    if (values.isEmpty) return 0.0;

    final sortedValues = List<T>.from(values)..sort();
    return (sortedValues.last - sortedValues.first).toDouble();
  }

  /// Calculates the average spacing between values
  static double getAverageSpacing<T extends num>(List<T> values) {
    if (values.length < 2) return 0.0;

    final sortedValues = List<T>.from(values)..sort();
    double totalSpacing = 0.0;

    for (int i = 0; i < sortedValues.length - 1; i++) {
      totalSpacing += (sortedValues[i + 1] - sortedValues[i]).toDouble();
    }

    return totalSpacing / (sortedValues.length - 1);
  }

  /// Calculates new slider values when adding a segment at the specified index
  ///
  /// The segmentIndex represents where the new divider (thumb) should be inserted.
  /// For example:
  /// - segmentIndex 0: Insert before first segment
  /// - segmentIndex 1: Insert between first and second segment
  /// - segmentIndex N: Insert after last segment
  static List<T> calculateValuesAfterSegmentAdd<T extends num>(
    List<T> currentValues,
    T min,
    T max,
    int segmentIndex,
  ) {
    final sortedValues = List<T>.from(currentValues)..sort();
    final List<T> newValues = List.from(sortedValues);

    // Calculate the range boundaries for the segment where we want to add a divider
    T segmentStart;
    T segmentEnd;

    if (segmentIndex == 0) {
      // Adding before first segment: from min to first value
      segmentStart = min;
      segmentEnd = sortedValues.isNotEmpty ? sortedValues.first : max;
    } else if (segmentIndex >= sortedValues.length) {
      // Adding after last segment: from last value to max
      segmentStart = sortedValues.isNotEmpty ? sortedValues.last : min;
      segmentEnd = max;
    } else {
      // Adding between segments: from value[index-1] to value[index]
      segmentStart = sortedValues[segmentIndex - 1];
      segmentEnd = sortedValues[segmentIndex];
    }

    // Calculate the midpoint of the segment
    final double midpoint =
        (segmentStart.toDouble() + segmentEnd.toDouble()) / 2.0;
    final T newValue = _convertToType<T>(midpoint);

    // Insert the new value at the appropriate position
    if (segmentIndex == 0) {
      newValues.insert(0, newValue);
    } else if (segmentIndex >= sortedValues.length) {
      newValues.add(newValue);
    } else {
      newValues.insert(segmentIndex, newValue);
    }

    return newValues;
  }

  /// Calculates new slider values when removing a segment at the specified index
  ///
  /// The segmentIndex represents which segment to remove by removing one of its boundaries.
  /// If the segment has two boundaries (thumbs), removes the right boundary.
  /// If the segment only has one boundary, removes that boundary.
  static List<T> calculateValuesAfterSegmentRemove<T extends num>(
    List<T> currentValues,
    T min,
    T max,
    int segmentIndex,
  ) {
    if (currentValues.isEmpty) {
      return currentValues; // Cannot remove from empty list
    }

    final sortedValues = List<T>.from(currentValues)..sort();
    final List<T> newValues = List.from(sortedValues);

    // Determine which thumb to remove based on segment index
    if (segmentIndex == 0) {
      // Removing first segment: remove the first thumb (if exists)
      if (newValues.isNotEmpty) {
        newValues.removeAt(0);
      }
    } else if (segmentIndex >= sortedValues.length) {
      // Removing last segment: remove the last thumb (if exists)
      if (newValues.isNotEmpty) {
        newValues.removeLast();
      }
    } else {
      // Removing middle segment: remove the thumb at the specified index
      if (segmentIndex - 1 >= 0 && segmentIndex - 1 < newValues.length) {
        newValues.removeAt(segmentIndex - 1);
      }
    }

    return newValues;
  }

  /// Helper method to convert double values back to the appropriate type
  static T _convertToType<T extends num>(double value) {
    if (T == int) {
      return value.round() as T;
    } else if (T == double) {
      return value as T;
    } else {
      // For other numeric types, attempt to cast
      return value as T;
    }
  }

  /// Validates that the new values are within acceptable bounds and maintain order
  static bool validateNewValues<T extends num>(
    List<T> newValues,
    T min,
    T max,
  ) {
    if (newValues.isEmpty) return true;

    final sortedValues = List<T>.from(newValues)..sort();

    // Check all values are within bounds
    for (final value in sortedValues) {
      if (value < min || value > max) {
        return false;
      }
    }

    // Check that values are actually sorted (no duplicates at same position)
    for (int i = 0; i < sortedValues.length - 1; i++) {
      if (sortedValues[i] >= sortedValues[i + 1]) {
        return false;
      }
    }

    return true;
  }

  /// Calculates optimal thumb positions when redistributing segments evenly
  static List<T> redistributeSegmentsEvenly<T extends num>(
    List<T> currentValues,
    T min,
    T max,
  ) {
    if (currentValues.isEmpty) {
      return currentValues;
    }

    final int numSegments = currentValues.length + 1;
    final double totalRange = (max - min).toDouble();
    final double segmentSize = totalRange / numSegments;

    final List<T> newValues = [];
    for (int i = 1; i < numSegments; i++) {
      final double position = min.toDouble() + (segmentSize * i);
      newValues.add(_convertToType<T>(position));
    }

    return newValues;
  }
}
