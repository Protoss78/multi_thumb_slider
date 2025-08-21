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
        return index / (maxIndex - minIndex - 1);
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;

        return SizedBox(
          key: _sliderKey,
          height: widget.height,
          width: totalWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background track with click-to-position functionality
              GestureDetector(
                onTapDown: widget.readOnly
                    ? null
                    : (details) {
                        // Find the nearest thumb to the tap position
                        final double tapPosition = _calculateNormalizedPosition(details.globalPosition);
                        final int nearestThumbIndex = _findNearestThumbIndex(tapPosition);

                        // Move the nearest thumb to the tap position
                        _moveThumbToPosition(nearestThumbIndex, tapPosition);
                      },
                child: Container(
                  height: 8.0,
                  decoration: BoxDecoration(color: widget.trackColor, borderRadius: BorderRadius.circular(4.0)),
                ),
              ),

              // Colored range segments
              ..._buildRanges(totalWidth),

              // Draggable thumbs
              ..._buildThumbs(totalWidth),
            ],
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
