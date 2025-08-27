/// Data model representing a slider segment with its value range and custom description
class SliderSegment<T extends num> {
  /// The start value of this segment
  final T startValue;

  /// The end value of this segment
  final T endValue;

  /// Custom description for this segment (null means use default generated description)
  final String? customDescription;

  /// Creates a slider segment
  const SliderSegment({
    required this.startValue,
    required this.endValue,
    this.customDescription,
  });

  /// Creates a copy of this segment with updated values
  SliderSegment<T> copyWith({
    T? startValue,
    T? endValue,
    String? customDescription,
  }) {
    return SliderSegment<T>(
      startValue: startValue ?? this.startValue,
      endValue: endValue ?? this.endValue,
      customDescription: customDescription ?? this.customDescription,
    );
  }

  /// Returns the width/size of this segment
  double get width => (endValue - startValue).toDouble();

  /// Returns whether this segment has a custom description
  bool get hasCustomDescription =>
      customDescription != null && customDescription!.trim().isNotEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SliderSegment<T> &&
        other.startValue == startValue &&
        other.endValue == endValue &&
        other.customDescription == customDescription;
  }

  @override
  int get hashCode => Object.hash(startValue, endValue, customDescription);

  @override
  String toString() =>
      'SliderSegment(startValue: $startValue, endValue: $endValue, customDescription: $customDescription)';
}

/// Data model for segment descriptions that can be managed separately
class SegmentDescription {
  /// Index of the segment this description applies to
  final int segmentIndex;

  /// Custom description text
  final String description;

  /// Creates a segment description
  const SegmentDescription({
    required this.segmentIndex,
    required this.description,
  });

  /// Creates a copy of this description with updated values
  SegmentDescription copyWith({int? segmentIndex, String? description}) {
    return SegmentDescription(
      segmentIndex: segmentIndex ?? this.segmentIndex,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SegmentDescription &&
        other.segmentIndex == segmentIndex &&
        other.description == description;
  }

  @override
  int get hashCode => Object.hash(segmentIndex, description);

  @override
  String toString() =>
      'SegmentDescription(segmentIndex: $segmentIndex, description: $description)';
}
