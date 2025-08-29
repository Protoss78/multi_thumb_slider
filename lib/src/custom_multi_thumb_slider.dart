import 'package:flutter/material.dart';
import 'constants.dart';
import 'value_type_handler.dart';
import 'position_calculator.dart';
import 'segment_data.dart';
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
  final ValueChanged<List<T>>? onChanged;

  /// The height of the slider track.
  final double height;

  /// The height of the slider track bar (the actual track thickness).
  final double trackHeight;

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

  /// The position of tickmarks relative to the track
  /// When set to above, tickmarks appear above the track
  /// When set to below, tickmarks appear below the track
  /// When set to onTrack, tickmarks overlap with the track
  final TickmarkPosition tickmarkPosition;

  /// The spacing between the track and tickmarks
  /// This controls the distance between the track edge and the tickmark
  final double tickmarkSpacing;

  /// The spacing between tickmarks and their labels
  /// This controls the distance between a tickmark and its label
  final double labelSpacing;

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

  /// Whether to display segment information above the slider
  /// When true, a visual representation of segments will be shown
  final bool showSegments;

  /// The type of content to display in segment cards
  final SegmentContentType segmentContentType;

  /// The height of the segment display
  final double segmentHeight;

  /// The padding inside each segment card
  final double segmentCardPadding;

  /// The margin between segment cards
  final double segmentCardMargin;

  /// The border radius of segment cards
  final double segmentCardBorderRadius;

  /// The background color of segment cards
  final Color segmentCardBackgroundColor;

  /// The border color of segment cards
  final Color segmentCardBorderColor;

  /// The text color of segment content
  final Color segmentTextColor;

  /// The font size of segment text
  final double segmentTextSize;

  /// The font weight of segment text
  final FontWeight segmentTextWeight;

  /// Whether to show segment borders
  final bool showSegmentBorders;

  /// Whether to show segment backgrounds
  final bool showSegmentBackgrounds;

  /// Whether to enable segment edit mode
  /// When true, segment cards will display add/remove buttons for dynamic segment editing
  final bool enableSegmentEdit;

  /// Whether to enable segment description editing
  /// When true, segment cards will show edit indicators and allow description editing via dialog
  final bool enableDescriptionEdit;

  /// Callback function called when a new segment should be added
  /// The callback receives the index where the new segment should be inserted
  final void Function(int segmentIndex)? onSegmentAdd;

  /// Callback function called when a segment should be removed
  /// The callback receives the index of the segment to be removed
  final void Function(int segmentIndex)? onSegmentRemove;

  /// The color of the add segment button
  final Color segmentAddButtonColor;

  /// The color of the remove segment button
  final Color segmentRemoveButtonColor;

  /// The size of segment edit buttons
  final double segmentButtonSize;

  /// Callback function called when a segment description is changed
  /// The callback receives the segment index and the new custom description
  /// If the description is null, it means the segment should use the default description
  final void Function(int segmentIndex, String? customDescription)?
  onDescriptionChanged;

  /// Whether to enable open-ended segments
  /// When true, the last segment will be open-ended (no upper bound)
  /// and will be visually represented with an arrow pointing to the right
  final bool enableOpenEndedSegment;

  /// Whether to enable open-started segments
  /// When true, the first segment will be open-started (no lower bound)
  /// and will be visually represented with an arrow pointing to the left
  final bool enableOpenStartedSegment;

  /// Creates a multi-thumb slider.
  ///
  /// The [values] parameter must not be empty, and all values must be within
  /// the [min] and [max] range.
  CustomMultiThumbSlider({
    super.key,
    required this.values,
    this.onChanged,
    required this.min,
    required this.max,
    this.height = SliderConstants.defaultHeight,
    this.trackHeight = SliderConstants.defaultTrackHeight,
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
    this.tickmarkPosition = SliderConstants.defaultTickmarkPosition,
    this.tickmarkSpacing = SliderConstants.defaultTickmarkSpacing,
    this.labelSpacing = SliderConstants.defaultLabelSpacing,
    this.showTooltip = false,
    this.tooltipColor = SliderConstants.defaultTooltipColor,
    this.tooltipTextColor = SliderConstants.defaultTooltipTextColor,
    this.tooltipTextSize = SliderConstants.defaultTooltipTextSize,
    this.valueFormatter,
    this.showSegments = false,
    this.segmentContentType = SliderConstants.defaultSegmentContentType,
    this.segmentHeight = SliderConstants.defaultSegmentHeight,
    this.segmentCardPadding = SliderConstants.defaultSegmentCardPadding,
    this.segmentCardMargin = SliderConstants.defaultSegmentCardMargin,
    this.segmentCardBorderRadius =
        SliderConstants.defaultSegmentCardBorderRadius,
    this.segmentCardBackgroundColor =
        SliderConstants.defaultSegmentCardBackgroundColor,
    this.segmentCardBorderColor = SliderConstants.defaultSegmentCardBorderColor,
    this.segmentTextColor = SliderConstants.defaultSegmentTextColor,
    this.segmentTextSize = SliderConstants.defaultSegmentTextSize,
    this.segmentTextWeight = SliderConstants.defaultSegmentTextWeight,
    this.showSegmentBorders = SliderConstants.defaultShowSegmentBorders,
    this.showSegmentBackgrounds = SliderConstants.defaultShowSegmentBackgrounds,
    this.enableSegmentEdit = false,
    this.enableDescriptionEdit = false,
    this.onSegmentAdd,
    this.onSegmentRemove,
    this.segmentAddButtonColor = SliderConstants.defaultSegmentAddButtonColor,
    this.segmentRemoveButtonColor =
        SliderConstants.defaultSegmentRemoveButtonColor,
    this.segmentButtonSize = SliderConstants.defaultSegmentButtonSize,
    this.onDescriptionChanged,
    this.enableOpenEndedSegment = false,
    this.enableOpenStartedSegment = false,
  }) : _key = GlobalKey<_CustomMultiThumbSliderState<T>>();

  /// Creates a multi-thumb slider with int values and default min/max range.
  ///
  /// This is a convenience constructor for the most common use case.
  /// Equivalent to `CustomMultiThumbSlider<int>(min: 0, max: 100, ...)`.
  static CustomMultiThumbSlider<int> withInt({
    Key? key,
    required List<int> values,
    ValueChanged<List<int>>? onChanged,
    int min = 0,
    int max = 100,
    double height = SliderConstants.defaultHeight,
    double trackHeight = SliderConstants.defaultTrackHeight,
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
    TickmarkPosition tickmarkPosition = SliderConstants.defaultTickmarkPosition,
    double tickmarkSpacing = SliderConstants.defaultTickmarkSpacing,
    double labelSpacing = SliderConstants.defaultLabelSpacing,
    bool showTooltip = false,
    Color tooltipColor = SliderConstants.defaultTooltipColor,
    Color tooltipTextColor = SliderConstants.defaultTooltipTextColor,
    double tooltipTextSize = SliderConstants.defaultTooltipTextSize,
    String Function(int value)? valueFormatter,
    bool showSegments = false,
    SegmentContentType segmentContentType =
        SliderConstants.defaultSegmentContentType,
    double segmentHeight = SliderConstants.defaultSegmentHeight,
    double segmentCardPadding = SliderConstants.defaultSegmentCardPadding,
    double segmentCardMargin = SliderConstants.defaultSegmentCardMargin,
    double segmentCardBorderRadius =
        SliderConstants.defaultSegmentCardBorderRadius,
    Color segmentCardBackgroundColor =
        SliderConstants.defaultSegmentCardBackgroundColor,
    Color segmentCardBorderColor =
        SliderConstants.defaultSegmentCardBorderColor,
    Color segmentTextColor = SliderConstants.defaultSegmentTextColor,
    double segmentTextSize = SliderConstants.defaultSegmentTextSize,
    FontWeight segmentTextWeight = SliderConstants.defaultSegmentTextWeight,
    bool showSegmentBorders = SliderConstants.defaultShowSegmentBorders,
    bool showSegmentBackgrounds = SliderConstants.defaultShowSegmentBackgrounds,
    bool enableSegmentEdit = false,
    bool enableDescriptionEdit = false,
    void Function(int segmentIndex)? onSegmentAdd,
    void Function(int segmentIndex)? onSegmentRemove,
    Color segmentAddButtonColor = SliderConstants.defaultSegmentAddButtonColor,
    Color segmentRemoveButtonColor =
        SliderConstants.defaultSegmentRemoveButtonColor,
    double segmentButtonSize = SliderConstants.defaultSegmentButtonSize,
    void Function(int segmentIndex, String? customDescription)?
    onDescriptionChanged,
    bool enableOpenEndedSegment = false,
    bool enableOpenStartedSegment = false,
  }) {
    return CustomMultiThumbSlider<int>(
      key: key,
      values: values,
      onChanged: onChanged,
      min: min,
      max: max,
      height: height,
      trackHeight: trackHeight,
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
      tickmarkPosition: tickmarkPosition,
      tickmarkSpacing: tickmarkSpacing,
      labelSpacing: labelSpacing,
      showTooltip: showTooltip,
      tooltipColor: tooltipColor,
      tooltipTextColor: tooltipTextColor,
      tooltipTextSize: tooltipTextSize,
      valueFormatter: valueFormatter,
      showSegments: showSegments,
      segmentContentType: segmentContentType,
      segmentHeight: segmentHeight,
      segmentCardPadding: segmentCardPadding,
      segmentCardMargin: segmentCardMargin,
      segmentCardBorderRadius: segmentCardBorderRadius,
      segmentCardBackgroundColor: segmentCardBackgroundColor,
      segmentCardBorderColor: segmentCardBorderColor,
      segmentTextColor: segmentTextColor,
      segmentTextSize: segmentTextSize,
      segmentTextWeight: segmentTextWeight,
      showSegmentBorders: showSegmentBorders,
      showSegmentBackgrounds: showSegmentBackgrounds,
      enableSegmentEdit: enableSegmentEdit,
      enableDescriptionEdit: enableDescriptionEdit,
      onSegmentAdd: onSegmentAdd,
      onSegmentRemove: onSegmentRemove,
      segmentAddButtonColor: segmentAddButtonColor,
      segmentRemoveButtonColor: segmentRemoveButtonColor,
      segmentButtonSize: segmentButtonSize,
      onDescriptionChanged: onDescriptionChanged,
      enableOpenEndedSegment: enableOpenEndedSegment,
      enableOpenStartedSegment: enableOpenStartedSegment,
    );
  }

  /// Creates a multi-thumb slider with enum values.
  ///
  /// This is a convenience constructor for enum types that requires
  /// the allPossibleValues parameter to be passed explicitly.
  static CustomMultiThumbSlider<T> withEnum<T extends Enum>({
    Key? key,
    required List<T> values,
    ValueChanged<List<T>>? onChanged,
    required T min,
    required T max,
    required List<T> allPossibleValues,
    double height = SliderConstants.defaultHeight,
    double trackHeight = SliderConstants.defaultTrackHeight,
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
    TickmarkPosition tickmarkPosition = SliderConstants.defaultTickmarkPosition,
    double tickmarkSpacing = SliderConstants.defaultTickmarkSpacing,
    double labelSpacing = SliderConstants.defaultLabelSpacing,
    bool showTooltip = false,
    Color tooltipColor = SliderConstants.defaultTooltipColor,
    Color tooltipTextColor = SliderConstants.defaultTooltipTextColor,
    double tooltipTextSize = SliderConstants.defaultTooltipTextSize,
    String Function(T value)? valueFormatter,
    bool showSegments = false,
    SegmentContentType segmentContentType =
        SliderConstants.defaultSegmentContentType,
    double segmentHeight = SliderConstants.defaultSegmentHeight,
    double segmentCardPadding = SliderConstants.defaultSegmentCardPadding,
    double segmentCardMargin = SliderConstants.defaultSegmentCardMargin,
    double segmentCardBorderRadius =
        SliderConstants.defaultSegmentCardBorderRadius,
    Color segmentCardBackgroundColor =
        SliderConstants.defaultSegmentCardBackgroundColor,
    Color segmentCardBorderColor =
        SliderConstants.defaultSegmentCardBorderColor,
    Color segmentTextColor = SliderConstants.defaultSegmentTextColor,
    double segmentTextSize = SliderConstants.defaultSegmentTextSize,
    FontWeight segmentTextWeight = SliderConstants.defaultSegmentTextWeight,
    bool showSegmentBorders = SliderConstants.defaultShowSegmentBorders,
    bool showSegmentBackgrounds = SliderConstants.defaultShowSegmentBackgrounds,
    bool enableSegmentEdit = false,
    bool enableDescriptionEdit = false,
    void Function(int segmentIndex)? onSegmentAdd,
    void Function(int segmentIndex)? onSegmentRemove,
    Color segmentAddButtonColor = SliderConstants.defaultSegmentAddButtonColor,
    Color segmentRemoveButtonColor =
        SliderConstants.defaultSegmentRemoveButtonColor,
    double segmentButtonSize = SliderConstants.defaultSegmentButtonSize,
    void Function(int segmentIndex, String? customDescription)?
    onDescriptionChanged,
    bool enableOpenEndedSegment = false,
    bool enableOpenStartedSegment = false,
  }) {
    return CustomMultiThumbSlider<T>(
      key: key,
      values: values,
      onChanged: onChanged,
      min: min,
      max: max,
      height: height,
      trackHeight: trackHeight,
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
      tickmarkPosition: tickmarkPosition,
      tickmarkSpacing: tickmarkSpacing,
      labelSpacing: labelSpacing,
      showTooltip: showTooltip,
      tooltipColor: tooltipColor,
      tooltipTextColor: tooltipTextColor,
      tooltipTextSize: tooltipTextSize,
      valueFormatter: valueFormatter,
      showSegments: showSegments,
      segmentContentType: segmentContentType,
      segmentHeight: segmentHeight,
      segmentCardPadding: segmentCardPadding,
      segmentCardMargin: segmentCardMargin,
      segmentCardBorderRadius: segmentCardBorderRadius,
      segmentCardBackgroundColor: segmentCardBackgroundColor,
      segmentCardBorderColor: segmentCardBorderColor,
      segmentTextColor: segmentTextColor,
      segmentTextSize: segmentTextSize,
      segmentTextWeight: segmentTextWeight,
      showSegmentBorders: showSegmentBorders,
      showSegmentBackgrounds: showSegmentBackgrounds,
      enableSegmentEdit: enableSegmentEdit,
      enableDescriptionEdit: enableDescriptionEdit,
      onSegmentAdd: onSegmentAdd,
      onSegmentRemove: onSegmentRemove,
      segmentAddButtonColor: segmentAddButtonColor,
      segmentRemoveButtonColor: segmentRemoveButtonColor,
      segmentButtonSize: segmentButtonSize,
      onDescriptionChanged: onDescriptionChanged,
      enableOpenEndedSegment: enableOpenEndedSegment,
      enableOpenStartedSegment: enableOpenStartedSegment,
    );
  }

  /// Returns a list of SliderSegment objects containing both values and descriptions
  /// This method provides access to all segments with their calculated value ranges
  /// and any custom descriptions that have been set
  List<SliderSegment<num>> getSegmentsWithDescriptions() {
    if (min is! num || max is! num) {
      throw UnsupportedError(
        'getSegmentsWithDescriptions is only supported for numeric types',
      );
    }

    final state = _key.currentState;
    if (state == null) {
      // If widget not yet built, calculate segments directly
      return _calculateSegmentsDirectly();
    }

    return state._getSegmentsWithDescriptions();
  }

  /// Global key to access the state
  final GlobalKey<_CustomMultiThumbSliderState<T>> _key;

  /// Helper method to calculate segments when state is not available
  List<SliderSegment<num>> _calculateSegmentsDirectly() {
    if (values.isEmpty) {
      return [
        SliderSegment<num>(
          startValue: enableOpenStartedSegment ? null : min as num,
          endValue: enableOpenEndedSegment ? null : max as num,
          isOpenStarted: enableOpenStartedSegment,
          isOpenEnded: enableOpenEndedSegment,
        ),
      ];
    }

    final sortedValues = List<T>.from(values)..sort();
    final List<SliderSegment<num>> segments = [];

    // First segment: from min to first value (or open-started)
    segments.add(
      SliderSegment<num>(
        startValue: enableOpenStartedSegment ? null : min as num,
        endValue: sortedValues.first as num,
        isOpenStarted: enableOpenStartedSegment,
      ),
    );

    // Middle segments: between consecutive values
    for (int i = 0; i < sortedValues.length - 1; i++) {
      segments.add(
        SliderSegment<num>(
          startValue: sortedValues[i] as num,
          endValue: sortedValues[i + 1] as num,
        ),
      );
    }

    // Last segment: from last value to max (or open-ended)
    segments.add(
      SliderSegment<num>(
        startValue: sortedValues.last as num,
        endValue: enableOpenEndedSegment ? null : max as num,
        isOpenEnded: enableOpenEndedSegment,
      ),
    );

    return segments;
  }

  @override
  State<CustomMultiThumbSlider<T>> createState() =>
      _CustomMultiThumbSliderState<T>();
}

class _CustomMultiThumbSliderState<T> extends State<CustomMultiThumbSlider<T>> {
  /// Index of the thumb currently being dragged.
  int? _draggedThumbIndex;
  int? _touchedThumbIndex; // New: track which thumb is being touched

  /// Normalized positions of thumbs (values between 0.0 and 1.0).
  late List<double> _normalizedPositions;

  /// Global key for the slider container to get accurate positioning.
  final GlobalKey _sliderKey = GlobalKey();

  /// Value type handler for the current type T
  late final ValueTypeHandler<T> _valueHandler;

  /// Position calculator for handling positioning logic
  late final PositionCalculator _positionCalculator;

  /// Storage for custom segment descriptions
  /// Map of segment index to custom description
  final Map<int, String> _customSegmentDescriptions = {};

  @override
  void initState() {
    super.initState();
    // Use the context-aware factory for enum types to get proper handling
    _valueHandler = ValueTypeHandlerFactory.createWithContext<T>(
      allPossibleValues: widget.allPossibleValues,
    );
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
      // Only reset touch states when values change if there's no active drag operation
      // This prevents the drag from being interrupted when onChanged() triggers a widget update
      if (_draggedThumbIndex == null) {
        _touchedThumbIndex = null;
      }
    }
    // Update value handler if allPossibleValues changed (important for enum types)
    if (widget.allPossibleValues != oldWidget.allPossibleValues) {
      _valueHandler = ValueTypeHandlerFactory.createWithContext<T>(
        allPossibleValues: widget.allPossibleValues,
      );
      _updateNormalizedPositions();
    }
  }

  @override
  void dispose() {
    // Reset touch states
    _touchedThumbIndex = null;
    _draggedThumbIndex = null;
    super.dispose();
  }

  /// Converts absolute values to normalized values (0.0-1.0) used for UI positioning.
  void _updateNormalizedPositions() {
    _normalizedPositions = widget.values.map((v) {
      return _valueHandler.toNormalized(v, widget.min, widget.max);
    }).toList();
  }

  /// Calculates the total height needed for the slider based on tickmark positioning
  double _calculateSliderHeight() {
    if (!widget.showTickmarks) {
      return widget.height;
    }
    double additionalHeight = 0.0;

    switch (widget.tickmarkPosition) {
      case TickmarkPosition.above:
        // For above positioning, we need height for both tickmarks and labels above the track
        additionalHeight = widget.tickmarkSize + widget.tickmarkSpacing;

        if (widget.showTickmarkLabels) {
          final double labelHeight = 20.0;
          final double labelAdditionalHeight =
              labelHeight + widget.labelSpacing;
          additionalHeight += labelAdditionalHeight;
        }
        break;

      case TickmarkPosition.below:
        // For below positioning, we need height for both tickmarks and labels below the track
        additionalHeight = widget.tickmarkSize + widget.tickmarkSpacing;

        if (widget.showTickmarkLabels) {
          final double labelHeight = 20.0;
          final double labelAdditionalHeight =
              labelHeight + widget.labelSpacing;
          additionalHeight += labelAdditionalHeight;
        }
        break;

      case TickmarkPosition.onTrack:
        // On-track tickmarks don't add extra height, but labels might
        if (widget.showTickmarkLabels) {
          final double labelHeight = 20.0;
          final double labelAdditionalHeight =
              (widget.tickmarkSize / 2) + labelHeight + widget.labelSpacing;
          additionalHeight = labelAdditionalHeight;
        }
        break;
    }

    return widget.height + additionalHeight;
  }

  /// Moves a thumb to a specific normalized position while respecting boundaries.
  void _moveThumbToPosition(int thumbIndex, double targetPosition) {
    // Determine allowed boundaries from neighboring thumbs
    final double lowerBound = _positionCalculator.calculateLowerBound(
      thumbIndex,
      _normalizedPositions,
    );
    final double upperBound = _positionCalculator.calculateUpperBound(
      thumbIndex,
      _normalizedPositions,
    );

    // Clamp the target position to valid boundaries
    final double clampedPosition = targetPosition.clamp(lowerBound, upperBound);

    // Create new list with updated values
    List<T> newValues = List.from(widget.values);
    final T newValue = _valueHandler.fromNormalized(
      clampedPosition,
      widget.min,
      widget.max,
    );

    // Only update if the value actually changed
    if (newValue != widget.values[thumbIndex]) {
      newValues[thumbIndex] = newValue;
      widget.onChanged?.call(newValues);
    }
  }

  /// Handles clicks on tickmarks, moving the closest thumb to the clicked value
  void _onTickmarkClicked(int valueIndex) {
    T targetValue;

    if (widget.min is int && widget.max is int) {
      // For int types, the valueIndex is the actual int value
      targetValue = valueIndex as T;
    } else if (widget.min is Enum &&
        widget.max is Enum &&
        widget.allPossibleValues != null) {
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
    final double normalizedPosition = _valueHandler.toNormalized(
      targetValue,
      widget.min,
      widget.max,
    );

    // Find the closest thumb and move it to this position
    final int nearestThumbIndex = _positionCalculator.findNearestThumbIndex(
      normalizedPosition,
      _normalizedPositions,
    );
    _moveThumbToPosition(nearestThumbIndex, normalizedPosition);
  }

  /// Handles clicks on tickmark labels, moving the closest thumb to the clicked value
  void _onTickmarkLabelClicked(T targetValue) {
    // Convert the target value to normalized position
    final double normalizedPosition = _valueHandler.toNormalized(
      targetValue,
      widget.min,
      widget.max,
    );

    // Find the closest thumb and move it to this position
    final int nearestThumbIndex = _positionCalculator.findNearestThumbIndex(
      normalizedPosition,
      _normalizedPositions,
    );
    _moveThumbToPosition(nearestThumbIndex, normalizedPosition);
  }

  /// Builds tickmarks for all possible values
  List<Widget> _buildTickmarks(double totalWidth, double height) {
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
      final bool shouldShowTickmark =
          i == 0 ||
          i == allPossibleValues.length - 1 ||
          (i % widget.tickmarkInterval == 0);

      if (shouldShowTickmark) {
        final T value = allPossibleValues[i];
        final double normalizedPosition = _valueHandler.toNormalized(
          value,
          widget.min,
          widget.max,
        );
        double leftPosition;

        // Adjust positioning for edge tickmarks to connect with the track
        if (i == 0) {
          leftPosition = 0.0; // Align left edge with track start
        } else if (i == allPossibleValues.length - 1) {
          leftPosition =
              totalWidth -
              widget.tickmarkSize; // Align right edge with track end
        } else {
          // Center the tickmark on the track by subtracting half the tickmark width
          leftPosition =
              normalizedPosition * totalWidth - (widget.tickmarkSize / 2);
        }

        tickmarks.add(
          TickmarkWidget(
            leftPosition: leftPosition,
            availableHeight: height,
            trackHeight: widget.trackHeight,
            size: widget.tickmarkSize,
            color: widget.tickmarkColor,
            onTap: () => _onTickmarkClicked(i),
            isReadOnly: widget.readOnly,
            tickmarkPosition: widget.tickmarkPosition,
            spacing: widget.tickmarkSpacing,
          ),
        );
      }
    }

    return tickmarks;
  }

  /// Builds labels for tickmarks when enabled.
  List<Widget> _buildTickmarkLabels(double totalWidth, double availableHeight) {
    if (!widget.showTickmarks ||
        !widget.showTickmarkLabels ||
        !_valueHandler.shouldShowTickmarks()) {
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
          i == 0 ||
          i == allPossibleValues.length - 1 ||
          (i % widget.tickmarkLabelInterval == 0);

      if (shouldShowLabel) {
        final double normalizedPosition = _valueHandler.toNormalized(
          value,
          widget.min,
          widget.max,
        );
        double leftPosition;

        // Adjust positioning for edge labels to align with tickmarks
        if (i == 0) {
          leftPosition = 0.0; // Align left edge with track start
        } else if (i == allPossibleValues.length - 1) {
          leftPosition =
              totalWidth -
              widget.tickmarkSize; // Align right edge with track end
        } else {
          // Center the label on the track by subtracting half the tickmark width
          leftPosition =
              normalizedPosition * totalWidth - (widget.tickmarkSize / 2);
        }

        // Format the label text using the valueFormatter if provided
        final String labelText = _valueHandler.formatValue(
          value,
          widget.valueFormatter,
        );

        labels.add(
          TickmarkLabelWidget(
            availableHeight: availableHeight,
            trackHeight: widget.trackHeight,
            leftPosition: leftPosition,
            text: labelText,
            color: widget.tickmarkLabelColor,
            fontSize: widget.tickmarkLabelSize,
            onTap: () => _onTickmarkLabelClicked(value),
            isReadOnly: widget.readOnly,
            tickmarkPosition: widget.tickmarkPosition,
            tickmarkSize: widget.tickmarkSize,
            labelSpacing: widget.labelSpacing,
            tickmarkSpacing: widget.tickmarkSpacing,
          ),
        );
      }
    }

    return labels;
  }

  @override
  Widget build(BuildContext context) {
    double height = _calculateSliderHeight();

    // Build the main slider content
    Widget sliderContent = Container(
      key: widget._key,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double totalWidth = constraints.maxWidth;

          return GestureDetector(
            // Click-to-position functionality for the entire slider area
            onTapDown: widget.readOnly
                ? null
                : (details) {
                    // Hide tooltip when tapping outside thumbs
                    if (_touchedThumbIndex != null &&
                        _draggedThumbIndex == null) {
                      setState(() {
                        _touchedThumbIndex = null;
                      });
                    }

                    // Find the nearest thumb to the tap position
                    final double tapPosition = _positionCalculator
                        .calculateNormalizedPosition(details.globalPosition);
                    final int nearestThumbIndex = _positionCalculator
                        .findNearestThumbIndex(
                          tapPosition,
                          _normalizedPositions,
                        );

                    // Move the nearest thumb to the tap position
                    _moveThumbToPosition(nearestThumbIndex, tapPosition);
                  },
            child: SizedBox(
              key: _sliderKey,
              height: height,
              width: totalWidth,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior:
                    Clip.none, // Allow tickmarks to extend beyond bounds
                children: [
                  // Background track
                  Container(
                    height: widget.trackHeight,
                    decoration: BoxDecoration(
                      color: widget.trackColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),

                  // Colored range segments
                  ..._buildRanges(totalWidth),

                  // Draggable thumbs
                  ..._buildThumbs(totalWidth),

                  // Tickmarks for all possible values (only for int and enum types)
                  // Positioned after thumbs so they appear below the track
                  ..._buildTickmarks(totalWidth, height),

                  // Tickmark labels (only when enabled)
                  ..._buildTickmarkLabels(totalWidth, height),

                  // Tooltips for dragged thumbs (on top of everything)
                  ..._buildTooltips(totalWidth),
                ],
              ),
            ),
          );
        },
      ),
    );

    // If segments are enabled and T is a numeric type, wrap in a Column with segment display
    if (widget.showSegments && widget.min is num && widget.max is num) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Segment display widget (cast to num since we've checked the types)
          SegmentDisplayWidget<num>(
            values: widget.values.cast<num>(),
            min: widget.min as num,
            max: widget.max as num,
            contentType: widget.segmentContentType,
            valueFormatter: widget.valueFormatter != null
                ? (num value) => widget.valueFormatter!(value as T)
                : null,
            height: widget.segmentHeight,
            cardPadding: widget.segmentCardPadding,
            cardMargin: widget.segmentCardMargin,
            cardBorderRadius: widget.segmentCardBorderRadius,
            cardBackgroundColor: widget.segmentCardBackgroundColor,
            cardBorderColor: widget.segmentCardBorderColor,
            textColor: widget.segmentTextColor,
            textSize: widget.segmentTextSize,
            textWeight: widget.segmentTextWeight,
            showBorders: widget.showSegmentBorders,
            showBackgrounds: widget.showSegmentBackgrounds,
            enableEditMode: widget.enableSegmentEdit,
            enableDescriptionEdit: widget.enableDescriptionEdit,
            onSegmentAdd: widget.onSegmentAdd,
            onSegmentRemove: widget.onSegmentRemove,
            addButtonColor: widget.segmentAddButtonColor,
            removeButtonColor: widget.segmentRemoveButtonColor,
            buttonSize: widget.segmentButtonSize,
            customDescriptions: _customSegmentDescriptions,
            onDescriptionEdit: widget.enableDescriptionEdit
                ? _handleDescriptionEdit
                : null,
            enableOpenEndedSegment: widget.enableOpenEndedSegment,
            enableOpenStartedSegment: widget.enableOpenStartedSegment,
          ),
          // Add some spacing between segment display and slider
          const SizedBox(height: 8.0),
          // Main slider content
          sliderContent,
        ],
      );
    }

    // Return just the slider content if segments are disabled
    return sliderContent;
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
          trackHeight: widget.trackHeight,
          isOpenEnded:
              widget.enableOpenEndedSegment && i == allPoints.length - 2,
          isOpenStarted: widget.enableOpenStartedSegment && i == 0,
        ),
      );
    }
    return ranges;
  }

  /// Builds tooltips for thumbs that are currently being dragged or touched.
  List<Widget> _buildTooltips(double totalWidth) {
    if (!widget.showTooltip ||
        (_draggedThumbIndex == null && _touchedThumbIndex == null)) {
      return [];
    }

    // Show tooltip for dragged thumb (priority) or touched thumb
    final int index = _draggedThumbIndex ?? _touchedThumbIndex!;
    final double leftPosition =
        _normalizedPositions[index] * totalWidth - widget.thumbRadius;
    final T currentValue = widget.values[index];

    // Format the tooltip text using custom formatter if provided, otherwise use default formatting
    final String tooltipText = _valueHandler.formatValue(
      currentValue,
      widget.valueFormatter,
    );

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

  /// Returns a list of SliderSegment objects containing both values and descriptions
  List<SliderSegment<num>> _getSegmentsWithDescriptions() {
    if (widget.min is! num || widget.max is! num) {
      throw UnsupportedError(
        'getSegmentsWithDescriptions is only supported for numeric types',
      );
    }

    if (widget.values.isEmpty) {
      final customDesc = _customSegmentDescriptions[0];
      return [
        SliderSegment<num>(
          startValue: widget.enableOpenStartedSegment
              ? null
              : widget.min as num,
          endValue: widget.enableOpenEndedSegment ? null : widget.max as num,
          customDescription: customDesc,
          isOpenStarted: widget.enableOpenStartedSegment,
          isOpenEnded: widget.enableOpenEndedSegment,
        ),
      ];
    }

    final sortedValues = List<T>.from(widget.values)..sort();
    final List<SliderSegment<num>> segments = [];

    // First segment: from min to first value (or open-started)
    final firstCustomDesc = _customSegmentDescriptions[0];
    segments.add(
      SliderSegment<num>(
        startValue: widget.enableOpenStartedSegment ? null : widget.min as num,
        endValue: sortedValues.first as num,
        customDescription: firstCustomDesc,
        isOpenStarted: widget.enableOpenStartedSegment,
      ),
    );

    // Middle segments: between consecutive values
    for (int i = 0; i < sortedValues.length - 1; i++) {
      final customDesc = _customSegmentDescriptions[i + 1];
      segments.add(
        SliderSegment<num>(
          startValue: sortedValues[i] as num,
          endValue: sortedValues[i + 1] as num,
          customDescription: customDesc,
        ),
      );
    }

    // Last segment: from last value to max (or open-ended)
    final lastCustomDesc = _customSegmentDescriptions[sortedValues.length];
    segments.add(
      SliderSegment<num>(
        startValue: sortedValues.last as num,
        endValue: widget.enableOpenEndedSegment ? null : widget.max as num,
        customDescription: lastCustomDesc,
        isOpenEnded: widget.enableOpenEndedSegment,
      ),
    );

    return segments;
  }

  /// Handles editing segment descriptions
  void _handleDescriptionEdit(
    int segmentIndex,
    String defaultDescription,
  ) async {
    final currentDescription = _customSegmentDescriptions[segmentIndex];

    final result = await SegmentEditDialog.show(
      context: context,
      currentDescription: currentDescription,
      defaultDescription: defaultDescription,
      segmentIndex: segmentIndex,
    );

    if (result != null) {
      setState(() {
        if (result.isEmpty) {
          // Remove custom description to use default
          _customSegmentDescriptions.remove(segmentIndex);
        } else {
          // Set custom description
          _customSegmentDescriptions[segmentIndex] = result;
        }
      });

      // Notify callback if provided
      widget.onDescriptionChanged?.call(
        segmentIndex,
        result.isEmpty ? null : result,
      );
    }
  }

  /// Builds the list of thumbs as overlapping widgets.
  List<Widget> _buildThumbs(double totalWidth) {
    return List.generate(_normalizedPositions.length, (index) {
      // Calculate the pixel position of the thumb
      // Subtract radius so the center of the circle lies on the track
      final double leftPosition =
          _normalizedPositions[index] * totalWidth - widget.thumbRadius;

      return Positioned(
        left: leftPosition,
        child: GestureDetector(
          behavior: HitTestBehavior
              .opaque, // Ensure touch events are captured properly
          // Handle immediate touch feedback (only if not read-only)
          onTapDown: widget.readOnly
              ? null
              : (details) {
                  setState(() {
                    _touchedThumbIndex = index;
                  });
                },
          // Handle tap (only if not read-only)
          onTap: widget.readOnly
              ? null
              : () {
                  // Keep tooltip visible briefly after tap for better mobile UX
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    if (mounted &&
                        _touchedThumbIndex == index &&
                        _draggedThumbIndex == null) {
                      setState(() {
                        _touchedThumbIndex = null;
                      });
                    }
                  });
                },
          // Handle touch cancellation (only if not read-only)
          onTapCancel: widget.readOnly
              ? null
              : () {
                  setState(() {
                    if (_touchedThumbIndex == index &&
                        _draggedThumbIndex == null) {
                      _touchedThumbIndex = null;
                    }
                  });
                },
          // Start dragging (only if not read-only)
          onPanStart: widget.readOnly
              ? null
              : (details) {
                  setState(() {
                    _draggedThumbIndex = index;
                    _touchedThumbIndex = index; // Set touched index
                  });
                },
          // End dragging (only if not read-only)
          onPanEnd: widget.readOnly
              ? null
              : (details) {
                  setState(() {
                    _draggedThumbIndex = null;
                    _touchedThumbIndex = null; // Reset touched index
                  });
                },
          // Main logic during dragging (only if not read-only)
          onPanUpdate: widget.readOnly
              ? null
              : (details) {
                  if (_draggedThumbIndex == index) {
                    // 1. Calculate the exact normalized position from global mouse position
                    final double newNormalizedPosition = _positionCalculator
                        .calculateNormalizedPosition(details.globalPosition);

                    // 2. Determine allowed boundaries from neighboring thumbs
                    final double lowerBound = _positionCalculator
                        .calculateLowerBound(index, _normalizedPositions);
                    final double upperBound = _positionCalculator
                        .calculateUpperBound(index, _normalizedPositions);

                    // 3. Clamp the normalized position to valid boundaries
                    final double clampedNormalizedPosition =
                        newNormalizedPosition.clamp(lowerBound, upperBound);

                    // 4. Create new list with updated values
                    List<T> newValues = List.from(widget.values);
                    final T newValue = _valueHandler.fromNormalized(
                      clampedNormalizedPosition,
                      widget.min,
                      widget.max,
                    );

                    // 5. Only update if the value actually changed (helps with smoothness for int types)
                    if (newValue != widget.values[index]) {
                      newValues[index] = newValue;

                      // 6. Call callback to update state in parent component
                      widget.onChanged?.call(newValues);
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
