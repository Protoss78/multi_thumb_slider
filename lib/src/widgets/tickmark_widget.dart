import 'package:flutter/material.dart';
import '../constants.dart';

/// Widget for rendering tickmarks
class TickmarkWidget extends StatelessWidget {
  final double leftPosition;
  final double size;
  final Color color;
  final VoidCallback? onTap;
  final bool isReadOnly;
  final TickmarkPosition tickmarkPosition;
  final double spacing;
  final double availableHeight;
  final double trackHeight;

  const TickmarkWidget({
    super.key,
    required this.leftPosition,
    required this.availableHeight,
    required this.trackHeight,
    required this.size,
    required this.color,
    this.onTap,
    required this.isReadOnly,
    required this.tickmarkPosition,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    double centerHeightPosition = availableHeight / 2;

    // Calculate vertical position based on tickmark position
    // The track is centered at y=0 in the Stack with Alignment.center
    // We need to use different positioning strategies for each case

    switch (tickmarkPosition) {
      case TickmarkPosition.above:
        // Position above the track using top property
        // Negative values go up from the center
        final double top =
            centerHeightPosition - ((trackHeight / 2) + spacing + size);
        return Positioned(
          left: leftPosition,
          top: top,
          child: _buildTickmarkContent(),
        );

      case TickmarkPosition.below:
        // Position below the track using bottom property
        // This ensures proper alignment with the Stack's center
        final double bottom =
            centerHeightPosition - (size + spacing) - (trackHeight / 2);
        return Positioned(
          left: leftPosition,
          bottom: bottom,
          child: _buildTickmarkContent(),
        );

      case TickmarkPosition.onTrack:
        // Center on the track using top property
        // Negative values center the tickmark on the track
        // Still unclear why +2 is needed
        final double top =
            centerHeightPosition - ((size) / 2) - (trackHeight / 2) + 2;
        return Positioned(
          left: leftPosition,
          top: top,
          child: _buildTickmarkContent(),
        );
    }
  }

  Widget _buildTickmarkContent() {
    return GestureDetector(
      onTap: isReadOnly ? null : onTap,
      child: Container(
        width: size,
        height: size + 4.0,
        alignment: Alignment.center,
        child: Container(
          width: 2.0,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(1.0),
          ),
        ),
      ),
    );
  }
}
