import 'package:flutter/material.dart';
import 'package:multi_thumb_range_slider/multi_thumb_range_slider.dart';
import '../../constants/app_constants.dart';

/// Weight class slider example for sports and fitness applications
///
/// This widget demonstrates:
/// - Larger slider dimensions for better touch interaction
/// - Weight formatting with units
/// - Multiple values for category boundaries
/// - Sports/fitness themed styling
/// - Open-ended segments for heavyweight categories (80kg+)
/// - Open-started segments for lightweight categories (55kg or less)
class WeightClassExampleWidget extends StatefulWidget {
  const WeightClassExampleWidget({super.key});

  @override
  State<WeightClassExampleWidget> createState() => _WeightClassExampleWidgetState();
}

class _WeightClassExampleWidgetState extends State<WeightClassExampleWidget> {
  List<int> _values = List.from(ExampleData.weightValues);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSlider(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildWeightDisplay(),
        const SizedBox(height: AppConstants.itemSpacing),
        _buildWeightClassInfo(),
      ],
    );
  }

  /// Builds the main slider widget
  Widget _buildSlider() {
    return CustomMultiThumbSlider.withInt(
      values: _values,
      min: ExampleData.weightMin,
      max: ExampleData.weightMax,
      height: AppConstants.customSliderHeight,
      thumbRadius: AppConstants.largeThumbRadius,
      showTooltip: true,
      tooltipColor: SliderColorSchemes.weightTooltipColor,
      tooltipTextColor: Colors.white,
      tooltipTextSize: 14.0,
      valueFormatter: Formatters.weight,
      onChanged: _handleValueChange,
      enableOpenEndedSegment: true,
      enableOpenStartedSegment: true,
      showSegments: true,
      segmentContentType: SegmentContentType.toRange,
      tickmarkInterval: 10,
      showTickmarks: true,
      showTickmarkLabels: true,
    );
  }

  /// Builds the weight classes display
  Widget _buildWeightDisplay() {
    return Text(
      'Weight classes: ${_values.map(Formatters.weight).join(", ")}',
      style: TextStyle(fontSize: AppConstants.bodyFontSize, color: AppConstants.textSecondaryColor),
    );
  }

  /// Builds weight class information
  Widget _buildWeightClassInfo() {
    final classes = _getWeightClasses();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.fitness_center, color: Colors.purple[700], size: 16),
              const SizedBox(width: 8),
              Text(
                'Weight Classes',
                style: TextStyle(
                  fontSize: AppConstants.captionFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...classes.map((weightClass) => _buildWeightClassRow(weightClass)),
        ],
      ),
    );
  }

  /// Gets weight class information
  List<Map<String, dynamic>> _getWeightClasses() {
    final sortedValues = List<int>.from(_values)..sort();

    final classNames = ['Lightweight', 'Welterweight', 'Middleweight', 'Light Heavyweight', 'Heavyweight'];
    final colors = [
      Colors.green.shade300,
      Colors.blue.shade300,
      Colors.orange.shade300,
      Colors.red.shade300,
      Colors.purple.shade300,
    ];

    final List<Map<String, dynamic>> classes = [];

    if (sortedValues.isNotEmpty) {
      // First class is open-started (lightweight class)
      classes.add({'name': classNames[0], 'range': '- ${Formatters.weight(sortedValues.first)}', 'color': colors[0]});

      // Middle classes (with upper and lower bounds)
      for (int i = 0; i < sortedValues.length - 1; i++) {
        classes.add({
          'name': classNames[(i + 1) % classNames.length],
          'range': '${Formatters.weight(sortedValues[i])} - ${Formatters.weight(sortedValues[i + 1])}',
          'color': colors[(i + 1) % colors.length],
        });
      }

      // Last class is open-ended (heavyweight class)
      classes.add({
        'name': classNames[sortedValues.length % classNames.length],
        'range': '${Formatters.weight(sortedValues.last)}+',
        'color': colors[sortedValues.length % colors.length],
      });
    }

    return classes;
  }

  /// Builds a weight class information row
  Widget _buildWeightClassRow(Map<String, dynamic> weightClass) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: weightClass['color'] as Color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${weightClass['name']}: ${weightClass['range']}',
              style: TextStyle(fontSize: AppConstants.smallFontSize, color: Colors.purple[700]),
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
