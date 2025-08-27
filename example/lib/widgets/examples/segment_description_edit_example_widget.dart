import 'package:flutter/material.dart';
import 'package:multi_thumb_range_slider/multi_thumb_range_slider.dart';
import '../../constants/app_constants.dart';

/// Segment description editing example demonstrating custom segment descriptions
///
/// This widget showcases the new segment description editing features:
/// - Enabling/disabling description editing mode
/// - Interactive segment cards with edit functionality
/// - Custom descriptions with reset-to-default capability
/// - Visual indicators for edited segments
/// - Real-time callback notifications
class SegmentDescriptionEditExampleWidget extends StatefulWidget {
  const SegmentDescriptionEditExampleWidget({super.key});

  @override
  State<SegmentDescriptionEditExampleWidget> createState() => _SegmentDescriptionEditExampleWidgetState();
}

class _SegmentDescriptionEditExampleWidgetState extends State<SegmentDescriptionEditExampleWidget> {
  List<int> _values = [20, 60, 80];
  final int _min = 0;
  final int _max = 100;
  bool _descriptionEditEnabled = true;

  // Store custom descriptions and edit history
  final Map<int, String> _customDescriptions = {};
  final List<String> _editHistory = [];

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
        _buildSegmentDescriptions(),
        if (_editHistory.isNotEmpty) ...[const SizedBox(height: AppConstants.largeSpacing), _buildEditHistory()],
      ],
    );
  }

  /// Builds the control panel for toggling description edit mode
  Widget _buildControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              _descriptionEditEnabled ? Icons.edit : Icons.lock,
              color: _descriptionEditEnabled ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 8),
            const Text('Description Edit Mode:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 16),
            Switch(
              value: _descriptionEditEnabled,
              onChanged: (value) {
                setState(() {
                  _descriptionEditEnabled = value;
                });
                _addToHistory(_descriptionEditEnabled ? 'Description editing enabled' : 'Description editing disabled');
              },
            ),
            const Spacer(),
            if (_customDescriptions.isNotEmpty)
              TextButton.icon(
                onPressed: _clearAllDescriptions,
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear All'),
              ),
          ],
        ),
      ),
    );
  }

  /// Builds instruction text explaining the feature
  Widget _buildInstructions() {
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[700]),
                const SizedBox(width: 8),
                Text(
                  'Segment Description Editing',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _descriptionEditEnabled
                  ? '• Tap on any segment card to edit its description\n'
                        '• Edit icons (✏️) are visible next to segment text\n'
                        '• Use "Reset to Default" in the dialog to restore original text\n'
                        '• Custom descriptions are underlined for easy identification'
                  : '• Description editing is currently disabled\n'
                        '• No edit icons are shown and segment cards are not interactive\n'
                        '• Toggle the switch above to enable editing functionality',
              style: TextStyle(color: Colors.blue[700]),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the main slider with segment description editing enabled
  Widget _buildSlider() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomMultiThumbSlider<int>(
              values: _values,
              min: _min,
              max: _max,
              showSegments: true,
              enableDescriptionEdit: _descriptionEditEnabled,
              segmentContentType: SegmentContentType.fromToRange,
              onChanged: (newValues) {
                setState(() {
                  _values = newValues;
                });
              },
              onDescriptionChanged: _handleDescriptionChanged,
              // Enhanced styling for better visibility
              segmentCardBackgroundColor: Colors.grey[100]!,
              segmentCardBorderColor: Colors.grey[300]!,
              segmentTextColor: Colors.grey[800]!,
              showSegmentBorders: true,
              segmentHeight: 60,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the current values display
  Widget _buildValueDisplay() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.tune, color: Colors.orange),
            const SizedBox(width: 8),
            const Text('Current Values:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(_values.join(', '), style: const TextStyle(fontFamily: 'monospace', fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a display of current segment descriptions
  Widget _buildSegmentDescriptions() {
    // Get segments using the new API
    final slider = CustomMultiThumbSlider<int>(values: _values, min: _min, max: _max, onChanged: (_) {});

    final segments = slider.getSegmentsWithDescriptions();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.segment, color: Colors.purple),
                const SizedBox(width: 8),
                const Text('Segment Descriptions:', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            ...segments.asMap().entries.map((entry) {
              final index = entry.key;
              final segment = entry.value;
              final isCustom = _customDescriptions.containsKey(index);
              final description = isCustom
                  ? _customDescriptions[index]!
                  : '${segment.startValue} - ${segment.endValue}';

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isCustom ? Colors.orange : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isCustom ? Colors.white : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(
                          decoration: isCustom ? TextDecoration.underline : null,
                          fontWeight: isCustom ? FontWeight.bold : null,
                          color: isCustom ? Colors.orange[700] : null,
                        ),
                      ),
                    ),
                    if (isCustom) Icon(Icons.edit, size: 16, color: Colors.orange[700]),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Builds the edit history display
  Widget _buildEditHistory() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.history, color: Colors.green),
                const SizedBox(width: 8),
                const Text('Edit History:', style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton.icon(onPressed: _clearHistory, icon: const Icon(Icons.clear), label: const Text('Clear')),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _editHistory.length,
                itemBuilder: (context, index) {
                  final reverseIndex = _editHistory.length - 1 - index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      '${reverseIndex + 1}. ${_editHistory[reverseIndex]}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Handles description change callbacks
  void _handleDescriptionChanged(int segmentIndex, String? customDescription) {
    setState(() {
      if (customDescription == null || customDescription.isEmpty) {
        _customDescriptions.remove(segmentIndex);
        _addToHistory('Segment ${segmentIndex + 1}: Reset to default');
      } else {
        _customDescriptions[segmentIndex] = customDescription;
        _addToHistory('Segment ${segmentIndex + 1}: "$customDescription"');
      }
    });
  }

  /// Adds an entry to the edit history
  void _addToHistory(String entry) {
    setState(() {
      _editHistory.add('${DateTime.now().toString().substring(11, 19)} - $entry');
      // Keep only the last 20 entries
      if (_editHistory.length > 20) {
        _editHistory.removeAt(0);
      }
    });
  }

  /// Clears all custom descriptions
  void _clearAllDescriptions() {
    setState(() {
      _customDescriptions.clear();
    });
    _addToHistory('All custom descriptions cleared');
  }

  /// Clears the edit history
  void _clearHistory() {
    setState(() {
      _editHistory.clear();
    });
  }
}
