# Changelog

All notable changes to the `multi_thumb_slider` package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.0] - 2025-01-XX

### Added
- **Segment Display Feature**: New built-in segment visualization above the slider
  - **Three Content Types**: Choose between "from-to range", "to range", or "width" display
  - **Extensive Styling**: Customize colors, padding, margin, border radius, text styling
  - **Value Formatting**: Integrates with custom value formatters for consistent display
  - **Generic Type Support**: Works with numeric types (int, double) with automatic type checking
- **Segment Edit Mode**: Interactive segment editing functionality
  - **Add Segments**: Click + buttons to dynamically add new segments to the slider
  - **Remove Segments**: Click × buttons on segment cards to remove segments
  - **Smart Positioning**: New segments are automatically positioned at optimal midpoints
  - **Callback System**: `onSegmentAdd` and `onSegmentRemove` callbacks for handling segment changes
  - **Validation**: Built-in validation prevents invalid configurations
- **Segment Calculator Utility**: New utility class for segment width calculations and label generation
  - **Add/Remove Operations**: Helper methods for calculating new thumb values during segment operations
  - **Validation Methods**: Ensure new values maintain proper order and bounds
  - **Type Safety**: Generic support for int, double, and other numeric types
- **Segment Display Widget**: Dedicated widget for rendering segment information
- **Enhanced Examples**: New examples showcasing segment display and edit mode features

### Features
- **Content Type Options**:
  - `SegmentContentType.fromToRange`: Shows "0 - 20", "20 - 50" format
  - `SegmentContentType.toRange`: Shows "- 20", "- 50" format (omitting "from")
  - `SegmentContentType.width`: Shows calculated segment widths (20, 30, etc.)
- **Segment Edit Mode Options**:
  - `enableSegmentEdit`: Boolean to enable/disable edit mode
  - `onSegmentAdd`: Callback for adding new segments with index parameter
  - `onSegmentRemove`: Callback for removing segments with index parameter
  - `segmentAddButtonColor`: Customizable color for add buttons
  - `segmentRemoveButtonColor`: Customizable color for remove buttons
  - `segmentButtonSize`: Adjustable size for edit buttons
- **Styling Customization**: Height, padding, margin, border radius, colors, text size/weight, borders, backgrounds
- **Automatic Integration**: Seamlessly integrates with existing slider functionality
- **Performance Optimized**: Efficient rendering with minimal impact on slider performance

### Changed
- **Example Updates**: Enhanced basic, double, and price range examples with segment display
- **Documentation**: Comprehensive examples and documentation for the new feature
- **API Consistency**: Maintains existing API while adding new segment display parameters

## [1.1.1+3] - 2025-08-26

### Added
- **Dynamic Track Height**: Added support for dynamic track height adjustments
- **Enhanced Tickmark Positioning**: Improved positioning system for tickmarks and labels
- **New Example Widget**: Added `tickmark_positioning_example_widget.dart` for demonstrating positioning features

### Fixed
- **Enum Positioning**: Fixed positioning issues with enum-based sliders
- **Thumb Position**: Corrected thumb positioning calculations for better accuracy
- **Dynamic Label Positioning**: Fixed dynamic label and tickmark positioning issues
- **Track Height Calculations**: Improved track height calculations for better visual consistency

### Changed
- **Widget Refactoring**: Refactored tickmark and label widgets for better performance
- **Position Calculator**: Enhanced position calculation logic for more accurate positioning
- **Example Updates**: Updated example widgets to showcase new features and fixes

## [1.1.0+2] - 2024-12-19

### Added
- **Generic Type Support**: The slider now supports various value types beyond just `double`
  - `int` values (new default type)
  - `double` values for precise measurements
  - `enum` values for categorical selection
  - Other comparable types
- **Convenience Constructor**: Added `CustomMultiThumbSlider.withInt()` constructor with default min/max values
- **Enhanced Type Safety**: Improved type checking and validation

### Changed
- **Default Type**: Changed default value type from `double` to `int`
- **Constructor Parameters**: `min` and `max` are now required parameters for the generic constructor
- **Type Constraints**: Removed `num` constraint to support enums and other types

### Breaking Changes
- The default constructor now requires explicit `min` and `max` parameters
- Use `CustomMultiThumbSlider.int()` for the previous behavior with default values
- All existing code using `CustomMultiThumbSlider()` will need to be updated

### Migration Guide
To migrate from version 1.0.0:

```dart
// Old code (v1.0.0)
CustomMultiThumbSlider(
  values: [20, 50, 80],
  onChanged: (values) => print(values),
)

// New code (v1.1.0) - Option 1: Use convenience constructor
CustomMultiThumbSlider.withInt(
  values: [20, 50, 80],
  onChanged: (values) => print(values),
)

// New code (v1.1.0) - Option 2: Use generic constructor with explicit min/max
CustomMultiThumbSlider<int>(
  values: [20, 50, 80],
  min: 0,
  max: 100,
  onChanged: (values) => print(values),
)
```

## [1.0.0+1] - 2024-12-19

### Added
- Initial release of the Multi-Thumb Slider package
- `CustomMultiThumbSlider` widget with the following features:
  - Multiple draggable thumbs on a single slider track
  - Automatic range constraint enforcement
  - Customizable appearance (colors, sizes, styling)
  - Responsive design support
  - Smooth drag-and-drop interactions
  - Visual feedback during interactions
  - Read-only mode for display-only usage

### Features
- **Multi-thumb support**: Set multiple values on a single slider
- **Range constraints**: Thumbs automatically respect boundaries of neighboring thumbs
- **Customizable styling**: Customize track colors, range colors, thumb appearance
- **Responsive design**: Adapts to different screen sizes and orientations
- **Intuitive interaction**: Drag-and-drop interface for each thumb
- **Performance optimized**: Efficient rendering and state management

### Technical Details
- Built with Flutter 3.9.0+
- Uses Material Design principles
- Supports all Flutter platforms (iOS, Android, Web, Desktop)
- Comprehensive parameter validation
- Well-documented API with examples
