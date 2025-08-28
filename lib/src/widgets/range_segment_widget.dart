import 'package:flutter/material.dart';

/// Custom painter for drawing arrows for open segments
class OpenSegmentArrowPainter extends CustomPainter {
  final Color color;
  final double trackHeight;
  final bool isOpenEnded;
  final bool isOpenStarted;

  OpenSegmentArrowPainter({
    required this.color,
    required this.trackHeight,
    this.isOpenEnded = false,
    this.isOpenStarted = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double arrowWidth = 16.0;
    final double centerY = size.height / 2;
    final double arrowHeight = trackHeight * 1.25; // Arrow extends trackHeight above and below center
    final Paint arrowPaint = Paint()
      ..color =
          color // Use the track color
      ..style = PaintingStyle.fill;

    if (isOpenEnded) {
      // Right-pointing arrow for open-ended segments
      final double endX = size.width;
      final Path rightArrowPath = Path()
        ..moveTo(endX, centerY - arrowHeight) // Top point of the arrow
        ..lineTo(endX + arrowWidth, centerY) // Tip of the arrow
        ..lineTo(endX, centerY + arrowHeight) // Bottom point of the arrow
        ..close();
      canvas.drawPath(rightArrowPath, arrowPaint);
    }

    if (isOpenStarted) {
      // Left-pointing arrow for open-started segments
      final double startX = arrowWidth / 2;
      final Path leftArrowPath = Path()
        ..moveTo(startX, centerY - arrowHeight) // Top point of the arrow
        ..lineTo(startX - arrowWidth, centerY) // Tip of the arrow (pointing left)
        ..lineTo(startX, centerY + arrowHeight) // Bottom point of the arrow
        ..close();
      canvas.drawPath(leftArrowPath, arrowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is! OpenSegmentArrowPainter ||
        oldDelegate.color != color ||
        oldDelegate.trackHeight != trackHeight ||
        oldDelegate.isOpenEnded != isOpenEnded ||
        oldDelegate.isOpenStarted != isOpenStarted;
  }
}

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
