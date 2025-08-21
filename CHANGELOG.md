# Changelog

All notable changes to the `multi_thumb_slider` package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
