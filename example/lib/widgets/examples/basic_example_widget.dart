import 'package:flutter/material.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';
import '../../constants/app_constants.dart';

/// Basic integer slider example demonstrating fundamental functionality
///
/// This widget shows a simple multi-thumb slider with:
/// - Integer values from 0 to 100
/// - Percentage formatting
/// - Tickmarks and labels
/// - Tooltip display
/// - Built-in segment display feature
class BasicExampleWidget extends StatefulWidget {
  const BasicExampleWidget({super.key});

  @override
  State<BasicExampleWidget> createState() => _BasicExampleWidgetState();
}

class _BasicExampleWidgetState extends State<BasicExampleWidget> {
  List<int> _values = List.from(ExampleData.basicIntValues);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSlider(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildValueDisplay(),
      ],
    );
  }

  /// Builds the main slider widget with built-in segment display
  Widget _buildSlider() {
    return CustomMultiThumbSlider.withInt(
      values: _values,
      min: ExampleData.basicIntMin,
      max: ExampleData.basicIntMax,
      showTickmarks: true,
      tickmarkColor: Colors.grey.shade600,
      tickmarkSize: 15.0,
      tickmarkInterval: 5,
      showTickmarkLabels: true,
      tickmarkLabelInterval: 10,
      tickmarkLabelColor: Colors.grey.shade700,
      tickmarkLabelSize: 11.0,
      showTooltip: true,
      tooltipColor: SliderColorSchemes.defaultTooltipColor,
      tooltipTextColor: Colors.white,
      tooltipTextSize: 14.0,
      valueFormatter: Formatters.percentage,
      // Enable the built-in segment display
      showSegments: true,
      segmentContentType: SegmentContentType.fromToRange,
      segmentCardBackgroundColor: AppConstants.primaryColor.withValues(alpha: 0.1),
      segmentCardBorderColor: Colors.teal.shade200,
      segmentTextColor: Colors.teal.shade900,
      onChanged: _handleValueChange,
    );
  }

  /// Builds the current values display
  Widget _buildValueDisplay() {
    return Text(
      'Values: ${_values.join(", ")}',
      style: TextStyle(fontSize: AppConstants.bodyFontSize, color: AppConstants.textSecondaryColor),
    );
  }

  /// Handles slider value changes
  void _handleValueChange(List<int> newValues) {
    setState(() {
      _values = newValues;
    });
  }
}
