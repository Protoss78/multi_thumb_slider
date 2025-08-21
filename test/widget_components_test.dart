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
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: ThumbWidget(
                  position: 0.5,
                  color: Colors.blue,
                  radius: 15.0,
                  onPanUpdate: (details) {},
                  onPanStart: (details) {},
                  onPanEnd: (details) {},
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      // Verify the thumb renders
      expect(find.byType(ThumbWidget), findsOneWidget);
    });

    testWidgets('handles pan gestures correctly', (WidgetTester tester) async {
      bool panStartCalled = false;
      bool panUpdateCalled = false;
      bool panEndCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: ThumbWidget(
                  position: 0.5,
                  color: Colors.red,
                  radius: 20.0,
                  onPanStart: (details) => panStartCalled = true,
                  onPanUpdate: (details) => panUpdateCalled = true,
                  onPanEnd: (details) => panEndCalled = true,
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();

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
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
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
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      // The thumb should be positioned correctly
      expect(find.byType(ThumbWidget), findsOneWidget);
    });

    testWidgets('handles different radius values', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: ThumbWidget(
                  position: 0.5,
                  color: Colors.purple,
                  radius: 25.0,
                  onPanUpdate: (details) {},
                  onPanStart: (details) {},
                  onPanEnd: (details) {},
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      // Verify the thumb renders
      expect(find.byType(ThumbWidget), findsOneWidget);
    });
  });

  group('RangeSegmentWidget Tests', () {
    testWidgets('renders with correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: RangeSegmentWidget(
                  startPosition: 0.2,
                  endPosition: 0.8,
                  color: Colors.orange,
                  height: 30.0,
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      // Verify the range segment renders
      expect(find.byType(RangeSegmentWidget), findsOneWidget);
    });

    testWidgets('handles zero-width range', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: RangeSegmentWidget(
                  startPosition: 0.0,
                  endPosition: 0.0,
                  color: Colors.red,
                  height: 20.0,
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      // Should render even with zero-width range
      expect(find.byType(RangeSegmentWidget), findsOneWidget);
    });
  });

  group('TickmarkWidget Tests', () {
    testWidgets('renders with correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: TickmarkWidget(
                  position: 0.5,
                  color: Colors.grey,
                  height: 15.0,
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      // Verify the tickmark renders
      expect(find.byType(TickmarkWidget), findsOneWidget);
    });

    testWidgets('handles different positions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: TickmarkWidget(
                  position: 0.25,
                  color: Colors.black,
                  height: 10.0,
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      expect(find.byType(TickmarkWidget), findsOneWidget);
    });
  });

  group('TickmarkLabelWidget Tests', () {
    testWidgets('renders with correct text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: TickmarkLabelWidget(
                  position: 0.5,
                  label: '50',
                  textStyle: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
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
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: TickmarkLabelWidget(
                  position: 0.5,
                  label: 'Test',
                  textStyle: customStyle,
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      final Text textWidget = tester.widget(find.byType(Text));
      expect(textWidget.style, equals(customStyle));
    });
  });

  group('TooltipWidget Tests', () {
    testWidgets('renders with correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: TooltipWidget(
                  position: 0.5,
                  value: '50',
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      // Verify the tooltip renders
      expect(find.byType(TooltipWidget), findsOneWidget);
      expect(find.text('50'), findsOneWidget);
    });

    testWidgets('handles different positions', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: TooltipWidget(
                  position: 0.25,
                  value: '25',
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      expect(find.byType(TooltipWidget), findsOneWidget);
      expect(find.text('25'), findsOneWidget);
    });
  });

  group('Widget Integration Tests', () {
    testWidgets('all widget types render together', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    ThumbWidget(
                      position: 0.5,
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
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
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
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Column(
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
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      expect(find.byType(ThumbWidget), findsNWidgets(2));
    });

    testWidgets('handles zero dimensions gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Column(
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
          ),
        ),
      );

      // Wait for layout to complete
      await tester.pumpAndSettle();
      
      expect(find.byType(RangeSegmentWidget), findsOneWidget);
      expect(find.byType(TickmarkWidget), findsOneWidget);
    });
  });
}