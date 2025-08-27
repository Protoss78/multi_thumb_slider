import 'package:flutter/material.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';
import '../../constants/app_constants.dart';

/// Segment display example demonstrating the built-in segment visualization feature
///
/// This widget showcases all segment display options:
/// - Different content types (from-to range, to range, width)
/// - Custom styling options
/// - Integration with value formatting
/// - Various slider configurations
class SegmentDisplayExampleWidget extends StatefulWidget {
  const SegmentDisplayExampleWidget({super.key});

  @override
  State<SegmentDisplayExampleWidget> createState() =>
      _SegmentDisplayExampleWidgetState();
}

class _SegmentDisplayExampleWidgetState
    extends State<SegmentDisplayExampleWidget> {
  List<double> _values1 = [15.0, 35.0, 60.0, 85.0];
  List<int> _values2 = [10, 40, 70];
  List<double> _values3 = [25.5, 55.2, 78.8];
  List<double> _values4 = [
    20.0,
    45.0,
    75.0,
  ]; // Separate values for custom styled example

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('From-To Range Display'),
        _buildFromToRangeExample(),
        const SizedBox(height: AppConstants.sectionSpacing),

        _buildSectionTitle('To Range Display (omitting "from")'),
        _buildToRangeExample(),
        const SizedBox(height: AppConstants.sectionSpacing),

        _buildSectionTitle('Segment Width Display'),
        _buildWidthExample(),
        const SizedBox(height: AppConstants.sectionSpacing),

        _buildSectionTitle('Custom Styled Segments'),
        _buildCustomStyledExample(),
        const SizedBox(height: AppConstants.sectionSpacing),

        _buildValuesDisplay(),
      ],
    );
  }

  /// Builds a section title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.itemSpacing),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: AppConstants.captionFontSize,
          fontWeight: FontWeight.w600,
          color: AppConstants.textPrimaryColor,
        ),
      ),
    );
  }

  /// Builds the from-to range example showing "0 - 15", "15 - 35", etc.
  Widget _buildFromToRangeExample() {
    return CustomMultiThumbSlider<double>(
      values: _values1,
      min: 0.0,
      max: 100.0,
      onChanged: (newValues) {
        setState(() {
          _values1 = newValues;
        });
      },
      showSegments: true,
      segmentContentType: SegmentContentType.fromToRange,
      segmentHeight: 50,
      segmentCardBackgroundColor: Colors.blue.shade50,
      segmentCardBorderColor: Colors.blue.shade200,
      segmentTextColor: Colors.blue.shade800,
      segmentTextSize: 12,
      valueFormatter: (value) => value.toStringAsFixed(1),
      showTooltip: true,
      tooltipColor: Colors.blue.shade700,
      tooltipTextColor: Colors.white,
    );
  }

  /// Builds the to range example showing "- 10", "- 40", etc.
  Widget _buildToRangeExample() {
    return CustomMultiThumbSlider.withInt(
      values: _values2,
      min: 0,
      max: 100,
      onChanged: (newValues) {
        setState(() {
          _values2 = newValues;
        });
      },
      showSegments: true,
      segmentContentType: SegmentContentType.toRange,
      segmentHeight: 50,
      segmentCardBackgroundColor: Colors.green.shade50,
      segmentCardBorderColor: Colors.green.shade200,
      segmentTextColor: Colors.green.shade800,
      segmentTextSize: 12,
      valueFormatter: Formatters.percentage,
      showTooltip: true,
      tooltipColor: Colors.green.shade700,
      tooltipTextColor: Colors.white,
    );
  }

  /// Builds the width example showing calculated segment widths
  Widget _buildWidthExample() {
    return CustomMultiThumbSlider<double>(
      values: _values3,
      min: 0.0,
      max: 100.0,
      onChanged: (newValues) {
        setState(() {
          _values3 = newValues;
        });
      },
      showSegments: true,
      segmentContentType: SegmentContentType.width,
      segmentHeight: 50,
      segmentCardBackgroundColor: Colors.orange.shade50,
      segmentCardBorderColor: Colors.orange.shade200,
      segmentTextColor: Colors.orange.shade800,
      segmentTextSize: 12,
      valueFormatter: (value) => value.toStringAsFixed(1),
      showTooltip: true,
      tooltipColor: Colors.orange.shade700,
      tooltipTextColor: Colors.white,
    );
  }

  /// Builds a custom styled segment display example
  Widget _buildCustomStyledExample() {
    return CustomMultiThumbSlider<double>(
      values: _values4,
      min: 0.0,
      max: 100.0,
      onChanged: (newValues) {
        setState(() {
          _values4 = newValues;
        });
      },
      showSegments: true,
      segmentContentType: SegmentContentType.fromToRange,
      segmentHeight: 70,
      segmentCardPadding: 12,
      segmentCardMargin: 4,
      segmentCardBorderRadius: 12,
      segmentCardBackgroundColor: Colors.purple.shade100,
      segmentCardBorderColor: Colors.purple.shade400,
      segmentTextColor: Colors.purple.shade900,
      segmentTextSize: 14,
      segmentTextWeight: FontWeight.bold,
      showSegmentBorders: true,
      showSegmentBackgrounds: true,
      valueFormatter: (value) => '${value.toStringAsFixed(1)}%',
      showTooltip: true,
      tooltipColor: Colors.purple.shade700,
      tooltipTextColor: Colors.white,
      rangeColors: [
        Colors.purple.shade200,
        Colors.purple.shade300,
        Colors.purple.shade400,
        Colors.purple.shade500,
        Colors.purple.shade600,
      ],
    );
  }

  /// Builds the current values display
  Widget _buildValuesDisplay() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.cardPadding),
      decoration: BoxDecoration(
        color: AppConstants.cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Values:',
            style: TextStyle(
              fontSize: AppConstants.captionFontSize,
              fontWeight: FontWeight.w600,
              color: AppConstants.textPrimaryColor,
            ),
          ),
          const SizedBox(height: AppConstants.itemSpacing),
          Text(
            'From-To Range: ${_values1.map((v) => v.toStringAsFixed(1)).join(', ')}',
            style: TextStyle(
              fontSize: AppConstants.bodyFontSize,
              color: AppConstants.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'To Range: ${_values2.join(', ')}',
            style: TextStyle(
              fontSize: AppConstants.bodyFontSize,
              color: AppConstants.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Width Display: ${_values3.map((v) => v.toStringAsFixed(1)).join(', ')}',
            style: TextStyle(
              fontSize: AppConstants.bodyFontSize,
              color: AppConstants.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Custom Styled: ${_values4.map((v) => v.toStringAsFixed(1)).join(', ')}',
            style: TextStyle(
              fontSize: AppConstants.bodyFontSize,
              color: AppConstants.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
