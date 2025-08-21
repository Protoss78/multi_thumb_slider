import 'package:flutter/material.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

// Example enum for demonstration
enum Difficulty { easy, medium, hard, expert }

void main() {
  runApp(const MultiThumbSliderExampleApp());
}

class MultiThumbSliderExampleApp extends StatelessWidget {
  const MultiThumbSliderExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Thumb Slider Examples',
      theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'Inter', useMaterial3: true),
      home: const ExamplesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExamplesScreen extends StatefulWidget {
  const ExamplesScreen({super.key});

  @override
  State<ExamplesScreen> createState() => _ExamplesScreenState();
}

class _ExamplesScreenState extends State<ExamplesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Thumb Slider Examples'),
        elevation: 4,
        backgroundColor: Colors.teal.shade700,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Examples',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // Basic Example (using int)
            _buildExampleCard(
              title: 'Basic Multi-Thumb Slider (Int)',
              description: 'Simple slider with three thumbs for range selection using int values',
              child: const BasicExample(),
            ),

            const SizedBox(height: 20),

            // Double Example
            _buildExampleCard(
              title: 'Double Values Slider',
              description: 'Slider using double values for precise measurements',
              child: const DoubleExample(),
            ),

            const SizedBox(height: 20),

            // Enum Example
            _buildExampleCard(
              title: 'Enum Values Slider',
              description: 'Slider using enum values for categorical selection',
              child: const EnumExample(),
            ),

            const SizedBox(height: 20),

            // Price Range Example
            _buildExampleCard(
              title: 'Price Range Selector',
              description: 'E-commerce style price range with custom colors',
              child: const PriceRangeExample(),
            ),

            const SizedBox(height: 20),

            // Weight Class Example
            _buildExampleCard(
              title: 'Weight Class Selector',
              description: 'Sports/fitness application with larger thumbs',
              child: const WeightClassExample(),
            ),

            const SizedBox(height: 20),

            // Custom Styling Example
            _buildExampleCard(
              title: 'Custom Styling',
              description: 'Fully customized appearance and colors',
              child: const CustomStylingExample(),
            ),

            const SizedBox(height: 20),

            // Read-Only Example
            _buildExampleCard(
              title: 'Read-Only Mode',
              description: 'Display-only slider with disabled interaction',
              child: const ReadOnlyExample(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard({required String title, required String description, required Widget child}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(description, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}

class BasicExample extends StatefulWidget {
  const BasicExample({super.key});

  @override
  State<BasicExample> createState() => _BasicExampleState();
}

class _BasicExampleState extends State<BasicExample> {
  List<int> _values = [20, 50, 80];

  @override
  Widget build(BuildContext context) {
    List<double> segmentWidths = _calculateSegmentWidths(_values, 0, 100);

    return Column(
      children: [
        // Segment display
        Row(
          children: segmentWidths.map((width) {
            return Expanded(
              flex: (width * 100).toInt(),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.1),
                  border: Border.all(color: Colors.teal.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    width.toStringAsFixed(1),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal.shade900, fontSize: 16),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),

        // Slider
        CustomMultiThumbSlider.withInt(
          values: _values,
          min: 0,
          max: 100,
          onChanged: (newValues) {
            setState(() {
              _values = newValues;
            });
          },
        ),
        const SizedBox(height: 20),

        Text('Values: ${_values.join(", ")}', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      ],
    );
  }

  List<double> _calculateSegmentWidths(List<int> values, int min, int max) {
    List<double> segmentWidths = [];
    segmentWidths.add((values[0] - min).toDouble());
    for (int i = 0; i < values.length - 1; i++) {
      segmentWidths.add((values[i + 1] - values[i]).toDouble());
    }
    segmentWidths.add((max - values.last).toDouble());
    return segmentWidths;
  }
}

class DoubleExample extends StatefulWidget {
  const DoubleExample({super.key});

  @override
  State<DoubleExample> createState() => _DoubleExampleState();
}

class _DoubleExampleState extends State<DoubleExample> {
  List<double> _values = [20.5, 50.0, 80.7];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMultiThumbSlider<double>(
          values: _values,
          min: 0.0,
          max: 100.0,
          onChanged: (newValues) {
            setState(() {
              _values = newValues;
            });
          },
        ),
        const SizedBox(height: 20),

        Text(
          'Values: ${_values.map((v) => v.toStringAsFixed(1)).join(", ")}',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}

class EnumExample extends StatefulWidget {
  const EnumExample({super.key});

  @override
  State<EnumExample> createState() => _EnumExampleState();
}

class _EnumExampleState extends State<EnumExample> {
  List<Difficulty> _values = [Difficulty.easy, Difficulty.medium, Difficulty.hard];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMultiThumbSlider<Difficulty>(
          values: _values,
          min: Difficulty.easy,
          max: Difficulty.expert,
          onChanged: (newValues) {
            setState(() {
              _values = newValues;
            });
          },
        ),
        const SizedBox(height: 20),

        Text(
          'Values: ${_values.map((v) => v.name).join(", ")}',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}

class PriceRangeExample extends StatefulWidget {
  const PriceRangeExample({super.key});

  @override
  State<PriceRangeExample> createState() => _PriceRangeExampleState();
}

class _PriceRangeExampleState extends State<PriceRangeExample> {
  List<int> _values = [10, 50, 100];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMultiThumbSlider.withInt(
          values: _values,
          min: 0,
          max: 200,
          rangeColors: [Colors.green[100]!, Colors.yellow[100]!, Colors.orange[100]!, Colors.red[100]!],
          onChanged: (newValues) {
            setState(() {
              _values = newValues;
            });
          },
        ),
        const SizedBox(height: 20),

        Text('Price ranges: \$${_values.join(", ")}', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      ],
    );
  }
}

class WeightClassExample extends StatefulWidget {
  const WeightClassExample({super.key});

  @override
  State<WeightClassExample> createState() => _WeightClassExampleState();
}

class _WeightClassExampleState extends State<WeightClassExample> {
  List<int> _values = [60, 70, 80, 90];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMultiThumbSlider.withInt(
          values: _values,
          min: 50,
          max: 100,
          height: 60,
          thumbRadius: 18,
          onChanged: (newValues) {
            setState(() {
              _values = newValues;
            });
          },
        ),
        const SizedBox(height: 20),

        Text(
          'Weight classes: ${_values.map((v) => '${v}kg').join(", ")}',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }
}

class CustomStylingExample extends StatefulWidget {
  const CustomStylingExample({super.key});

  @override
  State<CustomStylingExample> createState() => _CustomStylingExampleState();
}

class _CustomStylingExampleState extends State<CustomStylingExample> {
  List<int> _values = [30, 60, 90];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomMultiThumbSlider.withInt(
          values: _values,
          min: 0,
          max: 100,
          trackColor: Colors.grey[300]!,
          rangeColors: [Colors.blue[100]!, Colors.purple[100]!, Colors.pink[100]!, Colors.red[100]!],
          thumbColor: Colors.blue[600]!,
          thumbRadius: 16,
          height: 50,
          onChanged: (newValues) {
            setState(() {
              _values = newValues;
            });
          },
        ),
        const SizedBox(height: 20),

        Text('Custom values: ${_values.join(", ")}', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
      ],
    );
  }
}

class ReadOnlyExample extends StatelessWidget {
  const ReadOnlyExample({super.key});

  @override
  Widget build(BuildContext context) {
    const List<int> values = [25, 50, 75];

    return Column(
      children: [
        CustomMultiThumbSlider.withInt(
          values: values,
          min: 0,
          max: 100,
          readOnly: true, // Disables dragging
          onChanged: (newValues) {
            // This callback is not called in read-only mode
          },
        ),
        const SizedBox(height: 20),

        Text('Read-only values: ${values.join(", ")}', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.orange[100]!,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.orange[300]!),
          ),
          child: Text(
            'Thumbs cannot be dragged in read-only mode',
            style: TextStyle(fontSize: 12, color: Colors.orange[800]!, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
