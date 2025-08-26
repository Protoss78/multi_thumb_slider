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
      child: Row(
        children: List.generate(segmentWidths.length, (index) {
          final width = segmentWidths[index];
          final label = segmentLabels[index];

          return Expanded(flex: (width * 100).toInt(), child: _buildSegmentCard(label));
        }),
      ),
    );
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
}
