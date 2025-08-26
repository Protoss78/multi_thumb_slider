# Multi Thumb Slider

A customizable Flutter widget that provides a multi-thumb slider with draggable thumbs for defining ranges, breakpoints, or multiple selection points.

<!-- Trigger deployment -->
## 🚀 Live Example

Try the interactive example app: **[Live Demo](https://protoss78.github.io/multi_thumb_slider/)**

The live demo showcases all the features of the multi-thumb slider with interactive examples you can test in your browser.

**Having issues with the live demo?** Check out our [Debug Page](https://protoss78.github.io/multi_thumb_slider/debug.html) to troubleshoot common problems.

## Features

- **Multiple Thumbs**: Set multiple values on a single slider track
- **Draggable Interface**: Intuitive drag-and-drop interaction for each thumb
- **Range Constraints**: Thumbs automatically respect boundaries of neighboring thumbs
- **Generic Type Support**: Use with `int`, `double`, `enum`, or other comparable types
- **Customizable Appearance**: Customize colors, sizes, and styling
- **Responsive Design**: Adapts to different screen sizes and orientations
- **Smooth Animations**: Visual feedback during interactions
- **Segment Display**: Built-in segment visualization with customizable content types and styling

## Getting Started

### Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  multi_thumb_slider: ^1.0.0
```

### Basic Usage

#### With Int Values (Default)

```dart
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<int> _values = [20, 50, 80];

  @override
  Widget build(BuildContext context) {
    return CustomMultiThumbSlider.withInt(
      values: _values,
      min: 0,
      max: 100,
      onChanged: (newValues) {
        setState(() {
          _values = newValues;
        });
      },
    );
  }
}
```

#### With Double Values

```dart
List<double> _values = [20.5, 50.0, 80.7];

CustomMultiThumbSlider<double>(
  values: _values,
  min: 0.0,
  max: 100.0,
  onChanged: (newValues) {
    setState(() {
      _values = newValues;
    });
  },
)
```

#### With Enum Values

```dart
enum Difficulty { easy, medium, hard, expert }

List<Difficulty> _values = [Difficulty.easy, Difficulty.medium, Difficulty.hard];

CustomMultiThumbSlider<Difficulty>(
  values: _values,
  min: Difficulty.easy,
  max: Difficulty.expert,
  onChanged: (newValues) {
    setState(() {
      _values = newValues;
    });
  },
)
```

## Segment Display Feature

The multi-thumb slider now includes a built-in segment display feature that shows visual representations of the segments created by your slider values. This feature is optional and highly customizable.

### Enabling Segment Display

```dart
CustomMultiThumbSlider.withInt(
  values: [20, 50, 80],
  min: 0,
  max: 100,
  onChanged: (newValues) => setState(() => _values = newValues),
  // Enable segment display
  showSegments: true,
  segmentContentType: SegmentContentType.fromToRange,
)
```

### Content Type Options

The segment display supports three different ways to show segment information:

#### 1. From-To Range Display
Shows the complete range of each segment (e.g., "0 - 20", "20 - 50", "50 - 100"):

```dart
CustomMultiThumbSlider.withInt(
  values: [20, 50, 80],
  showSegments: true,
  segmentContentType: SegmentContentType.fromToRange,
  onChanged: (newValues) => setState(() => _values = newValues),
)
```

#### 2. To Range Display
Shows only the "to" value, omitting the "from" (e.g., "- 20", "- 50", "- 100"):

```dart
CustomMultiThumbSlider.withInt(
  values: [20, 50, 80],
  showSegments: true,
  segmentContentType: SegmentContentType.toRange,
  onChanged: (newValues) => setState(() => _values = newValues),
)
```

#### 3. Width Display
Shows the calculated width of each segment (e.g., "20", "30", "20"):

```dart
CustomMultiThumbSlider.withInt(
  values: [20, 50, 80],
  showSegments: true,
  segmentContentType: SegmentContentType.width,
  onChanged: (newValues) => setState(() => _values = newValues),
)
```

### Styling Customization

The segment display offers extensive styling options:

```dart
CustomMultiThumbSlider.withInt(
  values: [20, 50, 80],
  showSegments: true,
  segmentContentType: SegmentContentType.fromToRange,
  // Styling options
  segmentHeight: 70,
  segmentCardPadding: 12,
  segmentCardMargin: 4,
  segmentCardBorderRadius: 12,
  segmentCardBackgroundColor: Colors.blue.shade100,
  segmentCardBorderColor: Colors.blue.shade400,
  segmentTextColor: Colors.blue.shade900,
  segmentTextSize: 14,
  segmentTextWeight: FontWeight.bold,
  showSegmentBorders: true,
  showSegmentBackgrounds: true,
  onChanged: (newValues) => setState(() => _values = newValues),
)
```

### Value Formatting Integration

Segment display integrates seamlessly with custom value formatters:

```dart
CustomMultiThumbSlider<double>(
  values: [20.5, 50.0, 80.7],
  showSegments: true,
  segmentContentType: SegmentContentType.fromToRange,
  valueFormatter: (value) => '${value.toStringAsFixed(1)}%',
  onChanged: (newValues) => setState(() => _values = newValues),
)
```

### Use Cases

- **Data Visualization**: Show segment breakdowns in charts and graphs
- **Range Selection**: Display selected ranges for better user understanding
- **Form Controls**: Provide visual feedback for multi-value inputs
- **E-commerce**: Show price ranges with currency formatting
- **Analytics**: Display data segments with custom formatting

## API Reference

### CustomMultiThumbSlider

The main widget that provides the multi-thumb slider functionality. It's generic and supports various value types.

#### Constructors

##### Generic Constructor

```dart
const CustomMultiThumbSlider<T>({
  Key? key,
  required List<T> values,
  required ValueChanged<List<T>> onChanged,
  required T min,
  required T max,
  double height = 45.0,
  Color trackColor = const Color(0xFFE0E0E0),
  List<Color> rangeColors = const [
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.redAccent
  ],
  Color thumbColor = Colors.white,
  double thumbRadius = 14.0,
  bool readOnly = false,
  // Segment Display Parameters
  bool showSegments = false,
  SegmentContentType segmentContentType = SegmentContentType.fromToRange,
  double segmentHeight = 60.0,
  double segmentCardPadding = 8.0,
  double segmentCardMargin = 2.0,
  double segmentCardBorderRadius = 8.0,
  Color segmentCardBackgroundColor = const Color(0xFFF5F5F5),
  Color segmentCardBorderColor = const Color(0xFFE0E0E0),
  Color segmentTextColor = const Color(0xFF424242),
  double segmentTextSize = 12.0,
  FontWeight segmentTextWeight = FontWeight.normal,
  bool showSegmentBorders = true,
  bool showSegmentBackgrounds = true,
})
```

##### Int Convenience Constructor

```dart
const CustomMultiThumbSlider.withInt({
  Key? key,
  required List<int> values,
  required ValueChanged<List<int>> onChanged,
  int min = 0,
  int max = 100,
  double height = 45.0,
  Color trackColor = const Color(0xFFE0E0E0),
  List<Color> rangeColors = const [
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.redAccent
  ],
  Color thumbColor = Colors.white,
  double thumbRadius = 14.0,
  bool readOnly = false,
})
```

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `values` | `List<T>` | **required** | Current values of the slider thumbs |
| `onChanged` | `ValueChanged<List<T>>` | **required** | Callback when any thumb value changes |
| `min` | `T` | **required** | Minimum value of the slider |
| `max` | `T` | **required** | Maximum value of the slider |
| `height` | `double` | `45.0` | Height of the slider track |
| `trackColor` | `Color` | `Color(0xFFE0E0E0)` | Background color of the slider track |
| `rangeColors` | `List<Color>` | `[green, blue, orange, red]` | Colors for range segments between thumbs |
| `thumbColor` | `Color` | `Colors.white` | Color of the thumb circles |
| `thumbRadius` | `double` | `14.0` | Radius of each thumb circle |
| `readOnly` | `bool` | `false` | Whether the slider is in read-only mode |

#### Segment Display Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `showSegments` | `bool` | `false` | Whether to display segment information above the slider |
| `segmentContentType` | `SegmentContentType` | `fromToRange` | Type of content to display in segment cards |
| `segmentHeight` | `double` | `60.0` | Height of the segment display |
| `segmentCardPadding` | `double` | `8.0` | Padding inside each segment card |
| `segmentCardMargin` | `double` | `2.0` | Margin between segment cards |
| `segmentCardBorderRadius` | `double` | `8.0` | Border radius of segment cards |
| `segmentCardBackgroundColor` | `Color` | `Color(0xFFF5F5F5)` | Background color of segment cards |
| `segmentCardBorderColor` | `Color` | `Color(0xFFE0E0E0)` | Border color of segment cards |
| `segmentTextColor` | `Color` | `Color(0xFF424242)` | Text color of segment content |
| `segmentTextSize` | `double` | `12.0` | Font size of segment text |
| `segmentTextWeight` | `FontWeight` | `FontWeight.normal` | Font weight of segment text |
| `showSegmentBorders` | `bool` | `true` | Whether to show segment borders |
| `showSegmentBackgrounds` | `bool` | `true` | Whether to show segment backgrounds |

## Examples

### Basic Range Slider (Int)

```dart
CustomMultiThumbSlider.withInt(
  values: [25, 75],
  min: 0,
  max: 100,
  onChanged: (values) => print('Range: ${values[0]} - ${values[1]}'),
)
```

### Double Values Slider

```dart
CustomMultiThumbSlider<double>(
  values: [25.5, 75.3],
  min: 0.0,
  max: 100.0,
  onChanged: (values) => print('Range: ${values[0]} - ${values[1]}'),
)
```

### Price Range Selector

```dart
CustomMultiThumbSlider.withInt(
  values: [10, 50, 100],
  min: 0,
  max: 200,
  rangeColors: [
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
  ],
  onChanged: (values) => print('Price ranges: $values'),
)
```

### Weight Class Selector

```dart
CustomMultiThumbSlider.withInt(
  values: [60, 70, 80, 90],
  min: 50,
  max: 100,
  height: 60,
  thumbRadius: 18,
  onChanged: (values) => print('Weight classes: $values'),
)
```

### Custom Styling

```dart
CustomMultiThumbSlider.withInt(
  values: [30, 60, 90],
  min: 0,
  max: 100,
  trackColor: Colors.grey[300]!,
  rangeColors: [
    Colors.blue[100]!,
    Colors.purple[100]!,
    Colors.pink[100]!,
    Colors.red[100]!,
  ],
  thumbColor: Colors.blue[600]!,
  thumbRadius: 16,
  height: 50,
  onChanged: (values) => setState(() => _values = values),
)
```

### Read-Only Mode

```dart
CustomMultiThumbSlider.withInt(
  values: [25, 50, 75],
  min: 0,
  max: 100,
  readOnly: true, // Disables dragging
  onChanged: (values) {}, // Not called in read-only mode
)
```

### Segment Display Examples

#### Basic Segment Display

```dart
CustomMultiThumbSlider.withInt(
  values: [20, 50, 80],
  showSegments: true,
  segmentContentType: SegmentContentType.fromToRange,
  onChanged: (values) => setState(() => _values = values),
)
```

#### Segment Display with Custom Styling

```dart
CustomMultiThumbSlider.withInt(
  values: [20, 50, 80],
  showSegments: true,
  segmentContentType: SegmentContentType.width,
  segmentHeight: 70,
  segmentCardBackgroundColor: Colors.purple.shade100,
  segmentCardBorderColor: Colors.purple.shade400,
  segmentTextColor: Colors.purple.shade900,
  segmentTextSize: 14,
  segmentTextWeight: FontWeight.bold,
  onChanged: (values) => setState(() => _values = values),
)
```

#### Price Range with Segment Display

```dart
CustomMultiThumbSlider.withInt(
  values: [10, 50, 100],
  min: 0,
  max: 200,
  showSegments: true,
  segmentContentType: SegmentContentType.toRange,
  valueFormatter: (value) => '\$$value',
  segmentCardBackgroundColor: Colors.green.shade50,
  segmentCardBorderColor: Colors.green.shade200,
  onChanged: (values) => setState(() => _values = values),
)
```

## Type Support

The slider supports various value types:

- **`int`**: Integer values (default, most common use case)
- **`double`**: Floating-point values for precise measurements
- **`enum`**: Enumeration values for categorical selection
- **Other numeric types**: Any type that extends `num`

### Type-Specific Behavior

- **Int values**: Automatically rounded to nearest integer
- **Double values**: Maintains precision during calculations
- **Enum values**: Treated as discrete categorical values
- **Mixed types**: Not supported - all values must be of the same type

## Use Cases

- **Price Range Selection**: E-commerce filters for price ranges
- **Weight Class Selection**: Sports or fitness applications
- **Time Range Selection**: Scheduling or booking applications
- **Score Thresholds**: Educational or gaming applications
- **Data Visualization**: Interactive charts and graphs with segment breakdowns
- **Form Controls**: Custom input widgets for multiple values
- **Difficulty Selection**: Game or application settings
- **Rating Systems**: Multi-point rating scales
- **Segment Analysis**: Show data segments with custom formatting and styling
- **Range Feedback**: Provide visual feedback for selected ranges
- **Analytics Dashboards**: Display data breakdowns in interactive interfaces

## Customization

### Colors

The `rangeColors` parameter allows you to define custom colors for each range segment. If there are more ranges than colors, the colors will cycle.

### Sizing

Adjust the `height` and `thumbRadius` parameters to match your design requirements. The widget automatically scales the track and thumb positioning accordingly.

### Constraints

The widget automatically enforces that:
- All values must be within the `min` and `max` range
- Thumbs cannot overlap or cross each other
- At least one value must be provided

## Troubleshooting

### White Page Issue

If you're seeing a white page when visiting the live demo:

1. **Check the Debug Page**: Visit [https://protoss78.github.io/multi_thumb_slider/debug.html](https://protoss78.github.io/multi_thumb_slider/debug.html) to see what files are missing
2. **Check Browser Console**: Open Developer Tools (F12) and look for error messages
3. **Clear Browser Cache**: Try refreshing with Ctrl+F5 or clear your browser cache
4. **Check Network Tab**: Look for failed requests to Flutter web files

### Common Issues

- **Missing Flutter.js**: The main Flutter web runtime file is not loading
- **Missing main.dart.js**: The compiled Dart code is not available
- **CORS Issues**: Some browsers may block local file loading
- **Build Incomplete**: The GitHub Action may not have completed successfully

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions, please:

1. Check the [existing issues](https://github.com/protoss78/multi_thumb_slider/issues)
2. Create a new issue with a detailed description
3. Include your Flutter version and device information

## Changelog

### 1.2.0
- **New Segment Display Feature**: Built-in segment visualization above the slider
  - Three content types: from-to range, to range, and width display
  - Extensive styling customization options
  - Integration with value formatters
  - Works with numeric types (int, double)
- **Enhanced Examples**: New examples showcasing segment display features
- **Improved Documentation**: Comprehensive examples and API documentation

### 1.1.0
- Added generic type support for `int`, `double`, `enum`, and other types
- Changed default type from `double` to `int`
- Added convenience constructor `CustomMultiThumbSlider.int()` with default min/max values
- Improved type safety and flexibility

### 1.0.0
- Initial release
- Multi-thumb slider with draggable interface
- Customizable appearance and styling
- Range constraint enforcement
- Responsive design support

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