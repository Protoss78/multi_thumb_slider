import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/src/widgets/thumb_widget.dart';
import 'package:multi_thumb_slider/src/widgets/range_segment_widget.dart';
import 'package:multi_thumb_slider/src/widgets/tickmark_widget.dart';
import 'package:multi_thumb_slider/src/widgets/tickmark_label_widget.dart';
import 'package:multi_thumb_slider/src/widgets/tooltip_widget.dart';

void main() {
  group('ThumbWidget Tests', () {
    testWidgets('renders with correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ThumbWidget(
              position: 0.5,
              color: Colors.blue,
              radius: 15.0,
              onPanUpdate: (details) {},
              onPanStart: (details) {},
              onPanEnd: (details) {},
            ),
          ),
        ),
      );

      // Verify the thumb renders
      expect(find.byType(GestureDetector), findsOneWidget);
      
      // Verify the thumb has the correct color and size
      final Container container = tester.widget(find.byType(Container));
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.blue));
      expect(decoration.shape, equals(BoxShape.circle));
    });

    testWidgets('handles pan gestures correctly', (WidgetTester tester) async {
      bool panStartCalled = false;
      bool panUpdateCalled = false;
      bool panEndCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ThumbWidget(
              position: 0.5,
              color: Colors.red,
              radius: 20.0,
              onPanStart: (details) => panStartCalled = true,
              onPanUpdate: (details) => panUpdateCalled = true,
              onPanEnd: (details) => panEndCalled = true,
            ),
          ),
        ),
      );

      // Simulate pan start
      await tester.startGesture(const Offset(100, 100));
      await tester.pump(); // Allow the gesture to be processed
      expect(panStartCalled, isTrue);

      // Simulate pan update
      await tester.moveBy(const Offset(50, 0));
      await tester.pump(); // Allow the gesture to be processed
      expect(panUpdateCalled, isTrue);

      // Simulate pan end
      await tester.endGesture();
      await tester.pump(); // Allow the gesture to be processed
      expect(panEndCalled, isTrue);
    });

    testWidgets('applies correct positioning', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: ThumbWidget(
                position: 0.75,
                color: Colors.green,
                radius: 10.0,
                onPanUpdate: (details) {},
                onPanStart: (details) {},
                onPanEnd: (details) {},
              ),
            ),
          ),
        ),
      );

      // The thumb should be positioned at 75% of the container width
      // Note: In a real test environment, we'd need to check the actual positioning
      // This test verifies the widget structure is correct
      expect(find.byType(ThumbWidget), findsOneWidget);
    });

    testWidgets('handles different radius values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ThumbWidget(
              position: 0.5,
              color: Colors.purple,
              radius: 25.0,
              onPanUpdate: (details) {},
              onPanStart: (details) {},
              onPanEnd: (details) {},
            ),
          ),
        ),
      );

      final Container container = tester.widget(find.byType(Container));
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.borderRadius, isNull); // Should be null for circle shape
    });
  });

  group('RangeSegmentWidget Tests', () {
    testWidgets('renders with correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RangeSegmentWidget(
              startPosition: 0.2,
              endPosition: 0.8,
              color: Colors.orange,
              height: 30.0,
            ),
          ),
        ),
      );

      // Verify the range segment renders
      expect(find.byType(Container), findsOneWidget);
      
      // Verify the container has the correct properties
      final Container container = tester.widget(find.byType(Container));
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.orange));
    });

    testWidgets('handles different height values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RangeSegmentWidget(
              startPosition: 0.0,
              endPosition: 1.0,
              color: Colors.blue,
              height: 50.0,
            ),
          ),
        ),
      );

      final Container container = tester.widget(find.byType(Container));
      expect(container.height, equals(50.0));
    });

    testWidgets('handles edge positions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RangeSegmentWidget(
              startPosition: 0.0,
              endPosition: 0.0,
              color: Colors.red,
              height: 20.0,
            ),
          ),
        ),
      );

      // Should render even with zero-width range
      expect(find.byType(RangeSegmentWidget), findsOneWidget);
    });
  });

  group('TickmarkWidget Tests', () {
    testWidgets('renders with correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TickmarkWidget(
              position: 0.5,
              color: Colors.grey,
              height: 15.0,
            ),
          ),
        ),
      );

      // Verify the tickmark renders
      expect(find.byType(Container), findsOneWidget);
      
      // Verify the container has the correct properties
      final Container container = tester.widget(find.byType(Container));
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.grey));
      expect(container.height, equals(15.0));
    });

    testWidgets('handles different positions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TickmarkWidget(
              position: 0.25,
              color: Colors.black,
              height: 10.0,
            ),
          ),
        ),
      );

      expect(find.byType(TickmarkWidget), findsOneWidget);
    });
  });

  group('TickmarkLabelWidget Tests', () {
    testWidgets('renders with correct text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TickmarkLabelWidget(
              position: 0.5,
              label: '50',
              textStyle: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      );

      // Verify the label renders
      expect(find.text('50'), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('applies custom text style', (WidgetTester tester) async {
      const customStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TickmarkLabelWidget(
              position: 0.5,
              label: 'Test',
              textStyle: customStyle,
            ),
          ),
        ),
      );

      final Text textWidget = tester.widget(find.byType(Text));
      expect(textWidget.style, equals(customStyle));
    });

    testWidgets('handles different label types', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TickmarkLabelWidget(
              position: 0.5,
              label: '100%',
              textStyle: const TextStyle(),
            ),
          ),
        ),
      );

      expect(find.text('100%'), findsOneWidget);
    });
  });

  group('TooltipWidget Tests', () {
    testWidgets('renders with correct content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TooltipWidget(
              position: 0.5,
              value: '75',
              backgroundColor: Colors.black87,
              textColor: Colors.white,
            ),
          ),
        ),
      );

      // Verify the tooltip renders
      expect(find.byType(Container), findsOneWidget);
      expect(find.text('75'), findsOneWidget);
    });

    testWidgets('applies custom styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TooltipWidget(
              position: 0.5,
              value: 'Test',
              backgroundColor: Colors.red,
              textColor: Colors.yellow,
            ),
          ),
        ),
      );

      final Container container = tester.widget(find.byType(Container));
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.red));
      
      final Text textWidget = tester.widget(find.byType(Text));
      expect(textWidget.style?.color, equals(Colors.yellow));
    });

    testWidgets('handles different value types', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TooltipWidget(
              position: 0.5,
              value: 'Custom Value',
              backgroundColor: Colors.blue,
              textColor: Colors.white,
            ),
          ),
        ),
      );

      expect(find.text('Custom Value'), findsOneWidget);
    });
  });

  group('Widget Integration Tests', () {
    testWidgets('multiple widgets work together', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ThumbWidget(
                  position: 0.3,
                  color: Colors.blue,
                  radius: 15.0,
                  onPanUpdate: (details) {},
                  onPanStart: (details) {},
                  onPanEnd: (details) {},
                ),
                RangeSegmentWidget(
                  startPosition: 0.0,
                  endPosition: 0.6,
                  color: Colors.green,
                  height: 20.0,
                ),
                TickmarkWidget(
                  position: 0.5,
                  color: Colors.grey,
                  height: 10.0,
                ),
                TickmarkLabelWidget(
                  position: 0.5,
                  label: '50',
                  textStyle: const TextStyle(),
                ),
                TooltipWidget(
                  position: 0.5,
                  value: '50',
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      );

      // Verify all widgets render
      expect(find.byType(ThumbWidget), findsOneWidget);
      expect(find.byType(RangeSegmentWidget), findsOneWidget);
      expect(find.byType(TickmarkWidget), findsOneWidget);
      expect(find.byType(TickmarkLabelWidget), findsOneWidget);
      expect(find.byType(TooltipWidget), findsOneWidget);
    });
  });

  group('Widget Edge Cases', () {
    testWidgets('handles extreme position values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ThumbWidget(
                  position: 0.0,
                  color: Colors.blue,
                  radius: 15.0,
                  onPanUpdate: (details) {},
                  onPanStart: (details) {},
                  onPanEnd: (details) {},
                ),
                ThumbWidget(
                  position: 1.0,
                  color: Colors.red,
                  radius: 15.0,
                  onPanUpdate: (details) {},
                  onPanStart: (details) {},
                  onPanEnd: (details) {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ThumbWidget), findsNWidgets(2));
    });

    testWidgets('handles zero dimensions gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                RangeSegmentWidget(
                  startPosition: 0.5,
                  endPosition: 0.5,
                  color: Colors.blue,
                  height: 0.0,
                ),
                TickmarkWidget(
                  position: 0.5,
                  color: Colors.grey,
                  height: 0.0,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(RangeSegmentWidget), findsOneWidget);
      expect(find.byType(TickmarkWidget), findsOneWidget);
    });
  });
}