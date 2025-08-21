import 'package:flutter/material.dart';

/// Widget for rendering tickmark labels
class TickmarkLabelWidget extends StatelessWidget {
  final double position;
  final String text;
  final Color color;
  final double fontSize;
  final VoidCallback? onTap;
  final bool isReadOnly;

  const TickmarkLabelWidget({
    super.key,
    required this.position,
    required this.text,
    required this.color,
    required this.fontSize,
    this.onTap,
    required this.isReadOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position - 16, // Adjusted to center relative to tickmark (position + 4 - 20 = position - 16)
      bottom: -5.0, // Position below tickmarks, closer to them
      child: GestureDetector(
        onTap: isReadOnly ? null : onTap,
        child: SizedBox(
          width: 40,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
