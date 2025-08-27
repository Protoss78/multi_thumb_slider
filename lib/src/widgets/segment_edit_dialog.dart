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
    _isUsingCustomDescription = widget.currentDescription != null && widget.currentDescription!.isNotEmpty;
    _controller = TextEditingController(
      text: _isUsingCustomDescription ? widget.currentDescription : widget.defaultDescription,
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
              0.7 // 70% width on mobile (reduced from 90%)
        : screenWidth < 900
        ? 350.0 // Fixed 350px on medium screens (reduced from 500px)
        : 400.0; // Fixed 400px on large screens (reduced from 600px)

    return AlertDialog(
      content: SizedBox(
        width: dialogWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: '...', border: const OutlineInputBorder(), labelText: '...'),
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, size: 16),
                  label: const Text(''),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _resetToDefault,
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text(''),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
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
                  icon: const Icon(Icons.save, size: 16),
                  label: const Text(''),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
