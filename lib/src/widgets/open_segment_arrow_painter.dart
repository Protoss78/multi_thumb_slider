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
    final double arrowHeight =
        trackHeight * 1.25; // Arrow extends trackHeight above and below center
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
        ..lineTo(
          startX - arrowWidth,
          centerY,
        ) // Tip of the arrow (pointing left)
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
