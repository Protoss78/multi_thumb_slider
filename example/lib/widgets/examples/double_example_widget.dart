import 'package:flutter/material.dart';
import 'package:multi_thumb_range_slider/multi_thumb_range_slider.dart';
import '../../constants/app_constants.dart';

/// Double precision slider example demonstrating decimal value handling
///
/// This widget shows a multi-thumb slider with:
/// - Double values from 0.0 to 100.0
/// - Decimal precision formatting
/// - Tooltip display with precise values
/// - Segment display showing width calculations
class DoubleExampleWidget extends StatefulWidget {
  const DoubleExampleWidget({super.key});

  @override
  State<DoubleExampleWidget> createState() => _DoubleExampleWidgetState();
}

class _DoubleExampleWidgetState extends State<DoubleExampleWidget> {
  List<double> _values = List.from(ExampleData.doubleValues);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSlider(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildValueDisplay(),
        const SizedBox(height: AppConstants.itemSpacing),
        _buildPrecisionInfo(),
      ],
    );
  }

  /// Builds the main slider widget
  Widget _buildSlider() {
    return CustomMultiThumbSlider<double>(
      values: _values,
      min: ExampleData.doubleMin,
      max: ExampleData.doubleMax,
      showTooltip: true,
      tooltipColor: SliderColorSchemes.customTooltipColor,
      tooltipTextColor: Colors.white,
      tooltipTextSize: 13.0,
      valueFormatter: Formatters.decimalSingle,
      // Enable segment display showing width calculations
      showSegments: true,
      segmentContentType: SegmentContentType.width,
      segmentHeight: 55,
      segmentCardBackgroundColor: Colors.blue.shade50,
      segmentCardBorderColor: Colors.blue.shade200,
      segmentTextColor: Colors.blue.shade800,
      segmentTextSize: 11,
      onChanged: _handleValueChange,
    );
  }

  /// Builds the current values display
  Widget _buildValueDisplay() {
    return Text(
      'Values: ${_values.map(Formatters.decimalSingle).join(", ")}',
      style: TextStyle(
        fontSize: AppConstants.bodyFontSize,
        color: AppConstants.textSecondaryColor,
      ),
    );
  }

  /// Builds information about decimal precision
  Widget _buildPrecisionInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Text(
        'Drag the thumbs to see decimal precision and segment width calculations',
        style: TextStyle(
          fontSize: AppConstants.smallFontSize,
          color: Colors.blue[800],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Handles slider value changes
  void _handleValueChange(List<double> newValues) {
    setState(() {
      _values = newValues;
    });
  }
}
