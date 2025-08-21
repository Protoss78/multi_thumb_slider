/// Utility class for calculating segment widths and properties for sliders
class SegmentCalculator {
  /// Calculates the relative widths of segments created by slider values
  ///
  /// Takes a list of slider values and calculates the width of each segment
  /// between the minimum value, each slider thumb, and the maximum value.
  ///
  /// Returns a list of normalized widths (0.0 to 1.0) representing the
  /// relative size of each segment.
  static List<double> calculateSegmentWidths<T extends num>(List<T> values, T min, T max) {
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
  static List<double> calculateSegmentPercentages<T extends num>(List<T> values, T min, T max) {
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
      return ['${_formatValue(min, formatter)} - ${_formatValue(max, formatter)}'];
    }

    final sortedValues = List<T>.from(values)..sort();
    final List<String> labels = [];

    // First segment label
    labels.add('${_formatValue(min, formatter)} - ${_formatValue(sortedValues.first, formatter)}');

    // Middle segment labels
    for (int i = 0; i < sortedValues.length - 1; i++) {
      labels.add('${_formatValue(sortedValues[i], formatter)} - ${_formatValue(sortedValues[i + 1], formatter)}');
    }

    // Last segment label
    labels.add('${_formatValue(sortedValues.last, formatter)} - ${_formatValue(max, formatter)}');

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
}
