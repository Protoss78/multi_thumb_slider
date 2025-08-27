import 'package:flutter/material.dart';

/// A separate, simple widget for the visual representation of a thumb.
class ThumbWidget extends StatelessWidget {
  final double radius;
  final Color color;
  final bool isDragged;
  final bool isReadOnly;

  const ThumbWidget({
    super.key,
    required this.radius,
    required this.color,
    required this.isDragged,
    required this.isReadOnly,
  });

  @override
  Widget build(BuildContext context) {
    // Thumb is slightly enlarged when being dragged
    final double currentRadius = isDragged ? radius * 1.2 : radius;

    // Use muted colors and reduced opacity when in read-only mode
    final Color thumbColor = isReadOnly ? color.withValues(alpha: 0.6) : color;
    final Color borderColor = isReadOnly
        ? Colors.grey.shade300
        : Colors.grey.shade400;
    final double borderWidth = isReadOnly ? 1.5 : 2.0;

    return Container(
      width: currentRadius * 2,
      height: currentRadius * 2,
      decoration: BoxDecoration(
        color: thumbColor,
        shape: BoxShape.circle,
        boxShadow: isReadOnly
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }
}
