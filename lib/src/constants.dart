import 'package:flutter/material.dart';

/// Constants for default values and styling used throughout the multi-thumb slider
class SliderConstants {
  // Default dimensions
  static const double defaultHeight = 45.0;
  static const double defaultThumbRadius = 14.0;
  static const double defaultTrackHeight = 8.0;
  static const double defaultTickmarkSize = 8.0;
  static const double defaultTickmarkLabelSize = 10.0;
  static const double defaultTooltipTextSize = 12.0;
  
  // Default intervals
  static const int defaultTickmarkInterval = 1;
  static const int defaultTickmarkLabelInterval = 5;
  
  // Default colors
  static const Color defaultTrackColor = Color(0xFFE0E0E0);
  static const Color defaultThumbColor = Colors.white;
  static const Color defaultTickmarkColor = Colors.grey;
  static const Color defaultTickmarkLabelColor = Colors.grey;
  static const Color defaultTooltipColor = Colors.black87;
  static const Color defaultTooltipTextColor = Colors.white;
  
  // Default range colors
  static const List<Color> defaultRangeColors = [
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.redAccent,
  ];
}
