import 'package:flutter/material.dart';
import 'constants.dart';
import 'value_type_handler.dart';
import 'position_calculator.dart';
import 'widgets/widgets.dart';

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
    this.height = SliderConstants.defaultHeight,
    this.trackColor = SliderConstants.defaultTrackColor,
    this.rangeColors = SliderConstants.defaultRangeColors,
    this.thumbColor = SliderConstants.defaultThumbColor,
    this.thumbRadius = SliderConstants.defaultThumbRadius,
    this.readOnly = false,
    this.allPossibleValues,
    this.showTickmarks = false,
    this.tickmarkColor = SliderConstants.defaultTickmarkColor,
    this.tickmarkSize = SliderConstants.defaultTickmarkSize,
    this.tickmarkInterval = SliderConstants.defaultTickmarkInterval,
    this.showTickmarkLabels = false,
    this.tickmarkLabelInterval = SliderConstants.defaultTickmarkLabelInterval,
    this.tickmarkLabelColor = SliderConstants.defaultTickmarkLabelColor,
    this.tickmarkLabelSize = SliderConstants.defaultTickmarkLabelSize,
    this.showTooltip = false,
    this.tooltipColor = SliderConstants.defaultTooltipColor,
    this.tooltipTextColor = SliderConstants.defaultTooltipTextColor,
    this.tooltipTextSize = SliderConstants.defaultTooltipTextSize,
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
    double height = SliderConstants.defaultHeight,
    Color trackColor = SliderConstants.defaultTrackColor,
    List<Color> rangeColors = SliderConstants.defaultRangeColors,
    Color thumbColor = SliderConstants.defaultThumbColor,
    double thumbRadius = SliderConstants.defaultThumbRadius,
    bool readOnly = false,
    bool showTickmarks = false,
    Color tickmarkColor = SliderConstants.defaultTickmarkColor,
    double tickmarkSize = SliderConstants.defaultTickmarkSize,
    int tickmarkInterval = SliderConstants.defaultTickmarkInterval,
    bool showTickmarkLabels = false,
    int tickmarkLabelInterval = SliderConstants.defaultTickmarkLabelInterval,
    Color tickmarkLabelColor = SliderConstants.defaultTickmarkLabelColor,
    double tickmarkLabelSize = SliderConstants.defaultTickmarkLabelSize,
    bool showTooltip = false,
    Color tooltipColor = SliderConstants.defaultTooltipColor,
    Color tooltipTextColor = SliderConstants.defaultTooltipTextColor,
    double tooltipTextSize = SliderConstants.defaultTooltipTextSize,
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
    double height = SliderConstants.defaultHeight,
    Color trackColor = SliderConstants.defaultTrackColor,
    List<Color> rangeColors = SliderConstants.defaultRangeColors,
    Color thumbColor = SliderConstants.defaultThumbColor,
    double thumbRadius = SliderConstants.defaultThumbRadius,
    bool readOnly = false,
    bool showTickmarks = false,
    Color tickmarkColor = SliderConstants.defaultTickmarkColor,
    double tickmarkSize = SliderConstants.defaultTickmarkSize,
    int tickmarkInterval = SliderConstants.defaultTickmarkInterval,
    bool showTickmarkLabels = false,
    int tickmarkLabelInterval = SliderConstants.defaultTickmarkLabelInterval,
    Color tickmarkLabelColor = SliderConstants.defaultTickmarkLabelColor,
    double tickmarkLabelSize = SliderConstants.defaultTickmarkLabelSize,
    bool showTooltip = false,
    Color tooltipColor = SliderConstants.defaultTooltipColor,
    Color tooltipTextColor = SliderConstants.defaultTooltipTextColor,
    double tooltipTextSize = SliderConstants.defaultTooltipTextSize,
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

  /// Value type handler for the current type T
  late final ValueTypeHandler<T> _valueHandler;

  /// Position calculator for handling positioning logic
  late final PositionCalculator _positionCalculator;

  @override
  void initState() {
    super.initState();
    _valueHandler = ValueTypeHandlerFactory.create<T>();
    _positionCalculator = PositionCalculator(_sliderKey);
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
    _normalizedPositions = widget.values.map((v) {
      return _valueHandler.toNormalized(v, widget.min, widget.max);
    }).toList();
  }

  /// Moves a thumb to a specific normalized position while respecting boundaries.
  void _moveThumbToPosition(int thumbIndex, double targetPosition) {
    // Determine allowed boundaries from neighboring thumbs
    final double lowerBound = _positionCalculator.calculateLowerBound(thumbIndex, _normalizedPositions);
    final double upperBound = _positionCalculator.calculateUpperBound(thumbIndex, _normalizedPositions);

    // Clamp the target position to valid boundaries
    final double clampedPosition = targetPosition.clamp(lowerBound, upperBound);

    // Create new list with updated values
    List<T> newValues = List.from(widget.values);
    final T newValue = _valueHandler.fromNormalized(clampedPosition, widget.min, widget.max);

    // Only update if the value actually changed
    if (newValue != widget.values[thumbIndex]) {
      newValues[thumbIndex] = newValue;
      widget.onChanged(newValues);
    }
  }

  /// Handles clicks on tickmarks, moving the closest thumb to the clicked value
  void _onTickmarkClicked(int valueIndex) {
    T targetValue;

    if (widget.min is int && widget.max is int) {
      // For int types, the valueIndex is the actual int value
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
    final double normalizedPosition = _valueHandler.toNormalized(targetValue, widget.min, widget.max);

    // Find the closest thumb and move it to this position
    final int nearestThumbIndex = _positionCalculator.findNearestThumbIndex(normalizedPosition, _normalizedPositions);
    _moveThumbToPosition(nearestThumbIndex, normalizedPosition);
  }

  /// Handles clicks on tickmark labels, moving the closest thumb to the clicked value
  void _onTickmarkLabelClicked(T targetValue) {
    // Convert the target value to normalized position
    final double normalizedPosition = _valueHandler.toNormalized(targetValue, widget.min, widget.max);

    // Find the closest thumb and move it to this position
    final int nearestThumbIndex = _positionCalculator.findNearestThumbIndex(normalizedPosition, _normalizedPositions);
    _moveThumbToPosition(nearestThumbIndex, normalizedPosition);
  }

  /// Builds tickmarks for all possible values
  List<Widget> _buildTickmarks(double totalWidth) {
    if (!widget.showTickmarks || !_valueHandler.shouldShowTickmarks()) {
      return [];
    }

    final List<Widget> tickmarks = [];
    final List<T> allPossibleValues = _valueHandler.getAllPossibleValues(
      widget.min,
      widget.max,
      widget.allPossibleValues,
    );

    for (int i = 0; i < allPossibleValues.length; i++) {
      // Always show tickmarks for first and last values, and for values at the specified interval
      final bool shouldShowTickmark = i == 0 || i == allPossibleValues.length - 1 || (i % widget.tickmarkInterval == 0);

      if (shouldShowTickmark) {
        final T value = allPossibleValues[i];
        final double normalizedPosition = _valueHandler.toNormalized(value, widget.min, widget.max);
        double leftPosition;

        // Adjust positioning for edge tickmarks to connect with the track
        if (i == 0) {
          leftPosition = 2.0;
        } else if (i == allPossibleValues.length - 1) {
          leftPosition = totalWidth - 4.0;
        } else {
          leftPosition = normalizedPosition * totalWidth - 1.0;
        }

        tickmarks.add(
          TickmarkWidget(
            position: leftPosition,
            size: widget.tickmarkSize,
            color: widget.tickmarkColor,
            onTap: () => _onTickmarkClicked(i),
            isReadOnly: widget.readOnly,
          ),
        );
      }
    }

    return tickmarks;
  }

  /// Builds labels for tickmarks when enabled.
  List<Widget> _buildTickmarkLabels(double totalWidth) {
    if (!widget.showTickmarks || !widget.showTickmarkLabels || !_valueHandler.shouldShowTickmarks()) {
      return [];
    }

    final List<Widget> labels = [];
    final List<T> allPossibleValues = _valueHandler.getAllPossibleValues(
      widget.min,
      widget.max,
      widget.allPossibleValues,
    );

    for (int i = 0; i < allPossibleValues.length; i++) {
      final T value = allPossibleValues[i];

      // Always show labels for first and last values, and for values at the specified interval
      final bool shouldShowLabel =
          i == 0 || i == allPossibleValues.length - 1 || (i % widget.tickmarkLabelInterval == 0);

      if (shouldShowLabel) {
        final double normalizedPosition = _valueHandler.toNormalized(value, widget.min, widget.max);
        double leftPosition;

        // Adjust positioning for edge labels to align with tickmarks
        if (i == 0) {
          leftPosition = 2.0;
        } else if (i == allPossibleValues.length - 1) {
          leftPosition = totalWidth - 4.0;
        } else {
          leftPosition = normalizedPosition * totalWidth - 1.0;
        }

        // Format the label text using the valueFormatter if provided
        final String labelText = _valueHandler.formatValue(value, widget.valueFormatter);

        labels.add(
          TickmarkLabelWidget(
            position: leftPosition,
            text: labelText,
            color: widget.tickmarkLabelColor,
            fontSize: widget.tickmarkLabelSize,
            onTap: () => _onTickmarkLabelClicked(value),
            isReadOnly: widget.readOnly,
          ),
        );
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
                  final double tapPosition = _positionCalculator.calculateNormalizedPosition(details.globalPosition);
                  final int nearestThumbIndex = _positionCalculator.findNearestThumbIndex(
                    tapPosition,
                    _normalizedPositions,
                  );

                  // Move the nearest thumb to the tap position
                  _moveThumbToPosition(nearestThumbIndex, tapPosition);
                },
          child: SizedBox(
            key: _sliderKey,
            height:
                widget.height +
                (widget.showTickmarks && widget.showTickmarkLabels
                    ? 35.0
                    : widget.showTickmarks
                    ? 15.0
                    : 0.0), // Increased height to accommodate tickmarks and labels below
            width: totalWidth,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none, // Allow tickmarks to extend beyond bounds
              children: [
                // Background track
                Container(
                  height: SliderConstants.defaultTrackHeight,
                  decoration: BoxDecoration(color: widget.trackColor, borderRadius: BorderRadius.circular(4.0)),
                ),

                // Colored range segments
                ..._buildRanges(totalWidth),

                // Draggable thumbs
                ..._buildThumbs(totalWidth),

                // Tickmarks for all possible values (only for int and enum types)
                // Positioned after thumbs so they appear below the track
                ..._buildTickmarks(totalWidth),

                // Tickmark labels (only when enabled)
                ..._buildTickmarkLabels(totalWidth),

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
        RangeSegmentWidget(
          left: left,
          width: right - left,
          color: color,
          isFirst: i == 0,
          isLast: i == allPoints.length - 2,
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
    final String tooltipText = _valueHandler.formatValue(currentValue, widget.valueFormatter);

    return [
      TooltipWidget(
        leftPosition: leftPosition + widget.thumbRadius - 20,
        text: tooltipText,
        backgroundColor: widget.tooltipColor,
        textColor: widget.tooltipTextColor,
        fontSize: widget.tooltipTextSize,
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
                    final double newNormalizedPosition = _positionCalculator.calculateNormalizedPosition(
                      details.globalPosition,
                    );

                    // 2. Determine allowed boundaries from neighboring thumbs
                    final double lowerBound = _positionCalculator.calculateLowerBound(index, _normalizedPositions);
                    final double upperBound = _positionCalculator.calculateUpperBound(index, _normalizedPositions);

                    // 3. Clamp the normalized position to valid boundaries
                    final double clampedNormalizedPosition = newNormalizedPosition.clamp(lowerBound, upperBound);

                    // 4. Create new list with updated values
                    List<T> newValues = List.from(widget.values);
                    final T newValue = _valueHandler.fromNormalized(clampedNormalizedPosition, widget.min, widget.max);

                    // 5. Only update if the value actually changed (helps with smoothness for int types)
                    if (newValue != widget.values[index]) {
                      newValues[index] = newValue;

                      // 6. Call callback to update state in parent component
                      widget.onChanged(newValues);
                    }
                  }
                },
          // Visual element of the thumb
          child: ThumbWidget(
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
