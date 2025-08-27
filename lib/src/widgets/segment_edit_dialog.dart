import 'package:flutter/material.dart';

/// A dialog widget for editing segment descriptions
class SegmentEditDialog extends StatefulWidget {
  /// The current description of the segment
  final String? currentDescription;

  /// The default description that would be generated
  final String defaultDescription;

  /// The segment index being edited
  final int segmentIndex;

  /// Creates a segment edit dialog
  const SegmentEditDialog({
    super.key,
    required this.currentDescription,
    required this.defaultDescription,
    required this.segmentIndex,
  });

  /// Shows the segment edit dialog and returns the result
  static Future<String?> show({
    required BuildContext context,
    required String? currentDescription,
    required String defaultDescription,
    required int segmentIndex,
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) => SegmentEditDialog(
        currentDescription: currentDescription,
        defaultDescription: defaultDescription,
        segmentIndex: segmentIndex,
      ),
    );
  }

  @override
  State<SegmentEditDialog> createState() => _SegmentEditDialogState();
}

class _SegmentEditDialogState extends State<SegmentEditDialog> {
  late TextEditingController _controller;
  bool _isUsingCustomDescription = false;
  bool _wasResetToDefault = false;

  @override
  void initState() {
    super.initState();
    _isUsingCustomDescription =
        widget.currentDescription != null &&
        widget.currentDescription!.isNotEmpty;
    _controller = TextEditingController(
      text: _isUsingCustomDescription
          ? widget.currentDescription
          : widget.defaultDescription,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetToDefault() {
    setState(() {
      _isUsingCustomDescription = false;
      _wasResetToDefault = true;
      _controller.text = widget.defaultDescription;
    });
  }

  void _enableCustomDescription() {
    setState(() {
      _isUsingCustomDescription = true;
      _wasResetToDefault = false; // Clear reset flag when switching to custom
      // Keep the current text but mark it as custom
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600; // Mobile/small tablet breakpoint

    // Calculate dialog width based on screen size
    final dialogWidth = isSmallScreen
        ? screenWidth *
              0.9 // 90% width on mobile
        : screenWidth < 900
        ? 500.0 // Fixed 500px on medium screens
        : 600.0; // Fixed 600px on large screens

    return AlertDialog(
      title: Text('Edit Segment ${widget.segmentIndex + 1} Description'),
      content: SizedBox(
        width: dialogWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current segment: ${widget.defaultDescription}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            // Responsive layout for description type and reset button
            isSmallScreen
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isUsingCustomDescription
                            ? 'Custom Description:'
                            : 'Default Description:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: _resetToDefault,
                          icon: const Icon(Icons.refresh, size: 16),
                          label: const Text('Reset to Default'),
                          style: TextButton.styleFrom(
                            foregroundColor: _isUsingCustomDescription
                                ? Colors.blue
                                : Colors.grey,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        _isUsingCustomDescription
                            ? 'Custom Description:'
                            : 'Default Description:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: _resetToDefault,
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text('Reset to Default'),
                        style: TextButton.styleFrom(
                          foregroundColor: _isUsingCustomDescription
                              ? Colors.blue
                              : Colors.grey,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter segment description...',
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              maxLines: null,
              enabled: true, // Always enabled
              onChanged: (_) {
                if (!_isUsingCustomDescription) {
                  _enableCustomDescription();
                }
              },
              onTap: () {
                if (!_isUsingCustomDescription) {
                  _enableCustomDescription();
                }
              },
            ),
            if (!_isUsingCustomDescription)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Start typing to customize this description, or use "Reset to Default" to restore the original text',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final description = _controller.text.trim();
            if (description.isEmpty) {
              // Return null for empty description (will use default)
              Navigator.of(context).pop(null);
            } else if (_wasResetToDefault) {
              // Return empty string to indicate reset to default
              Navigator.of(context).pop('');
            } else if (!_isUsingCustomDescription) {
              // Return null if using default description unchanged
              Navigator.of(context).pop(null);
            } else {
              // Return the custom description
              Navigator.of(context).pop(description);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
