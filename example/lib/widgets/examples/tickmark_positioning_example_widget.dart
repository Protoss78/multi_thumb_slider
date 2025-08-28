import 'package:flutter/material.dart';
import 'package:multi_thumb_range_slider/multi_thumb_range_slider.dart';
import '../../constants/app_constants.dart';

/// Example widget demonstrating different tickmark positioning options
class TickmarkPositioningExampleWidget extends StatefulWidget {
  const TickmarkPositioningExampleWidget({super.key});

  @override
  State<TickmarkPositioningExampleWidget> createState() =>
      _TickmarkPositioningExampleWidgetState();
}

class _TickmarkPositioningExampleWidgetState
    extends State<TickmarkPositioningExampleWidget> {
  List<int> _values = [25, 75];
  TickmarkPosition _tickmarkPosition = TickmarkPosition.below;
  double _tickmarkSize = 8.0;
  double _tickmarkSpacing = 8.0;
  double _labelSpacing = 4.0;
  double _trackHeight = 8.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildControls(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildSlider(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildInfo(),
      ],
    );
  }

  /// Builds the control panel for adjusting tickmark settings
  Widget _buildControls() {
    // Ensure all variables are valid numbers
    final tickmarkSize = _tickmarkSize.isFinite ? _tickmarkSize : 8.0;
    final tickmarkSpacing = _tickmarkSpacing.isFinite ? _tickmarkSpacing : 8.0;
    final labelSpacing = _labelSpacing.isFinite ? _labelSpacing : 4.0;
    final trackHeight = _trackHeight.isFinite ? _trackHeight : 8.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tickmark Positioning Controls',
            style: TextStyle(
              fontSize: AppConstants.bodyFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: AppConstants.itemSpacing),

          // Position selector
          Row(
            children: [
              Text(
                'Position: ',
                style: TextStyle(fontSize: AppConstants.captionFontSize),
              ),
              DropdownButton<TickmarkPosition>(
                value: _tickmarkPosition,
                items: TickmarkPosition.values.map((position) {
                  return DropdownMenuItem(
                    value: position,
                    child: Text(position.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _tickmarkPosition = value);
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: AppConstants.itemSpacing),

          // Size slider
          Row(
            children: [
              Text(
                'Tickmark Size: ',
                style: TextStyle(fontSize: AppConstants.captionFontSize),
              ),
              Expanded(
                child: Slider(
                  value: tickmarkSize,
                  min: 4.0,
                  max: 16.0,
                  divisions: 12,
                  label: tickmarkSize.toStringAsFixed(1),
                  onChanged: (value) => setState(() => _tickmarkSize = value),
                ),
              ),
              Text(tickmarkSize.toStringAsFixed(1)),
            ],
          ),

          // Spacing sliders
          Row(
            children: [
              Text(
                'Track Spacing: ',
                style: TextStyle(fontSize: AppConstants.captionFontSize),
              ),
              Expanded(
                child: Slider(
                  value: tickmarkSpacing,
                  min: 0.0,
                  max: 20.0,
                  divisions: 10,
                  label: tickmarkSpacing.toStringAsFixed(1),
                  onChanged: (value) =>
                      setState(() => _tickmarkSpacing = value),
                ),
              ),
              Text(tickmarkSpacing.toStringAsFixed(1)),
            ],
          ),

          Row(
            children: [
              Text(
                'Label Spacing: ',
                style: TextStyle(fontSize: AppConstants.captionFontSize),
              ),
              Expanded(
                child: Slider(
                  value: labelSpacing,
                  min: 0.0,
                  max: 20.0,
                  divisions: 18,
                  label: labelSpacing.toStringAsFixed(1),
                  onChanged: (value) => setState(() => _labelSpacing = value),
                ),
              ),
              Text(labelSpacing.toStringAsFixed(1)),
            ],
          ),

          const SizedBox(height: AppConstants.itemSpacing),

          // Track height slider
          Row(
            children: [
              Text(
                'Track Height: ',
                style: TextStyle(fontSize: AppConstants.captionFontSize),
              ),
              Expanded(
                child: Slider(
                  value: trackHeight,
                  min: 2.0,
                  max: 20.0,
                  divisions: 18,
                  label: trackHeight.toStringAsFixed(1),
                  onChanged: (value) => setState(() => _trackHeight = value),
                ),
              ),
              Text(trackHeight.toStringAsFixed(1)),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds the main slider with current settings
  Widget _buildSlider() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Text(
            'Current Settings: ${_tickmarkPosition.name} | Size: ${_tickmarkSize.toStringAsFixed(1)} | Spacing: ${_tickmarkSpacing.toStringAsFixed(1)} | Track: ${_trackHeight.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: AppConstants.captionFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.itemSpacing),
          CustomMultiThumbSlider<int>(
            values: _values,
            min: 0,
            max: 100,
            height: 16.0,
            trackHeight: _trackHeight,
            onChanged: (newValues) => setState(() => _values = newValues),
            showTickmarks: true,
            tickmarkColor: Colors.blue[600]!,
            tickmarkSize: _tickmarkSize,
            tickmarkInterval: 10,
            showTickmarkLabels: true,
            tickmarkLabelInterval: 20,
            tickmarkLabelColor: Colors.blue[800]!,
            tickmarkLabelSize: 12.0,
            tickmarkPosition: _tickmarkPosition,
            tickmarkSpacing: _tickmarkSpacing,
            labelSpacing: _labelSpacing,
            showTooltip: true,
            tooltipColor: Colors.blue[600]!,
            tooltipTextColor: Colors.white,
          ),
        ],
      ),
    );
  }

  /// Builds information about the current positioning
  Widget _buildInfo() {
    String description;
    String tip;

    switch (_tickmarkPosition) {
      case TickmarkPosition.above:
        description = 'Tickmarks appear above the track';
        tip =
            'Great for when you want tickmarks to be more prominent and not interfere with the track';
        break;
      case TickmarkPosition.below:
        description = 'Tickmarks appear below the track';
        tip = 'Traditional positioning that keeps tickmarks out of the way';
        break;
      case TickmarkPosition.onTrack:
        description = 'Tickmarks overlap with the track';
        tip = 'Compact design that saves vertical space';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.green[700], size: 16),
              const SizedBox(width: 8),
              Text(
                'Position: ${_tickmarkPosition.name}',
                style: TextStyle(
                  fontSize: AppConstants.bodyFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.itemSpacing),
          Text(
            description,
            style: TextStyle(
              fontSize: AppConstants.captionFontSize,
              color: Colors.green[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.itemSpacing),
          Text(
            tip,
            style: TextStyle(
              fontSize: AppConstants.captionFontSize,
              color: Colors.green[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
