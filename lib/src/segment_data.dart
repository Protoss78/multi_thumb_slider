/// Data model representing a slider segment with its value range and custom description
class SliderSegment<T extends num> {
  /// The start value of this segment (null for open-started segments)
  final T? startValue;

  /// The end value of this segment (null for open-ended segments)
  final T? endValue;

  /// Custom description for this segment (null means use default generated description)
  final String? customDescription;

  /// Whether this segment is open-ended (has no upper bound)
  final bool isOpenEnded;

  /// Whether this segment is open-started (has no lower bound)
  final bool isOpenStarted;

  /// Creates a slider segment
  const SliderSegment({
    this.startValue,
    this.endValue,
    this.customDescription,
    this.isOpenEnded = false,
    this.isOpenStarted = false,
  }) : assert(!isOpenEnded || endValue == null, 'Open-ended segments cannot have an end value'),
       assert(!isOpenStarted || startValue == null, 'Open-started segments cannot have a start value'),
       assert(!(isOpenEnded && isOpenStarted), 'Segments cannot be both open-ended and open-started');

  /// Creates a copy of this segment with updated values
  SliderSegment<T> copyWith({
    T? startValue,
    T? endValue,
    String? customDescription,
    bool? isOpenEnded,
    bool? isOpenStarted,
  }) {
    return SliderSegment<T>(
      startValue: startValue ?? this.startValue,
      endValue: endValue ?? this.endValue,
      customDescription: customDescription ?? this.customDescription,
      isOpenEnded: isOpenEnded ?? this.isOpenEnded,
      isOpenStarted: isOpenStarted ?? this.isOpenStarted,
    );
  }

  /// Returns the width/size of this segment
  /// For open-ended or open-started segments, returns null since width is infinite
  double? get width {
    if (isOpenEnded || isOpenStarted) return null;
    if (startValue == null || endValue == null) return null;
    return (endValue! - startValue!).toDouble();
  }

  /// Returns whether this segment has a custom description
  bool get hasCustomDescription => customDescription != null && customDescription!.trim().isNotEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SliderSegment<T> &&
        other.startValue == startValue &&
        other.endValue == endValue &&
        other.customDescription == customDescription &&
        other.isOpenEnded == isOpenEnded &&
        other.isOpenStarted == isOpenStarted;
  }

  @override
  int get hashCode => Object.hash(startValue, endValue, customDescription, isOpenEnded, isOpenStarted);

  @override
  String toString() =>
      'SliderSegment(startValue: $startValue, endValue: $endValue, customDescription: $customDescription, isOpenEnded: $isOpenEnded, isOpenStarted: $isOpenStarted)';
}

/// Data model for segment descriptions that can be managed separately
class SegmentDescription {
  /// Index of the segment this description applies to
  final int segmentIndex;

  /// Custom description text
  final String description;

  /// Creates a segment description
  const SegmentDescription({required this.segmentIndex, required this.description});

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
    return other is SegmentDescription && other.segmentIndex == segmentIndex && other.description == description;
  }

  @override
  int get hashCode => Object.hash(segmentIndex, description);

  @override
  String toString() => 'SegmentDescription(segmentIndex: $segmentIndex, description: $description)';
}
