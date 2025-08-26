import 'package:flutter/material.dart';
import '../constants.dart';
import '../segment_calculator.dart';

/// A widget that displays segment information for a multi-thumb slider
///
/// This widget shows visual representations of the segments created by the slider values,
/// with customizable content types and styling options.
class SegmentDisplayWidget<T extends num> extends StatelessWidget {
  /// The current values of the slider
  final List<T> values;

  /// The minimum value of the slider
  final T min;

  /// The maximum value of the slider
  final T max;

  /// The type of content to display in each segment
  final SegmentContentType contentType;

  /// Optional custom function to format values
  final String Function(T)? valueFormatter;

  /// The height of the segment display
  final double height;

  /// The padding inside each segment card
  final double cardPadding;

  /// The margin between segment cards
  final double cardMargin;

  /// The border radius of segment cards
  final double cardBorderRadius;

  /// The background color of segment cards
  final Color cardBackgroundColor;

  /// The border color of segment cards
  final Color cardBorderColor;

  /// The text color of segment content
  final Color textColor;

  /// The font size of segment text
  final double textSize;

  /// The font weight of segment text
  final FontWeight textWeight;

  /// Whether to show segment borders
  final bool showBorders;

  /// Whether to show segment backgrounds
  final bool showBackgrounds;

  /// Whether to enable edit mode with add/remove buttons
  final bool enableEditMode;

  /// Callback function called when a new segment should be added
  final void Function(int segmentIndex)? onSegmentAdd;

  /// Callback function called when a segment should be removed
  final void Function(int segmentIndex)? onSegmentRemove;

  /// The color of the add segment button
  final Color addButtonColor;

  /// The color of the remove segment button
  final Color removeButtonColor;

  /// The size of segment edit buttons
  final double buttonSize;

  /// Creates a segment display widget
  const SegmentDisplayWidget({
    super.key,
    required this.values,
    required this.min,
    required this.max,
    this.contentType = SegmentContentType.fromToRange,
    this.valueFormatter,
    this.height = SliderConstants.defaultSegmentHeight,
    this.cardPadding = SliderConstants.defaultSegmentCardPadding,
    this.cardMargin = SliderConstants.defaultSegmentCardMargin,
    this.cardBorderRadius = SliderConstants.defaultSegmentCardBorderRadius,
    this.cardBackgroundColor = SliderConstants.defaultSegmentBackgroundColor,
    this.cardBorderColor = SliderConstants.defaultSegmentBorderColor,
    this.textColor = SliderConstants.defaultSegmentTextColor,
    this.textSize = SliderConstants.defaultSegmentTextSize,
    this.textWeight = FontWeight.normal,
    this.showBorders = true,
    this.showBackgrounds = true,
    this.enableEditMode = false,
    this.onSegmentAdd,
    this.onSegmentRemove,
    this.addButtonColor = SliderConstants.defaultSegmentAddButtonColor,
    this.removeButtonColor = SliderConstants.defaultSegmentRemoveButtonColor,
    this.buttonSize = SliderConstants.defaultSegmentButtonSize,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate segment widths and labels
    final segmentWidths = SegmentCalculator.calculateSegmentWidths(values, min, max);
    final segmentLabels = SegmentCalculator.createSegmentLabelsByType(
      values,
      min,
      max,
      contentType: contentType,
      formatter: valueFormatter,
    );

    return SizedBox(
      height: height,
      child: enableEditMode
          ? _buildEditModeLayout(segmentWidths, segmentLabels)
          : _buildDisplayModeLayout(segmentWidths, segmentLabels),
    );
  }

  /// Builds the display-only layout (original behavior)
  Widget _buildDisplayModeLayout(List<double> segmentWidths, List<String> segmentLabels) {
    return Row(
      children: List.generate(segmentWidths.length, (index) {
        final width = segmentWidths[index];
        final label = segmentLabels[index];
        return Expanded(flex: (width * 100).toInt(), child: _buildSegmentCard(label));
      }),
    );
  }

  /// Builds the edit mode layout with add/remove buttons
  Widget _buildEditModeLayout(List<double> segmentWidths, List<String> segmentLabels) {
    List<Widget> children = [];

    for (int i = 0; i < segmentWidths.length; i++) {
      final width = segmentWidths[i];
      final label = segmentLabels[i];

      // Add + button before first segment and between segments
      if (i == 0 || i < segmentWidths.length) {
        children.add(_buildAddButton(i));
      }

      // Add the segment card with remove button
      children.add(Expanded(flex: (width * 100).toInt(), child: _buildEditableSegmentCard(label, i)));
    }

    // Add final + button after last segment
    children.add(_buildAddButton(segmentWidths.length));

    return Row(children: children);
  }

  /// Builds an individual segment card
  Widget _buildSegmentCard(String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: cardMargin),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: showBackgrounds ? cardBackgroundColor : Colors.transparent,
        border: showBorders ? Border.all(color: cardBorderColor) : null,
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: textColor, fontSize: textSize, fontWeight: textWeight),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  /// Builds an editable segment card with remove button
  Widget _buildEditableSegmentCard(String label, int segmentIndex) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: cardMargin),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: showBackgrounds ? cardBackgroundColor : Colors.transparent,
        border: showBorders ? Border.all(color: cardBorderColor) : null,
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              label,
              style: TextStyle(color: textColor, fontSize: textSize, fontWeight: textWeight),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Only show remove button if there are more than 1 segments (to prevent removing all segments)
          if (values.isNotEmpty) Positioned(top: 0, right: 0, child: _buildRemoveButton(segmentIndex)),
        ],
      ),
    );
  }

  /// Builds an add button for adding segments
  Widget _buildAddButton(int insertIndex) {
    return GestureDetector(
      onTap: () => onSegmentAdd?.call(insertIndex),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(color: addButtonColor, shape: BoxShape.circle),
        child: Icon(Icons.add, color: Colors.white, size: buttonSize * 0.6),
      ),
    );
  }

  /// Builds a remove button for removing segments
  Widget _buildRemoveButton(int segmentIndex) {
    return GestureDetector(
      onTap: () => onSegmentRemove?.call(segmentIndex),
      child: Container(
        width: buttonSize * 0.8,
        height: buttonSize * 0.8,
        decoration: BoxDecoration(color: removeButtonColor, shape: BoxShape.circle),
        child: Icon(Icons.close, color: Colors.white, size: buttonSize * 0.5),
      ),
    );
  }
}
