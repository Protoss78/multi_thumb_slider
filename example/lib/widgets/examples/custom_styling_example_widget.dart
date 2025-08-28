import 'package:flutter/material.dart';
import 'package:multi_thumb_range_slider/multi_thumb_range_slider.dart';
import '../../constants/app_constants.dart';

/// Custom styling slider example demonstrating visual customization
///
/// This widget shows:
/// - Custom colors for track, thumbs, and ranges
/// - Different slider dimensions
/// - Custom formatting for values
/// - Complete visual customization possibilities
class CustomStylingExampleWidget extends StatefulWidget {
  const CustomStylingExampleWidget({super.key});

  @override
  State<CustomStylingExampleWidget> createState() =>
      _CustomStylingExampleWidgetState();
}

class _CustomStylingExampleWidgetState
    extends State<CustomStylingExampleWidget> {
  List<int> _values = List.from(ExampleData.customValues);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSlider(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildValueDisplay(),
        const SizedBox(height: AppConstants.itemSpacing),
        _buildCustomizationInfo(),
      ],
    );
  }

  /// Builds the main slider widget with custom styling
  Widget _buildSlider() {
    return CustomMultiThumbSlider.withInt(
      values: _values,
      min: ExampleData.basicIntMin,
      max: ExampleData.basicIntMax,
      trackColor: Colors.grey[300]!,
      rangeColors: SliderColorSchemes.customRangeColors,
      thumbColor: Colors.blue[600]!,
      thumbRadius: 16,
      height: 50,
      showTooltip: true,
      tooltipColor: SliderColorSchemes.customTooltipColor,
      tooltipTextColor: Colors.white,
      tooltipTextSize: 13.0,
      valueFormatter: Formatters.custom,
      onChanged: _handleValueChange,
    );
  }

  /// Builds the current values display
  Widget _buildValueDisplay() {
    return Text(
      'Custom values: ${_values.join(", ")}',
      style: TextStyle(
        fontSize: AppConstants.bodyFontSize,
        color: AppConstants.textSecondaryColor,
      ),
    );
  }

  /// Builds customization information
  Widget _buildCustomizationInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.palette, color: Colors.blue[700], size: 16),
              const SizedBox(width: 8),
              Text(
                'Customization Features',
                style: TextStyle(
                  fontSize: AppConstants.captionFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildCustomizationList(),
        ],
      ),
    );
  }

  /// Builds the list of customization features
  Widget _buildCustomizationList() {
    final features = [
      'Custom track color (light gray)',
      'Custom range colors (blue, pink, red)',
      'Custom thumb color (blue)',
      'Larger thumb radius (16px)',
      'Increased slider height (50px)',
      'Custom value formatting',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features.map((feature) => _buildFeatureItem(feature)).toList(),
    );
  }

  /// Builds an individual feature item
  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blue[600],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                fontSize: AppConstants.smallFontSize,
                color: Colors.blue[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Handles slider value changes
  void _handleValueChange(List<int> newValues) {
    setState(() {
      _values = newValues;
    });
  }
}
