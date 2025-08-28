import 'package:flutter/material.dart';
import 'package:multi_thumb_range_slider/multi_thumb_range_slider.dart';
import '../../constants/app_constants.dart';

/// Segment edit mode example demonstrating dynamic segment editing functionality
///
/// This widget showcases the new segment edit mode features:
/// - Adding segments via + buttons
/// - Removing segments via × buttons on segment cards
/// - Automatic thumb value calculation for new segments
/// - Visual feedback for edit operations
/// - Integration with existing slider functionality
class SegmentEditExampleWidget extends StatefulWidget {
  const SegmentEditExampleWidget({super.key});

  @override
  State<SegmentEditExampleWidget> createState() =>
      _SegmentEditExampleWidgetState();
}

class _SegmentEditExampleWidgetState extends State<SegmentEditExampleWidget> {
  List<int> _values = [25, 50, 75];
  final int _min = 0;
  final int _max = 100;
  bool _editModeEnabled = true;
  bool _descriptionEditEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildControls(),
        const SizedBox(height: AppConstants.itemSpacing),
        _buildInstructions(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildSlider(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildValueDisplay(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildSegmentInfo(),
      ],
    );
  }

  /// Builds the control panel for toggling edit modes
  Widget _buildControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Segment Add/Remove Edit Mode
            Row(
              children: [
                Text(
                  'Segment Edit Mode:',
                  style: TextStyle(
                    fontSize: AppConstants.bodyFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16.0),
                Switch(
                  value: _editModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _editModeEnabled = value;
                    });
                  },
                ),
                const SizedBox(width: 16.0),
                Text(
                  _editModeEnabled ? 'ON' : 'OFF',
                  style: TextStyle(
                    fontSize: AppConstants.bodyFontSize,
                    color: _editModeEnabled ? Colors.green : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            // Description Edit Mode
            Row(
              children: [
                Text(
                  'Description Edit Mode:',
                  style: TextStyle(
                    fontSize: AppConstants.bodyFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16.0),
                Switch(
                  value: _descriptionEditEnabled,
                  onChanged: (value) {
                    setState(() {
                      _descriptionEditEnabled = value;
                    });
                  },
                ),
                const SizedBox(width: 16.0),
                Text(
                  _descriptionEditEnabled ? 'ON' : 'OFF',
                  style: TextStyle(
                    fontSize: AppConstants.bodyFontSize,
                    color: _descriptionEditEnabled ? Colors.green : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds instruction text for using the edit modes
  Widget _buildInstructions() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How to use Edit Modes:',
              style: TextStyle(
                fontSize: AppConstants.bodyFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Segment Edit Mode:',
              style: TextStyle(
                fontSize: AppConstants.bodyFontSize - 1,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
              ),
            ),
            _buildInstructionItem(
              '• Click the green + buttons to add new segments',
            ),
            _buildInstructionItem(
              '• Click the red × buttons on segment cards to remove segments',
            ),
            _buildInstructionItem(
              '• New segments are automatically positioned at the midpoint',
            ),
            const SizedBox(height: 8.0),
            Text(
              'Description Edit Mode:',
              style: TextStyle(
                fontSize: AppConstants.bodyFontSize - 1,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
              ),
            ),
            _buildInstructionItem(
              '• Click on any segment card to edit its description',
            ),
            _buildInstructionItem(
              '• Edit icons (✏️) are visible next to segment text',
            ),
            _buildInstructionItem(
              '• Use "Reset to Default" in the dialog to restore original text',
            ),
            const SizedBox(height: 8.0),
            _buildInstructionItem(
              '• Toggle each mode independently using the switches above',
            ),
            _buildInstructionItem(
              '• Slider thumbs can still be dragged normally',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppConstants.bodyFontSize - 1,
          color: Colors.blue.shade800,
        ),
      ),
    );
  }

  /// Builds the main slider with segment edit modes
  Widget _buildSlider() {
    return CustomMultiThumbSlider.withInt(
      values: _values,
      min: _min,
      max: _max,
      // Enable segments display
      showSegments: true,
      segmentContentType: SegmentContentType.fromToRange,
      segmentCardBackgroundColor: AppConstants.primaryColor.withValues(
        alpha: 0.1,
      ),
      segmentCardBorderColor: Colors.teal.shade200,
      segmentTextColor: Colors.teal.shade900,
      // Enable segment edit modes
      enableSegmentEdit: _editModeEnabled,
      enableDescriptionEdit: _descriptionEditEnabled,
      onSegmentAdd: _handleSegmentAdd,
      onSegmentRemove: _handleSegmentRemove,
      onDescriptionChanged: _handleDescriptionChanged,
      segmentAddButtonColor: Colors.green,
      segmentRemoveButtonColor: Colors.red,
      segmentButtonSize: 24.0,
      // Slider styling
      showTickmarks: true,
      tickmarkInterval: 10,
      showTickmarkLabels: true,
      tickmarkLabelInterval: 20,
      showTooltip: true,
      valueFormatter: (value) => '$value%',
      onChanged: _handleValueChange,
    );
  }

  /// Builds the current values display
  Widget _buildValueDisplay() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Configuration:',
              style: TextStyle(
                fontSize: AppConstants.bodyFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Thumb Values: ${_values.join(", ")}',
              style: TextStyle(fontSize: AppConstants.bodyFontSize),
            ),
            Text(
              'Number of Segments: ${_values.length + 1}',
              style: TextStyle(fontSize: AppConstants.bodyFontSize),
            ),
            Text(
              'Segment Edit Mode: ${_editModeEnabled ? "Enabled" : "Disabled"}',
              style: TextStyle(fontSize: AppConstants.bodyFontSize),
            ),
            Text(
              'Description Edit Mode: ${_descriptionEditEnabled ? "Enabled" : "Disabled"}',
              style: TextStyle(fontSize: AppConstants.bodyFontSize),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds segment information display
  Widget _buildSegmentInfo() {
    // Calculate segment widths manually for the example
    final segmentWidths = <double>[];
    for (int i = 0; i < _values.length + 1; i++) {
      if (i == 0) {
        segmentWidths.add((_values[i] - _min) / (_max - _min));
      } else if (i == _values.length) {
        segmentWidths.add((_max - _values[i - 1]) / (_max - _min));
      } else {
        segmentWidths.add((_values[i] - _values[i - 1]) / (_max - _min));
      }
    }

    final segmentPercentages = segmentWidths
        .map((w) => (w * 100).toStringAsFixed(1))
        .toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Segment Analysis:',
              style: TextStyle(
                fontSize: AppConstants.bodyFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            for (int i = 0; i < segmentPercentages.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  'Segment ${i + 1}: ${segmentPercentages[i]}% of total range',
                  style: TextStyle(fontSize: AppConstants.bodyFontSize - 1),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Handles adding a new segment at the specified index
  void _handleSegmentAdd(int segmentIndex) {
    // Simple logic for adding a segment: insert a new value at the midpoint
    final newValues = List<int>.from(_values);

    if (segmentIndex == 0) {
      // Add at the beginning
      final newValue = _min + ((_values.first - _min) ~/ 2);
      newValues.insert(0, newValue);
    } else if (segmentIndex == _values.length) {
      // Add at the end
      final newValue = _values.last + ((_max - _values.last) ~/ 2);
      newValues.add(newValue);
    } else {
      // Add between existing values
      final prevValue = _values[segmentIndex - 1];
      final nextValue = _values[segmentIndex];
      final newValue = prevValue + ((nextValue - prevValue) ~/ 2);
      newValues.insert(segmentIndex, newValue);
    }

    // Ensure the new value is within bounds
    if (newValues.every((value) => value >= _min && value <= _max)) {
      setState(() {
        _values = newValues;
      });

      // Show feedback to user
      _showFeedback('Added new segment at position $segmentIndex');
    } else {
      _showError('Cannot add segment at this position');
    }
  }

  /// Handles removing a segment at the specified index
  void _handleSegmentRemove(int segmentIndex) {
    // Prevent removing all segments (must have at least one thumb for a meaningful slider)
    if (_values.length <= 1) {
      _showError('Cannot remove all segments. At least one thumb must remain.');
      return;
    }

    // Simple logic for removing a segment: remove the value at the specified index
    final newValues = List<int>.from(_values);
    newValues.removeAt(segmentIndex);

    setState(() {
      _values = newValues;
    });

    // Show feedback to user
    _showFeedback('Removed segment at position $segmentIndex');
  }

  /// Handles normal slider value changes (thumb dragging)
  void _handleValueChange(List<int> newValues) {
    setState(() {
      _values = newValues;
    });
  }

  /// Handles segment description changes
  void _handleDescriptionChanged(int segmentIndex, String? customDescription) {
    final String message = customDescription != null
        ? 'Updated description for segment ${segmentIndex + 1}'
        : 'Reset description for segment ${segmentIndex + 1} to default';

    _showFeedback(message);
  }

  /// Shows success feedback to the user
  void _showFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Shows error feedback to the user
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
