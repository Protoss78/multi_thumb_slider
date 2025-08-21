import 'package:flutter/material.dart';
import '../constants.dart';

/// Widget for rendering range segments
class RangeSegmentWidget extends StatelessWidget {
  final double left;
  final double width;
  final Color color;
  final bool isFirst;
  final bool isLast;
  
  const RangeSegmentWidget({
    super.key,
    required this.left,
    required this.width,
    required this.color,
    required this.isFirst,
    required this.isLast,
  });
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      child: Container(
        height: SliderConstants.defaultTrackHeight,
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
