import 'package:flutter/material.dart';
import 'package:multi_thumb_range_slider/multi_thumb_range_slider.dart';
import '../../constants/app_constants.dart';

/// Read-only slider example demonstrating display-only mode
///
/// This widget shows:
/// - Slider in read-only mode (no interaction)
/// - Display of fixed values
/// - Visual indication of disabled state
/// - Use case for data visualization
class ReadOnlyExampleWidget extends StatelessWidget {
  const ReadOnlyExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSlider(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildValueDisplay(),
        const SizedBox(height: AppConstants.itemSpacing),
        _buildReadOnlyInfo(),
      ],
    );
  }

  /// Builds the read-only slider widget
  Widget _buildSlider() {
    return CustomMultiThumbSlider.withInt(
      values: ExampleData.readOnlyValues,
      min: ExampleData.basicIntMin,
      max: ExampleData.basicIntMax,
      readOnly: true, // Disables all interaction
      onChanged: (newValues) {
        // This callback is never called in read-only mode
      },
    );
  }

  /// Builds the values display
  Widget _buildValueDisplay() {
    return Text(
      'Read-only values: ${ExampleData.readOnlyValues.join(", ")}',
      style: TextStyle(fontSize: AppConstants.bodyFontSize, color: AppConstants.textSecondaryColor),
    );
  }

  /// Builds information about read-only mode
  Widget _buildReadOnlyInfo() {
    return Column(
      children: [
        _buildInfoCard(),
        const SizedBox(height: AppConstants.itemSpacing),
        _buildUseCases(),
      ],
    );
  }

  /// Builds the main information card
  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange[300]!),
      ),
      child: Row(
        children: [
          Icon(Icons.lock, color: Colors.orange[800], size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Thumbs cannot be dragged in read-only mode',
              style: TextStyle(
                fontSize: AppConstants.smallFontSize,
                color: Colors.orange[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds use cases information
  Widget _buildUseCases() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.visibility, color: Colors.grey[700], size: 16),
              const SizedBox(width: 8),
              Text(
                'Read-Only Use Cases',
                style: TextStyle(
                  fontSize: AppConstants.captionFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildUseCasesList(),
        ],
      ),
    );
  }

  /// Builds the list of use cases
  Widget _buildUseCasesList() {
    final useCases = [
      'Data visualization and reporting',
      'Historical data display',
      'Configuration previews',
      'Status indicators',
      'Dashboard components',
      'Read-only settings display',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: useCases.map((useCase) => _buildUseCaseItem(useCase)).toList(),
    );
  }

  /// Builds an individual use case item
  Widget _buildUseCaseItem(String useCase) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 4,
            height: 4,
            decoration: BoxDecoration(color: Colors.grey[600], shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              useCase,
              style: TextStyle(fontSize: AppConstants.smallFontSize, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
