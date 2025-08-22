import 'package:flutter/material.dart';

/// Widget for rendering range segments
class RangeSegmentWidget extends StatelessWidget {
  final double left;
  final double width;
  final Color color;
  final bool isFirst;
  final bool isLast;
  final double trackHeight;

  const RangeSegmentWidget({
    super.key,
    required this.left,
    required this.width,
    required this.color,
    required this.isFirst,
    required this.isLast,
    required this.trackHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      child: Container(
        height: trackHeight,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.horizontal(
            left: isFirst ? const Radius.circular(4) : Radius.zero,
            right: isLast ? const Radius.circular(4) : Radius.zero,
          ),
        ),
      ),
    );
  }
}
