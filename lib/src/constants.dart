import 'package:flutter/material.dart';

/// Enum for tickmark positioning relative to the track
enum TickmarkPosition {
  above, // Above the track
  below, // Below the track
  onTrack, // On the track (overlapping)
}

/// Constants for default values and styling used throughout the multi-thumb slider
class SliderConstants {
  // Default dimensions
  static const double defaultHeight = 45.0;
  static const double defaultThumbRadius = 14.0;
  static const double defaultTrackHeight = 8.0;
  static const double defaultTickmarkSize = 8.0;
  static const double defaultTickmarkLabelSize = 10.0;
  static const double defaultTooltipTextSize = 12.0;

  // Default tickmark positioning
  static const TickmarkPosition defaultTickmarkPosition =
      TickmarkPosition.below;
  static const double defaultTickmarkSpacing =
      8.0; // Space between track and track
  static const double defaultLabelSpacing =
      4.0; // Space between tickmarks and labels

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
