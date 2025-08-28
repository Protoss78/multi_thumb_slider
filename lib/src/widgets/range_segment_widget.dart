import 'package:flutter/material.dart';

import 'open_segment_arrow_painter.dart';

/// Widget for rendering range segments
class RangeSegmentWidget extends StatelessWidget {
  final double left;
  final double width;
  final Color color;
  final bool isFirst;
  final bool isLast;
  final double trackHeight;
  final bool isOpenEnded;
  final bool isOpenStarted;

  const RangeSegmentWidget({
    super.key,
    required this.left,
    required this.width,
    required this.color,
    required this.isFirst,
    required this.isLast,
    required this.trackHeight,
    this.isOpenEnded = false,
    this.isOpenStarted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      child: SizedBox(
        height: trackHeight,
        width: width,
        child: Stack(
          clipBehavior: Clip.none, // Allow arrow to extend beyond track bounds
          children: [
            // Main segment container
            Container(
              height: trackHeight,
              width: width,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.horizontal(
                  left: (isFirst && !isOpenStarted) ? const Radius.circular(4) : Radius.zero,
                  right: (isLast && !isOpenEnded) ? const Radius.circular(4) : Radius.zero,
                ),
              ),
            ),
            // Arrows for open segments
            if ((isOpenEnded && isLast) || (isOpenStarted && isFirst))
              Positioned(
                left: isOpenStarted && isFirst ? -4 : null, // Position at the very start of the track
                right: isOpenEnded && isLast ? 4 : null, // Position at the very end of the track
                top: -(trackHeight / 2), // Center the double-height arrow on the track
                child: CustomPaint(
                  painter: OpenSegmentArrowPainter(
                    color: color,
                    trackHeight: trackHeight,
                    isOpenEnded: isOpenEnded && isLast,
                    isOpenStarted: isOpenStarted && isFirst,
                  ),
                  size: Size(trackHeight * 1.5, trackHeight * 2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
