import 'package:flutter/material.dart';
import '../constants.dart';

/// Widget for rendering tickmark labels
class TickmarkLabelWidget extends StatelessWidget {
  final double leftPosition;
  final String text;
  final Color color;
  final double fontSize;
  final VoidCallback? onTap;
  final bool isReadOnly;
  final TickmarkPosition tickmarkPosition;
  final double tickmarkSize;
  final double labelSpacing;
  final double availableHeight;
  final double trackHeight;
  final double tickmarkSpacing;

  const TickmarkLabelWidget({
    super.key,
    required this.leftPosition,
    required this.availableHeight,
    required this.trackHeight,
    required this.text,
    required this.color,
    required this.fontSize,
    this.onTap,
    required this.isReadOnly,
    required this.tickmarkPosition,
    required this.tickmarkSize,
    required this.labelSpacing,
    required this.tickmarkSpacing,
  });

  @override
  Widget build(BuildContext context) {
    double centerHeightPosition = availableHeight / 2;

    // Calculate vertical position based on tickmark position
    // Labels should be positioned relative to their tickmarks, not the track
    // The track is centered at y=0 in the Stack with Alignment.center

    switch (tickmarkPosition) {
      case TickmarkPosition.above:
        // Position labels above tickmarks (further up from track)
        // Use minimal spacing to keep labels close to tickmarks
        final double top =
            centerHeightPosition -
            (labelSpacing + tickmarkSize) -
            (trackHeight / 2) -
            labelSpacing -
            fontSize;
        return Positioned(
          left: leftPosition - 16, // Center the label relative to tickmark
          top: top,
          child: _buildLabelContent(),
        );

      case TickmarkPosition.below:
        // Position labels below tickmarks (further down from track)
        // Use bottom property for proper alignment with Stack center
        // Labels should be positioned below the tickmarks, so we need to add more space
        final double bottom =
            centerHeightPosition -
            (labelSpacing + tickmarkSize) -
            (trackHeight / 2) -
            labelSpacing -
            fontSize;
        return Positioned(
          left: leftPosition - 16, // Center the label relative to tickmark
          bottom: bottom,
          child: _buildLabelContent(),
        );

      case TickmarkPosition.onTrack:
        // Position labels below the track (since tickmarks are on track)
        // Track is centered at y=0, so go down from there
        final double top = (tickmarkSize / 2) + labelSpacing + 20;
        return Positioned(
          left: leftPosition - 16, // Center the label relative to tickmark
          top: top,
          child: _buildLabelContent(),
        );
    }
  }

  Widget _buildLabelContent() {
    return GestureDetector(
      onTap: isReadOnly ? null : onTap,
      child: SizedBox(
        width: 40,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
