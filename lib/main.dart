import 'package:flutter/material.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Thumb Slider Demo',
      theme: ThemeData(primarySwatch: Colors.teal, fontFamily: 'Inter'),
      home: const SliderDemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SliderDemoScreen extends StatefulWidget {
  const SliderDemoScreen({super.key});

  @override
  State<SliderDemoScreen> createState() => _SliderDemoScreenState();
}

class _SliderDemoScreenState extends State<SliderDemoScreen> {
  // Die Werte der Umbruchpunkte, z.B. für Gewichtsklassen oder Preisbereiche.
  List<double> _sliderValues = [20, 50, 80];
  final double _min = 0;
  final double _max = 100;

  @override
  Widget build(BuildContext context) {
    // Berechnet die Breiten der einzelnen Segmente für die Anzeige.
    List<double> segmentWidths = [];
    // Erster Bereich von min bis zum ersten Griff.
    segmentWidths.add(_sliderValues[0] - _min);
    // Bereiche zwischen den Griffen.
    for (int i = 0; i < _sliderValues.length - 1; i++) {
      segmentWidths.add(_sliderValues[i + 1] - _sliderValues[i]);
    }
    // Letzter Bereich vom letzten Griff bis max.
    segmentWidths.add(_max - _sliderValues.last);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Multi-Thumb Slider'),
        elevation: 4,
        backgroundColor: Colors.teal.shade700,
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Die Anzeige der berechneten Breiten der Segmente.
              Row(
                children: segmentWidths.map((width) {
                  return Expanded(
                    flex: (width * 100).toInt(), // Flex proportional zur Breite
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
              // Das benutzerdefinierte Slider-Widget.
              CustomMultiThumbSlider(
                values: _sliderValues,
                min: _min,
                max: _max,
                onChanged: (newValues) {
                  setState(() {
                    _sliderValues = newValues;
                  });
                },
              ),
              const SizedBox(height: 30),
              // Anzeige der aktuellen Werte der Griffe.
              Text(
                'Aktuelle Umbruchpunkte: ${_sliderValues.map((v) => v.toStringAsFixed(1)).join(", ")}',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
