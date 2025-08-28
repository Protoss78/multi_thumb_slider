import 'package:flutter/material.dart';
import 'package:multi_thumb_range_slider/multi_thumb_range_slider.dart';
import '../../constants/app_constants.dart';

/// Minimal multi-thumb slider example using only required parameters
///
/// This widget demonstrates the most basic usage of the multi-thumb slider
/// with default styling and behavior. Only the essential parameters are provided:
///
/// **Required Parameters:**
/// - `values`: List of initial thumb positions [25, 50, 75]
/// - `min`: Minimum slider value (0)
/// - `max`: Maximum slider value (100)
/// - `onChanged`: Callback function for value changes
///
/// **Default Values Used:**
/// - Height: 45.0 (from SliderConstants.defaultHeight)
/// - Track color: Light gray (from SliderConstants.defaultTrackColor)
/// - Range colors: [green, blue, orange, red] (from SliderConstants.defaultRangeColors)
/// - Thumb color: White (from SliderConstants.defaultThumbColor)
/// - Thumb radius: 14.0 (from SliderConstants.defaultThumbRadius)
/// - Read-only: false
/// - Show tickmarks: false
/// - Show tooltip: false
///
/// **Use Case:** Perfect for developers who want to get started quickly
/// with minimal configuration while still having a fully functional slider.
///
/// **Code Example:**
/// ```dart
/// CustomMultiThumbSlider<int>(
///   values: [25, 50, 75],
///   min: 0,
///   max: 100,
///   onChanged: (newValues) {
///     setState(() {
///       _values = newValues;
///     });
///   },
/// )
/// ```
class MinimalExampleWidget extends StatefulWidget {
  const MinimalExampleWidget({super.key});

  @override
  State<MinimalExampleWidget> createState() => _MinimalExampleWidgetState();
}

class _MinimalExampleWidgetState extends State<MinimalExampleWidget> {
  List<int> _values = [25, 50, 75];

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

  /// Builds the main slider widget with minimal configuration
  Widget _buildSlider() {
    return CustomMultiThumbSlider<int>(
      values: _values,
      min: 0,
      max: 100,
      onChanged: _handleValueChange,
    );
  }

  /// Builds the current values display
  Widget _buildValueDisplay() {
    return Text(
      'Current values: ${_values.join(", ")}',
      style: TextStyle(
        fontSize: AppConstants.bodyFontSize,
        color: AppConstants.textSecondaryColor,
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
