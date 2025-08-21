import 'package:flutter/material.dart';

/// Widget for rendering tickmarks
class TickmarkWidget extends StatelessWidget {
  final double position;
  final double size;
  final Color color;
  final VoidCallback? onTap;
  final bool isReadOnly;
  
  const TickmarkWidget({
    super.key,
    required this.position,
    required this.size,
    required this.color,
    this.onTap,
    required this.isReadOnly,
  });
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position,
      top: 4.0,
      child: GestureDetector(
        onTap: isReadOnly ? null : onTap,
        child: Container(
          width: 8.0,
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
      ),
    );
  }
}
