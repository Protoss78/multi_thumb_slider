import 'package:flutter/material.dart';

/// A customizable multi-thumb slider widget that allows users to set multiple values
/// on a single slider track.
///
/// This widget provides a slider with multiple draggable thumbs that can be used
/// to define ranges, breakpoints, or multiple selection points. Each thumb can
/// be dragged independently while respecting the constraints of neighboring thumbs.
///
/// The slider supports generic value types. By default, it uses [int] values,
/// but you can specify [double], [enum], or any other comparable type.
///
/// Example usage:
/// ```dart
/// // With int values (default)
/// CustomMultiThumbSlider<int>(
///   values: [20, 50, 80],
///   min: 0,
///   max: 100,
///   onChanged: (newValues) {
///     print('New values: $newValues');
///   },
/// )
///
/// // With double values
/// CustomMultiThumbSlider<double>(
///   values: [20.5, 50.0, 80.7],
///   min: 0.0,
///   max: 100.0,
///   onChanged: (newValues) {
///     print('New values: $newValues');
///   },
/// )
///
/// // With enum values
/// CustomMultiThumbSlider<Difficulty>(
///   values: [Difficulty.easy, Difficulty.medium, Difficulty.hard],
///   min: Difficulty.easy,
///   max: Difficulty.expert,
///   onChanged: (newValues) {
///     print('New values: $newValues');
///   },
/// )
/// ```
class CustomMultiThumbSlider<T> extends StatefulWidget {
  /// The current values of the slider thumbs.
  ///
  /// This list must contain at least one value and all values must be within
  /// the [min] and [max] range.
  final List<T> values;

  /// The minimum value of the slider.
  final T min;

  /// The maximum value of the slider.
  final T max;

  /// Callback function called when any thumb value changes.
  ///
  /// The callback receives a new list of values with the updated thumb positions.
  final ValueChanged<List<T>> onChanged;

  /// The height of the slider track.
  final double height;

  /// The color of the slider track background.
  final Color trackColor;

  /// The colors for the range segments between thumbs.
  ///
  /// If there are more ranges than colors, the colors will cycle.
  final List<Color> rangeColors;

  /// The color of the thumb circles.
  final Color thumbColor;

  /// The radius of each thumb circle.
  final double thumbRadius;

  /// Whether the slider is in read-only mode.
  ///
  /// When true, thumbs cannot be dragged and the slider acts as a display-only widget.
  /// When false (default), thumbs can be dragged normally.
  final bool readOnly;

  /// All possible values for the slider (required for enum types)
  /// This parameter is mandatory when T is an enum type to provide
  /// all possible enum values for proper slider functionality
  final List<T>? allPossibleValues;

  /// Whether to display tickmarks for all possible values
  /// This option is only available for int and enum value types
  /// When true, small tickmarks will be shown on the track for each possible value
  final bool showTickmarks;

  /// The color of the tickmarks when showTickmarks is true
  final Color tickmarkColor;

  /// The size of the tickmarks (width and height)
  final double tickmarkSize;

  /// The interval for showing tickmarks
  /// Tickmarks are shown every N values (e.g., interval: 5 shows every 5th tickmark)
  /// Min and max values always show tickmarks regardless of interval
  final int tickmarkInterval;

  /// Whether to display labels on tickmarks
  /// When true, labels will be shown below tickmarks using the valueFormatter
  final bool showTickmarkLabels;

  /// The interval for showing tickmark labels
  /// Labels are shown every N tickmarks (e.g., interval: 5 shows labels every 5th tickmark)
  /// Min and max values always show labels regardless of interval
  final int tickmarkLabelInterval;

  /// The color of the tickmark labels
  final Color tickmarkLabelColor;

  /// The size of the tickmark label text
  final double tickmarkLabelSize;

  /// Whether to display tooltips when thumbs are being dragged
  /// When true, a tooltip will appear above the thumb showing the current value
  final bool showTooltip;

  /// The color of the tooltip background
  final Color tooltipColor;

  /// The color of the tooltip text
  final Color tooltipTextColor;

  /// The size of the tooltip text
  final double tooltipTextSize;

  /// Optional custom function to format both tooltip text and tickmark labels
  /// If provided, this function will be used instead of the default formatting
  /// The function receives the current value and should return the formatted string
  /// Used for both tooltips (when dragging thumbs) and tickmark labels (when enabled)
  final String Function(T value)? valueFormatter;

  /// Creates a multi-thumb slider.
  ///
  /// The [values] parameter must not be empty, and all values must be within
  /// the [min] and [max] range.
  const CustomMultiThumbSlider({
    super.key,
    required this.values,
    required this.onChanged,
    required this.min,
    required this.max,
    this.height = 45.0,
    this.trackColor = const Color(0xFFE0E0E0),
    this.rangeColors = const [Colors.greenAccent, Colors.blueAccent, Colors.orangeAccent, Colors.redAccent],
    this.thumbColor = Colors.white,
    this.thumbRadius = 14.0,
    this.readOnly = false,
    this.allPossibleValues,
    this.showTickmarks = false,
    this.tickmarkColor = Colors.grey,
    this.tickmarkSize = 8.0,
    this.tickmarkInterval = 1,
    this.showTickmarkLabels = false,
    this.tickmarkLabelInterval = 5,
    this.tickmarkLabelColor = Colors.grey,
    this.tickmarkLabelSize = 10.0,
    this.showTooltip = false,
    this.tooltipColor = Colors.black87,
    this.tooltipTextColor = Colors.white,
    this.tooltipTextSize = 12.0,
    this.valueFormatter,
  });

  /// Creates a multi-thumb slider with int values and default min/max range.
  ///
  /// This is a convenience constructor for the most common use case.
  /// Equivalent to `CustomMultiThumbSlider<int>(min: 0, max: 100, ...)`.
  static CustomMultiThumbSlider<int> withInt({
    Key? key,
    required List<int> values,
    required ValueChanged<List<int>> onChanged,
    int min = 0,
    int max = 100,
    double height = 45.0,
    Color trackColor = const Color(0xFFE0E0E0),
    List<Color> rangeColors = const [Colors.greenAccent, Colors.blueAccent, Colors.orangeAccent, Colors.redAccent],
    Color thumbColor = Colors.white,
    double thumbRadius = 14.0,
    bool readOnly = false,
    bool showTickmarks = false,
    Color tickmarkColor = Colors.grey,
    double tickmarkSize = 8.0,
    int tickmarkInterval = 1,
    bool showTickmarkLabels = false,
    int tickmarkLabelInterval = 5,
    Color tickmarkLabelColor = Colors.grey,
    double tickmarkLabelSize = 10.0,
    bool showTooltip = false,
    Color tooltipColor = Colors.black87,
    Color tooltipTextColor = Colors.white,
    double tooltipTextSize = 12.0,
    String Function(int value)? valueFormatter,
  }) {
    return CustomMultiThumbSlider<int>(
      key: key,
      values: values,
      onChanged: onChanged,
      min: min,
      max: max,
      height: height,
      trackColor: trackColor,
      rangeColors: rangeColors,
      thumbColor: thumbColor,
      thumbRadius: thumbRadius,
      readOnly: readOnly,
      showTickmarks: showTickmarks,
      tickmarkColor: tickmarkColor,
      tickmarkSize: tickmarkSize,
      tickmarkInterval: tickmarkInterval,
      showTickmarkLabels: showTickmarkLabels,
      tickmarkLabelInterval: tickmarkLabelInterval,
      tickmarkLabelColor: tickmarkLabelColor,
      tickmarkLabelSize: tickmarkLabelSize,
      showTooltip: showTooltip,
      tooltipColor: tooltipColor,
      tooltipTextColor: tooltipTextColor,
      tooltipTextSize: tooltipTextSize,
      valueFormatter: valueFormatter,
    );
  }

  /// Creates a multi-thumb slider with enum values.
  ///
  /// This is a convenience constructor for enum types that requires
  /// the allPossibleValues parameter to be passed explicitly.
  static CustomMultiThumbSlider<T> withEnum<T extends Enum>({
    Key? key,
    required List<T> values,
    required ValueChanged<List<T>> onChanged,
    required T min,
    required T max,
    required List<T> allPossibleValues,
    double height = 45.0,
    Color trackColor = const Color(0xFFE0E0E0),
    List<Color> rangeColors = const [Colors.greenAccent, Colors.blueAccent, Colors.orangeAccent, Colors.redAccent],
    Color thumbColor = Colors.white,
    double thumbRadius = 14.0,
    bool readOnly = false,
    bool showTickmarks = false,
    Color tickmarkColor = Colors.grey,
    double tickmarkSize = 8.0,
    int tickmarkInterval = 1,
    bool showTickmarkLabels = false,
    int tickmarkLabelInterval = 5,
    Color tickmarkLabelColor = Colors.grey,
    double tickmarkLabelSize = 10.0,
    bool showTooltip = false,
    Color tooltipColor = Colors.black87,
    Color tooltipTextColor = Colors.white,
    double tooltipTextSize = 12.0,
    String Function(T value)? valueFormatter,
  }) {
    return CustomMultiThumbSlider<T>(
      key: key,
      values: values,
      onChanged: onChanged,
      min: min,
      max: max,
      height: height,
      trackColor: trackColor,
      rangeColors: rangeColors,
      thumbColor: thumbColor,
      thumbRadius: thumbRadius,
      readOnly: readOnly,
      allPossibleValues: allPossibleValues,
      showTickmarks: showTickmarks,
      tickmarkColor: tickmarkColor,
      tickmarkSize: tickmarkSize,
      tickmarkInterval: tickmarkInterval,
      showTickmarkLabels: showTickmarkLabels,
      tickmarkLabelInterval: tickmarkLabelInterval,
      tickmarkLabelColor: tickmarkLabelColor,
      tickmarkLabelSize: tickmarkLabelSize,
      showTooltip: showTooltip,
      tooltipColor: tooltipColor,
      tooltipTextColor: tooltipTextColor,
      tooltipTextSize: tooltipTextSize,
      valueFormatter: valueFormatter,
    );
  }

  @override
  State<CustomMultiThumbSlider<T>> createState() => _CustomMultiThumbSliderState<T>();
}

class _CustomMultiThumbSliderState<T> extends State<CustomMultiThumbSlider<T>> {
  /// Index of the thumb currently being dragged.
  int? _draggedThumbIndex;

  /// Normalized positions of thumbs (values between 0.0 and 1.0).
  late List<double> _normalizedPositions;

  /// Global key for the slider container to get accurate positioning.
  final GlobalKey _sliderKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _validateParameters();
    _updateNormalizedPositions();
  }

  /// Validates the widget parameters.
  void _validateParameters() {
    assert(widget.values.isNotEmpty, 'values list cannot be empty');
    // Note: We can't easily validate min < max for generic types, so we'll skip that assertion
    // assert(widget.min < widget.max, 'min must be less than max');
    // assert(
    //   widget.values.every((v) => v >= widget.min && v <= widget.max),
    //   'all values must be within min and max range',
    // );
  }

  @override
  void didUpdateWidget(CustomMultiThumbSlider<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update normalized positions when values change externally
    if (widget.values != oldWidget.values) {
      _updateNormalizedPositions();
    }
  }

  /// Converts absolute values to normalized values (0.0-1.0) used for UI positioning.
  void _updateNormalizedPositions() {
    if (widget.min is num && widget.max is num) {
      // For numeric types, we can calculate normalized positions
      final num min = widget.min as num;
      final num max = widget.max as num;
      _normalizedPositions = widget.values.map((v) {
        final num value = v as num;
        return (value - min) / (max - min);
      }).toList();
    } else {
      // For non-numeric types like enums, calculate positions based on their order
      final Enum minEnum = widget.min as Enum;
      final Enum maxEnum = widget.max as Enum;

      final int minIndex = minEnum.index;
      final int maxIndex = maxEnum.index;
      _normalizedPositions = widget.values.map((v) {
        final Enum enumValue = v as Enum;
        final int index = enumValue.index;
        if (index == -1) return 0.5; // Fallback if value not found
        return (index - minIndex) / (maxIndex - minIndex);
      }).toList();
    }
  }

  /// Gets all possible values for non-numeric types (like enums).
  List<T> _getAllPossibleValues() {
    if (widget.min is Enum && widget.max is Enum) {
      // For enums, we need to create a list of all possible enum values
      // Since we can't easily get all enum values at runtime in Dart,
      // we'll use the enum indices to create a proper range
      final Enum minEnum = widget.min as Enum;
      final Enum maxEnum = widget.max as Enum;

      final int minIndex = minEnum.index;
      final int maxIndex = maxEnum.index;
      final int startIndex = minIndex < maxIndex ? minIndex : maxIndex;
      final int endIndex = minIndex < maxIndex ? maxIndex : minIndex;

      // For enums, we need to use the allPossibleValues parameter
      // since Dart doesn't provide generic access to enum values
      if (widget.allPossibleValues != null) {
        // Filter to only include values in the specified range
        final List<T> filteredValues = [];
        for (final value in widget.allPossibleValues!) {
          final Enum enumValue = value as Enum;
          if (enumValue.index >= startIndex && enumValue.index <= endIndex) {
            filteredValues.add(value);
          }
        }
        return filteredValues;
      } else {
        // Fallback: just return min and max if allPossibleValues not provided
        final List<T> fallbackValues = [];
        fallbackValues.add(minEnum as T);
        if (startIndex != endIndex) {
          fallbackValues.add(maxEnum as T);
        }
        return fallbackValues;
      }
    }
    // For other non-numeric types, just return min and max
    return [widget.min, widget.max];
  }

  /// Calculates the normalized position (0.0-1.0) from a global position.
  /// This method provides accurate positioning relative to the slider track.
  double _calculateNormalizedPosition(Offset globalPosition) {
    final RenderBox? renderBox = _sliderKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return 0.0;

    // Convert global position to local position relative to the slider
    final Offset localPosition = renderBox.globalToLocal(globalPosition);

    // Calculate normalized position (0.0 to 1.0)
    final double normalizedPosition = localPosition.dx / renderBox.size.width;

    // Clamp to valid range
    return normalizedPosition.clamp(0.0, 1.0);
  }

  /// Finds the index of the thumb closest to a given normalized position.
  int _findNearestThumbIndex(double normalizedPosition) {
    int nearestIndex = 0;
    double minDistance = double.infinity;

    for (int i = 0; i < _normalizedPositions.length; i++) {
      final double distance = (normalizedPosition - _normalizedPositions[i]).abs();
      if (distance < minDistance) {
        minDistance = distance;
        nearestIndex = i;
      }
    }

    return nearestIndex;
  }

  /// Moves a thumb to a specific normalized position while respecting boundaries.
  void _moveThumbToPosition(int thumbIndex, double targetPosition) {
    // Determine allowed boundaries from neighboring thumbs
    final double lowerBound = thumbIndex == 0 ? 0.0 : _normalizedPositions[thumbIndex - 1];
    final double upperBound = thumbIndex == _normalizedPositions.length - 1
        ? 1.0
        : _normalizedPositions[thumbIndex + 1];

    // Clamp the target position to valid boundaries
    final double clampedPosition = targetPosition.clamp(lowerBound, upperBound);

    // Create new list with updated values
    List<T> newValues = List.from(widget.values);
    final T newValue = _unnormalize(clampedPosition);

    // Only update if the value actually changed
    if (newValue != widget.values[thumbIndex]) {
      newValues[thumbIndex] = newValue;
      widget.onChanged(newValues);
    }
  }

  /// Converts a normalized position (0.0-1.0) back to an absolute value.
  T _unnormalize(double normalized) {
    if (widget.min is num && widget.max is num) {
      // For numeric types
      final num min = widget.min as num;
      final num max = widget.max as num;
      final double value = normalized * (max.toDouble() - min.toDouble()) + min.toDouble();

      // Convert back to the original type T
      if (T == int) {
        // For int types, round to nearest integer but ensure we don't jump too much
        // This helps with smooth dragging
        return value.round() as T;
      } else if (T == double) {
        return value as T;
      } else {
        // For other numeric types, try to convert appropriately
        return value as T;
      }
    } else if (widget.min is Enum && widget.max is Enum) {
      // For enums, work exactly like int sliders
      // Get all possible enum values and use the calculated index to select from the list
      final List<T> allEnumValues = _getAllPossibleValues();

      // Calculate the target index (0 to list.length-1)
      final int targetIndex = (normalized * (allEnumValues.length - 1)).round();

      // Clamp to valid range and return the selected enum value
      final int clampedIndex = targetIndex.clamp(0, allEnumValues.length - 1);
      return allEnumValues[clampedIndex];
    } else {
      // For other non-numeric types
      final List<T> allValues = _getAllPossibleValues();
      if (allValues.length == 1) return allValues[0];

      final int index = (normalized * (allValues.length - 1)).round();
      return allValues[index.clamp(0, allValues.length - 1)];
    }
  }

  /// Determines whether tickmarks should be shown based on the value type
  bool _shouldShowTickmarks() {
    final bool shouldShow = widget.min is int || widget.min is Enum;
    print(
      '_shouldShowTickmarks: $shouldShow, min type: ${widget.min.runtimeType}, showTickmarks: ${widget.showTickmarks}',
    );
    return shouldShow;
  }

  /// Handles clicks on tickmarks, moving the closest thumb to the clicked value
  void _onTickmarkClicked(int valueIndex) {
    T targetValue;

    if (widget.min is int && widget.max is int) {
      // For int types, the valueIndex is the actual int value
      final int min = widget.min as int;
      targetValue = valueIndex as T;
    } else if (widget.min is Enum && widget.max is Enum && widget.allPossibleValues != null) {
      // For enum types, valueIndex is the index in the allPossibleValues list
      final List<T> allValues = widget.allPossibleValues!;
      if (valueIndex >= 0 && valueIndex < allValues.length) {
        targetValue = allValues[valueIndex];
      } else {
        return; // Invalid index
      }
    } else {
      return; // Unsupported type
    }

    // Convert the target value to normalized position
    double normalizedPosition;
    if (widget.min is num && widget.max is num) {
      final num min = widget.min as num;
      final num max = widget.max as num;
      final num value = targetValue as num;
      normalizedPosition = (value - min) / (max - min);
    } else if (widget.min is Enum && widget.max is Enum) {
      final Enum minEnum = widget.min as Enum;
      final Enum maxEnum = widget.max as Enum;
      final Enum targetEnum = targetValue as Enum;
      final int minIndex = minEnum.index;
      final int maxIndex = maxEnum.index;
      final int targetIndex = targetEnum.index;
      normalizedPosition = (targetIndex - minIndex) / (maxIndex - minIndex);
    } else {
      return; // Unsupported type
    }

    // Find the closest thumb and move it to this position
    final int nearestThumbIndex = _findNearestThumbIndex(normalizedPosition);
    _moveThumbToPosition(nearestThumbIndex, normalizedPosition);
  }

  /// Handles clicks on tickmark labels, moving the closest thumb to the clicked value
  void _onTickmarkLabelClicked(T targetValue) {
    // Convert the target value to normalized position
    double normalizedPosition;
    if (widget.min is num && widget.max is num) {
      final num min = widget.min as num;
      final num max = widget.max as num;
      final num value = targetValue as num;
      normalizedPosition = (value - min) / (max - min);
    } else if (widget.min is Enum && widget.max is Enum) {
      final Enum minEnum = widget.min as Enum;
      final Enum maxEnum = widget.max as Enum;
      final Enum targetEnum = targetValue as Enum;
      final int minIndex = minEnum.index;
      final int maxIndex = maxEnum.index;
      final int targetIndex = targetEnum.index;
      normalizedPosition = (targetIndex - minIndex) / (maxIndex - minIndex);
    } else {
      return; // Unsupported type
    }

    // Find the closest thumb and move it to this position
    final int nearestThumbIndex = _findNearestThumbIndex(normalizedPosition);
    _moveThumbToPosition(nearestThumbIndex, normalizedPosition);
  }

  /// Builds tickmarks for all possible values
  List<Widget> _buildTickmarks(double totalWidth) {
    final List<Widget> tickmarks = [];

    print('_buildTickmarks called with totalWidth: $totalWidth');
    print('min type: ${widget.min.runtimeType}, max type: ${widget.max.runtimeType}');

    if (widget.min is int && widget.max is int) {
      // For int types, show tickmarks for each integer value
      final int min = widget.min as int;
      final int max = widget.max as int;

      print('Building int tickmarks from $min to $max');

      for (int i = min; i <= max; i++) {
        // Always show tickmarks for min and max values, and for values at the specified interval
        final bool shouldShowTickmark = i == min || i == max || (i % widget.tickmarkInterval == 0);

        if (shouldShowTickmark) {
          final double normalizedPosition = (i - min) / (max - min);
          double leftPosition;

          // Adjust positioning for edge tickmarks to connect with the track
          if (i == min) {
            // Min tickmark: position to connect with track's left edge (accounting for rounded corner)
            leftPosition = 2.0; // 2px from left edge to connect with track
          } else if (i == max) {
            // Max tickmark: position to connect with track's right edge (accounting for rounded corner)
            leftPosition = totalWidth - 4.0; // 4px from right edge to connect with track
          } else {
            // All other tickmarks: center the 2px wide line
            leftPosition = normalizedPosition * totalWidth - 1.0;
          }

          print('Int tickmark $i at position $leftPosition');

          tickmarks.add(
            Positioned(
              left: leftPosition,
              top:
                  widget.height / 2 +
                  4.0, // Position below the track (track is centered, so half height + half track height)
              child: GestureDetector(
                onTap: widget.readOnly
                    ? null
                    : () {
                        _onTickmarkClicked(i);
                      },
                child: Container(
                  width: 8.0, // Wider clickable area than visual width
                  height: widget.tickmarkSize + 4.0, // Taller clickable area
                  alignment: Alignment.center,
                  child: Container(
                    width: 2.0, // Thin vertical line (visual)
                    height: widget.tickmarkSize,
                    decoration: BoxDecoration(
                      color: widget.tickmarkColor,
                      borderRadius: BorderRadius.circular(1.0), // Slightly rounded corners
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    } else if (widget.min is Enum && widget.max is Enum && widget.allPossibleValues != null) {
      // For enum types, show tickmarks for each possible enum value
      final List<T> allValues = widget.allPossibleValues!;

      print('Building enum tickmarks for ${allValues.length} values');

      // Use the same logic as _updateNormalizedPositions for consistency
      final Enum minEnum = widget.min as Enum;
      final Enum maxEnum = widget.max as Enum;
      final int minIndex = minEnum.index;
      final int maxIndex = maxEnum.index;

      for (int i = 0; i < allValues.length; i++) {
        // Always show tickmarks for first and last enum values, and for values at the specified interval
        final bool shouldShowTickmark = i == 0 || i == allValues.length - 1 || (i % widget.tickmarkInterval == 0);

        if (shouldShowTickmark) {
          final Enum currentEnum = allValues[i] as Enum;
          final int currentIndex = currentEnum.index;

          // Calculate normalized position using the same logic as thumbs
          final double normalizedPosition = (currentIndex - minIndex) / (maxIndex - minIndex);
          double leftPosition;

          // Adjust positioning for edge tickmarks to connect with the track
          if (i == 0) {
            // First enum tickmark: position to connect with track's left edge
            leftPosition = 2.0; // 2px from left edge to connect with track
          } else if (i == allValues.length - 1) {
            // Last enum tickmark: position to connect with track's right edge
            leftPosition = totalWidth - 4.0; // 4px from right edge to connect with track
          } else {
            // All other tickmarks: center the 2px wide line
            leftPosition = normalizedPosition * totalWidth - 1.0;
          }

          print(
            'Enum tickmark $i (${currentEnum}) at index $currentIndex, normalized: $normalizedPosition, position: $leftPosition',
          );

          tickmarks.add(
            Positioned(
              left: leftPosition,
              top:
                  widget.height / 2 +
                  4.0, // Position below the track (track is centered, so half height + half track height)
              child: GestureDetector(
                onTap: widget.readOnly
                    ? null
                    : () {
                        _onTickmarkClicked(i);
                      },
                child: Container(
                  width: 8.0, // Wider clickable area than visual width
                  height: widget.tickmarkSize + 4.0, // Taller clickable area
                  alignment: Alignment.center,
                  child: Container(
                    width: 2.0, // Thin vertical line (visual)
                    height: widget.tickmarkSize,
                    decoration: BoxDecoration(
                      color: widget.tickmarkColor,
                      borderRadius: BorderRadius.circular(1.0), // Slightly rounded corners
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    print('Built ${tickmarks.length} tickmarks');
    return tickmarks;
  }

  /// Builds labels for tickmarks when enabled.
  List<Widget> _buildTickmarkLabels(double totalWidth) {
    if (!widget.showTickmarks || !widget.showTickmarkLabels || !_shouldShowTickmarks()) {
      return [];
    }

    final List<Widget> labels = [];

    if (widget.min is int && widget.max is int) {
      // For int types, show labels for each integer value at the specified interval
      final int min = widget.min as int;
      final int max = widget.max as int;

      for (int i = min; i <= max; i++) {
        // Always show labels for min and max values, and for values at the specified interval
        final bool shouldShowLabel = i == min || i == max || (i % widget.tickmarkLabelInterval == 0);

        if (shouldShowLabel) {
          final double normalizedPosition = (i - min) / (max - min);
          double leftPosition;

          // Adjust positioning for edge labels to align with tickmarks
          if (i == min) {
            leftPosition = 2.0;
          } else if (i == max) {
            leftPosition = totalWidth - 4.0;
          } else {
            leftPosition = normalizedPosition * totalWidth - 1.0;
          }

          // Format the label text using the valueFormatter if provided
          String labelText;
          if (widget.valueFormatter != null) {
            labelText = widget.valueFormatter!(i as T);
          } else {
            labelText = i.toString();
          }

          labels.add(
            Positioned(
              left: leftPosition - 20, // Center the label over the tickmark
              top: widget.height / 2 + 8.0 + widget.tickmarkSize, // Position below the tickmark
              child: GestureDetector(
                onTap: widget.readOnly
                    ? null
                    : () {
                        _onTickmarkLabelClicked(i as T);
                      },
                child: SizedBox(
                  width: 40, // Fixed width for centering
                  child: Text(
                    labelText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.tickmarkLabelColor,
                      fontSize: widget.tickmarkLabelSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    } else if (widget.min is Enum && widget.max is Enum && widget.allPossibleValues != null) {
      // For enum types, show labels for each possible enum value at the specified interval
      final List<T> allValues = widget.allPossibleValues!;
      final Enum minEnum = widget.min as Enum;
      final Enum maxEnum = widget.max as Enum;
      final int minIndex = minEnum.index;
      final int maxIndex = maxEnum.index;

      for (int i = 0; i < allValues.length; i++) {
        final T value = allValues[i];

        // Always show labels for first and last enum values, and for values at the specified interval
        final bool shouldShowLabel = i == 0 || i == allValues.length - 1 || (i % widget.tickmarkLabelInterval == 0);

        if (shouldShowLabel) {
          final Enum currentEnum = value as Enum;
          final int currentIndex = currentEnum.index;
          final double normalizedPosition = (currentIndex - minIndex) / (maxIndex - minIndex);
          double leftPosition;

          // Adjust positioning for edge labels to align with tickmarks
          if (i == 0) {
            leftPosition = 2.0;
          } else if (i == allValues.length - 1) {
            leftPosition = totalWidth - 4.0;
          } else {
            leftPosition = normalizedPosition * totalWidth - 1.0;
          }

          // Format the label text using the valueFormatter if provided
          String labelText;
          if (widget.valueFormatter != null) {
            labelText = widget.valueFormatter!(value);
          } else if (value is Enum) {
            labelText = value.toString().split('.').last;
          } else {
            labelText = value.toString();
          }

          labels.add(
            Positioned(
              left: leftPosition - 20, // Center the label over the tickmark
              top: widget.height / 2 + 8.0 + widget.tickmarkSize, // Position below the tickmark
              child: GestureDetector(
                onTap: widget.readOnly
                    ? null
                    : () {
                        _onTickmarkLabelClicked(value);
                      },
                child: SizedBox(
                  width: 40, // Fixed width for centering
                  child: Text(
                    labelText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.tickmarkLabelColor,
                      fontSize: widget.tickmarkLabelSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    return labels;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;

        return GestureDetector(
          // Click-to-position functionality for the entire slider area
          onTapDown: widget.readOnly
              ? null
              : (details) {
                  // Find the nearest thumb to the tap position
                  final double tapPosition = _calculateNormalizedPosition(details.globalPosition);
                  final int nearestThumbIndex = _findNearestThumbIndex(tapPosition);

                  // Move the nearest thumb to the tap position
                  _moveThumbToPosition(nearestThumbIndex, tapPosition);
                },
          child: SizedBox(
            key: _sliderKey,
            height: widget.height,
            width: totalWidth,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none, // Allow tickmarks to extend beyond bounds
              children: [
                // Background track
                Container(
                  height: 8.0,
                  decoration: BoxDecoration(color: widget.trackColor, borderRadius: BorderRadius.circular(4.0)),
                ),

                // Colored range segments
                ..._buildRanges(totalWidth),

                // Tickmarks for all possible values (only for int and enum types)
                // Positioned after ranges so they appear above the track
                if (widget.showTickmarks && _shouldShowTickmarks()) ..._buildTickmarks(totalWidth),

                // Tickmark labels (only when enabled)
                if (widget.showTickmarks && widget.showTickmarkLabels && _shouldShowTickmarks())
                  ..._buildTickmarkLabels(totalWidth),

                // Draggable thumbs
                ..._buildThumbs(totalWidth),

                // Tooltips for dragged thumbs (on top of everything)
                ..._buildTooltips(totalWidth),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the list of colored containers for the range segments.
  List<Widget> _buildRanges(double totalWidth) {
    List<Widget> ranges = [];
    List<double> allPoints = [0.0, ..._normalizedPositions, 1.0];

    for (int i = 0; i < allPoints.length - 1; i++) {
      final double left = allPoints[i] * totalWidth;
      final double right = allPoints[i + 1] * totalWidth;
      final Color color = widget.rangeColors[i % widget.rangeColors.length];

      ranges.add(
        Positioned(
          left: left,
          child: Container(
            height: 8.0,
            width: right - left,
            decoration: BoxDecoration(
              color: color,
              // Rounded corners only at the start and end of the entire slider
              borderRadius: BorderRadius.horizontal(
                left: i == 0 ? const Radius.circular(4) : Radius.zero,
                right: i == allPoints.length - 2 ? const Radius.circular(4) : Radius.zero,
              ),
            ),
          ),
        ),
      );
    }
    return ranges;
  }

  /// Builds tooltips for thumbs that are currently being dragged.
  List<Widget> _buildTooltips(double totalWidth) {
    if (!widget.showTooltip || _draggedThumbIndex == null) {
      return [];
    }

    final int index = _draggedThumbIndex!;
    final double leftPosition = _normalizedPositions[index] * totalWidth - widget.thumbRadius;
    final T currentValue = widget.values[index];

    // Format the tooltip text using custom formatter if provided, otherwise use default formatting
    String tooltipText;
    if (widget.valueFormatter != null) {
      tooltipText = widget.valueFormatter!(currentValue);
    } else if (currentValue is num) {
      tooltipText = currentValue.toString();
    } else if (currentValue is Enum) {
      tooltipText = currentValue.toString().split('.').last;
    } else {
      tooltipText = currentValue.toString();
    }

    return [
      Positioned(
        left: leftPosition + widget.thumbRadius - 20, // Center tooltip over thumb
        top: -widget.height / 2 - 35, // Position above the thumb
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: widget.tooltipColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: const Offset(0, 2))],
          ),
          child: Text(
            tooltipText,
            style: TextStyle(
              color: widget.tooltipTextColor,
              fontSize: widget.tooltipTextSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ];
  }

  /// Builds the list of thumbs as overlapping widgets.
  List<Widget> _buildThumbs(double totalWidth) {
    return List.generate(_normalizedPositions.length, (index) {
      // Calculate the pixel position of the thumb
      // Subtract radius so the center of the circle lies on the track
      final double leftPosition = _normalizedPositions[index] * totalWidth - widget.thumbRadius;

      return Positioned(
        left: leftPosition,
        child: GestureDetector(
          // Start dragging (only if not read-only)
          onPanStart: widget.readOnly
              ? null
              : (details) {
                  setState(() {
                    _draggedThumbIndex = index;
                  });
                },
          // End dragging (only if not read-only)
          onPanEnd: widget.readOnly
              ? null
              : (details) {
                  setState(() {
                    _draggedThumbIndex = null;
                  });
                },
          // Main logic during dragging (only if not read-only)
          onPanUpdate: widget.readOnly
              ? null
              : (details) {
                  if (_draggedThumbIndex == index) {
                    // 1. Calculate the exact normalized position from global mouse position
                    final double newNormalizedPosition = _calculateNormalizedPosition(details.globalPosition);

                    // 2. Determine allowed boundaries from neighboring thumbs
                    final double lowerBound = index == 0 ? 0.0 : _normalizedPositions[index - 1];
                    final double upperBound = index == _normalizedPositions.length - 1
                        ? 1.0
                        : _normalizedPositions[index + 1];

                    // 3. Clamp the normalized position to valid boundaries
                    final double clampedNormalizedPosition = newNormalizedPosition.clamp(lowerBound, upperBound);

                    // 4. Create new list with updated values
                    List<T> newValues = List.from(widget.values);
                    final T newValue = _unnormalize(clampedNormalizedPosition);

                    // 5. Only update if the value actually changed (helps with smoothness for int types)
                    if (newValue != widget.values[index]) {
                      newValues[index] = newValue;

                      // 6. Call callback to update state in parent component
                      widget.onChanged(newValues);
                    }
                  }
                },
          // Visual element of the thumb
          child: _Thumb(
            radius: widget.thumbRadius,
            color: widget.thumbColor,
            isDragged: _draggedThumbIndex == index,
            isReadOnly: widget.readOnly,
          ),
        ),
      );
    });
  }
}

/// A separate, simple widget for the visual representation of a thumb.
class _Thumb extends StatelessWidget {
  final double radius;
  final Color color;
  final bool isDragged;
  final bool isReadOnly;

  const _Thumb({required this.radius, required this.color, required this.isDragged, required this.isReadOnly});

  @override
  Widget build(BuildContext context) {
    // Thumb is slightly enlarged when being dragged
    final double currentRadius = isDragged ? radius * 1.2 : radius;

    // Use muted colors and reduced opacity when in read-only mode
    final Color thumbColor = isReadOnly ? color.withValues(alpha: 0.6) : color;
    final Color borderColor = isReadOnly ? Colors.grey.shade300 : Colors.grey.shade400;
    final double borderWidth = isReadOnly ? 1.5 : 2.0;

    return Container(
      width: currentRadius * 2,
      height: currentRadius * 2,
      decoration: BoxDecoration(
        color: thumbColor,
        shape: BoxShape.circle,
        boxShadow: isReadOnly
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }
}
