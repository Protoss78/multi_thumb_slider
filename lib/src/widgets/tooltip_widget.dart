import 'package:flutter/material.dart';

/// Widget for rendering tooltips
class TooltipWidget extends StatelessWidget {
  final double leftPosition;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  
  const TooltipWidget({
    super.key,
    required this.leftPosition,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.fontSize,
  });
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: leftPosition,
      top: -35,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
