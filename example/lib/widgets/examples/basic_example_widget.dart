import 'package:flutter/material.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';
import '../../constants/app_constants.dart';
import '../../utils/segment_calculator.dart';

/// Basic integer slider example demonstrating fundamental functionality
///
/// This widget shows a simple multi-thumb slider with:
/// - Integer values from 0 to 100
/// - Percentage formatting
/// - Tickmarks and labels
/// - Tooltip display
/// - Visual segment representation
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
        _buildSegmentDisplay(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildSlider(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildValueDisplay(),
      ],
    );
  }

  /// Builds the visual representation of slider segments
  Widget _buildSegmentDisplay() {
    final segmentWidths = SegmentCalculator.calculateSegmentWidths(
      _values,
      ExampleData.basicIntMin,
      ExampleData.basicIntMax,
    );

    return Row(
      children: segmentWidths.map((width) {
        return Expanded(flex: (width * 100).toInt(), child: _buildSegmentCard(width));
      }).toList(),
    );
  }

  /// Builds an individual segment card
  Widget _buildSegmentCard(double width) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor.withValues(alpha: 0.1),
        border: Border.all(color: Colors.teal.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          width.toStringAsFixed(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
            fontSize: AppConstants.bodyFontSize,
          ),
        ),
      ),
    );
  }

  /// Builds the main slider widget
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
