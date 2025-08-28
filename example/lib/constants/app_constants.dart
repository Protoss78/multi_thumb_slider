import 'package:flutter/material.dart';

/// Application-wide constants for the Multi-Thumb Slider Example app
class AppConstants {
  // App Information
  static const String appTitle = 'Multi-Thumb Slider Examples';
  static const String fontFamily = 'Inter';

  // Layout Constants
  static const double defaultPadding = 24.0;
  static const double cardPadding = 20.0;
  static const double sectionSpacing = 20.0;
  static const double itemSpacing = 8.0;
  static const double largeSpacing = 20.0;

  // Typography
  static const double titleFontSize = 28.0;
  static const double cardTitleFontSize = 20.0;
  static const double bodyFontSize = 16.0;
  static const double captionFontSize = 14.0;
  static const double smallFontSize = 12.0;

  // Colors
  static const Color primaryColor = Colors.teal;
  static final Color backgroundColor = Colors.grey[100]!;
  static final Color cardBackgroundColor = Colors.white;
  static const Color textPrimaryColor = Colors.black87;
  static final Color textSecondaryColor = Colors.grey[700]!;
  static final Color textCaptionColor = Colors.grey[600]!;

  // Slider Defaults
  static const double defaultSliderHeight = 45.0;
  static const double defaultThumbRadius = 14.0;
  static const double largeThumbRadius = 18.0;
  static const double customSliderHeight = 60.0;

  // Animation
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  // Elevations
  static const double appBarElevation = 4.0;
  static const double cardElevation = 2.0;
}

/// Color schemes for different slider types
class SliderColorSchemes {
  static const List<Color> defaultRangeColors = [
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.redAccent,
  ];

  static final List<Color> priceRangeColors = [
    Colors.green[100]!,
    Colors.yellow[100]!,
    Colors.orange[100]!,
    Colors.red[100]!,
  ];

  static final List<Color> customRangeColors = [Colors.blue[100]!, Colors.pink[100]!, Colors.red[100]!];

  // Dan Rank Colors
  static final Color juniorDanColor = Colors.brown.shade600;
  static final Color intermediateDanColor = Colors.red.shade600;
  static final Color seniorDanColor = Colors.purple.shade600;
  static const Color masterDanColor = Colors.black;

  // Tooltip Colors
  static final Color defaultTooltipColor = Colors.teal.shade700;
  static final Color priceTooltipColor = Colors.green.shade700;
  static final Color weightTooltipColor = Colors.purple.shade700;
  static final Color danTooltipColor = Colors.orange.shade700;
  static final Color customTooltipColor = Colors.blue.shade700;
}

/// Example data for demonstrations
class ExampleData {
  // Basic int slider
  static const List<int> basicIntValues = [20, 50, 80];
  static const int basicIntMin = 0;
  static const int basicIntMax = 100;

  // Double slider
  static const List<double> doubleValues = [20.5, 50.0, 80.7];
  static const double doubleMin = 0.0;
  static const double doubleMax = 100.0;

  // Price range
  static const List<int> priceValues = [10, 50, 100];
  static const int priceMin = 0;
  static const int priceMax = 200;

  // Weight classes
  static const List<int> weightValues = [60, 70, 80, 90];
  static const int weightMin = 50;
  static const int weightMax = 120;

  // Custom styling
  static const List<int> customValues = [30, 60, 90];

  // Read-only
  static const List<int> readOnlyValues = [25, 50, 75];
}

/// Formatting utilities
class Formatters {
  static String percentage(int value) => '$value%';
  static String price(int value) => '\$$value';
  static String weight(int value) => '${value}kg';
  static String custom(int value) => 'Value: $value';
  static String decimal(double value) => value.toStringAsFixed(2);
  static String decimalSingle(double value) => value.toStringAsFixed(1);
}
