# Changelog

All notable changes to the `multi_thumb_range_slider` package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.0+1] - 2025-08-25
### Fixed
- **README**: Fixed various issues in readme
- **dart code format**: Fixed minor formatting issues

## [1.3.0+1] - 2025-08-24

🎉 **Major Release**: This version introduces comprehensive segment description editing, enhanced visual features, advanced tickmark positioning, and extensive documentation improvements with animated examples.

**Key Highlights:**
- Interactive segment description editing with popup dialogs
- Advanced tickmark positioning system (above, below, on-track)
- Enhanced enum support with educational examples
- Comprehensive value formatting system
- Complete documentation overhaul with animated GIFs
- Real-world example applications

### Added
- **Custom Segment Descriptions**: New feature allowing users to customize segment descriptions
  - **Interactive Description Editing**: Tap segment cards to open a popup dialog for editing descriptions
  - **Reset to Default**: Button in popup dialog to reset custom descriptions to default values
  - **Visual Indicators**: Custom descriptions are underlined and show edit icons
  - **Persistent State**: Custom descriptions are maintained throughout slider interactions
- **Enhanced Tickmark System**: Advanced tickmark positioning and styling options
  - **Positioning Options**: `TickmarkPosition.above`, `TickmarkPosition.below`, `TickmarkPosition.onTrack`
  - **Spacing Controls**: `tickmarkSpacing` and `labelSpacing` for precise positioning
  - **Dynamic Sizing**: Configurable `tickmarkSize` and interval controls
- **Advanced Tooltip System**: Interactive tooltips with extensive customization
  - **Custom Colors**: `tooltipColor` and `tooltipTextColor` for branding
  - **Size Control**: `tooltipTextSize` for readability optimization
  - **Smart Positioning**: Automatic positioning to avoid edge clipping
- **Enhanced Enum Support**: Comprehensive enum slider implementation
  - **Convenience Constructor**: `CustomMultiThumbSlider.withEnum<T>()` for enum types
  - **Educational Examples**: Dan rank martial arts system with Japanese names
  - **Custom Display Names**: Extension methods for user-friendly enum labels
- **Value Formatting System**: Built-in and custom formatting support
  - **Percentage Formatter**: `(value) => '$value%'` for percentage displays
  - **Currency Formatter**: `(value) => '\$$value'` for price ranges
  - **Weight Formatter**: `(value) => '${value}kg'` for fitness applications
  - **Decimal Precision**: `value.toStringAsFixed(1)` for precise measurements
- **New Data Models**: `SliderSegment` and `SegmentDescription` classes for structured segment data
- **Segment Retrieval API**: New `getSegmentsWithDescriptions()` method to access all segments with values and custom descriptions
- **Description Change Callback**: New `onDescriptionChanged` callback parameter for responding to description edits

### Features
- **Segment Description Editing**:
  - `onDescriptionChanged`: Callback for when segment descriptions are modified
  - Popup dialog with text editing and reset functionality
  - Visual feedback for custom vs. default descriptions
- **Segment Data Access**:
  - `getSegmentsWithDescriptions()`: Returns list of `SliderSegment` objects with value ranges and descriptions
  - `SliderSegment<T>`: Data class containing start value, end value, and custom description
  - `SegmentDescription`: Helper class for managing segment descriptions
- **Improved UX**:
  - Tap-to-edit functionality on segment cards in edit mode
  - Clear visual distinction between custom and default descriptions
  - Non-destructive editing with easy reset to defaults

### Enhanced
- **Segment Edit Mode**: Extended existing segment edit functionality with description editing
- **Type Safety**: Full generic type support for new segment data structures and enum handling
- **State Management**: Efficient storage and management of custom segment descriptions
- **Factory Constructor Support**: Added `enableDescriptionEdit` parameter to `withInt` and `withEnum` factory constructors
- **Visual Design System**: Comprehensive styling options for tracks, thumbs, segments, and tooltips
- **Responsive Layout**: Improved responsive behavior for different screen sizes and orientations
- **Touch Interaction**: Enhanced touch targets and interaction feedback for mobile devices
- **Performance Optimization**: Improved rendering performance for complex multi-thumb configurations
- **Example Applications**: Real-world examples for e-commerce, sports, education, and data analysis use cases

### Fixed
- **Description Edit Independence**: Fixed issue where `enableDescriptionEdit` only worked when `enableSegmentEdit` was also enabled
  - Description editing now works independently of segment add/remove functionality
  - Edit icons are properly displayed when only description editing is enabled
  - Add/remove buttons are correctly hidden when only description editing is enabled
- **Responsive Dialog Width**: Fixed `SegmentEditDialog` taking full screen width on large displays
  - Mobile screens (< 600px): Uses 90% of screen width for optimal mobile experience
  - Medium screens (600-900px): Fixed 500px width for better desktop usability
  - Large screens (> 900px): Fixed 600px width for optimal content presentation

### Documentation
- **Comprehensive README Overhaul**: Complete rewrite with real-world examples from the example folder
  - **Quick Start Section**: Prominent placement of minimal setup examples with animated GIFs
  - **Visual Examples**: Animated GIF demonstrations for all major features
  - **Advanced Examples**: E-commerce price ranges, sports weight classes, martial arts rankings
  - **Feature Categorization**: Organized features into Visual, Interactive, and Advanced categories
- **Enhanced API Documentation**: Streamlined API reference with grouped parameters and clear descriptions
- **Use Case Gallery**: Comprehensive use cases for Data Analysis, E-commerce, Sports, and Education
- **Type Support Guide**: Clear documentation of int, double, enum, and custom type behaviors
- **Migration Examples**: Removed outdated migration guide and focused on current best practices
- **Asset Integration**: Added support for animated GIF assets to showcase features in action

### Examples
- **New Example Widgets**: Complete set of example widgets demonstrating all features
  - `BasicExampleWidget`: Integer slider with tickmarks, tooltips, and segments
  - `DoubleExampleWidget`: Decimal precision with width calculations
  - `DanRankExampleWidget`: Educational enum example with martial arts rankings
  - `PriceRangeExampleWidget`: E-commerce application with currency formatting
  - `WeightClassExampleWidget`: Sports application with weight units
  - `SegmentEditExampleWidget`: Interactive editing with independent mode toggles
  - `SegmentDisplayExampleWidget`: All segment display types with custom styling
  - `TickmarkPositioningExampleWidget`: Positioning options with interactive controls
- **Educational Content**: Dan rank system with Japanese names and ranking categories
- **Real-World Applications**: Practical examples for business and fitness applications
- **Interactive Features**: Toggle controls and live feedback in example applications

## [1.2.0] - 2025-08-10

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

## [1.1.1+3] - 2025-08-22

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

## [1.1.0+2] - 2025-08-21

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

## [1.0.0+1] - 2025-08-19

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
