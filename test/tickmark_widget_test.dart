import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/src/widgets/tickmark_widget.dart';
import 'package:multi_thumb_slider/src/constants.dart';
import 'test_config.dart';

void main() {
  group('TickmarkWidget Tests', () {
    const double testLeftPosition = 100.0;
    const double testSize = 8.0;
    const Color testColor = Colors.blue;
    const double testSpacing = 8.0;
    const double testAvailableHeight = 100.0;
    const double testTrackHeight = 8.0;
    const bool testIsReadOnly = false;

    // Mock callback for testing
    bool callbackCalled = false;
    void mockCallback() {
      callbackCalled = true;
    }

    Widget createTestWidget({
      double? leftPosition,
      double? size,
      Color? color,
      VoidCallback? onTap,
      bool? isReadOnly,
      TickmarkPosition? tickmarkPosition,
      double? spacing,
      double? availableHeight,
      double? trackHeight,
    }) {
      return TestConfig.createTestApp(
        child: Stack(
          children: [
            TickmarkWidget(
              leftPosition: leftPosition ?? testLeftPosition,
              size: size ?? testSize,
              color: color ?? testColor,
              onTap: onTap ?? mockCallback,
              isReadOnly: isReadOnly ?? testIsReadOnly,
              tickmarkPosition: tickmarkPosition ?? TickmarkPosition.below,
              spacing: spacing ?? testSpacing,
              availableHeight: availableHeight ?? testAvailableHeight,
              trackHeight: trackHeight ?? testTrackHeight,
            ),
          ],
        ),
      );
    }

    setUp(() {
      callbackCalled = false;
    });

    group('Widget Construction', () {
      test('Widget can be instantiated with all required parameters', () {
        expect(() {
          TickmarkWidget(
            leftPosition: testLeftPosition,
            size: testSize,
            color: testColor,
            onTap: mockCallback,
            isReadOnly: testIsReadOnly,
            tickmarkPosition: TickmarkPosition.below,
            spacing: testSpacing,
            availableHeight: testAvailableHeight,
            trackHeight: testTrackHeight,
          );
        }, returnsNormally);
      });

      test('Widget has correct constructor parameters', () {
        final widget = TickmarkWidget(
          leftPosition: testLeftPosition,
          size: testSize,
          color: testColor,
          onTap: mockCallback,
          isReadOnly: testIsReadOnly,
          tickmarkPosition: TickmarkPosition.below,
          spacing: testSpacing,
          availableHeight: testAvailableHeight,
          trackHeight: testTrackHeight,
        );

        expect(widget.leftPosition, equals(testLeftPosition));
        expect(widget.size, equals(testSize));
        expect(widget.color, equals(testColor));
        expect(widget.onTap, equals(mockCallback));
        expect(widget.isReadOnly, equals(testIsReadOnly));
        expect(widget.tickmarkPosition, equals(TickmarkPosition.below));
        expect(widget.spacing, equals(testSpacing));
        expect(widget.availableHeight, equals(testAvailableHeight));
        expect(widget.trackHeight, equals(testTrackHeight));
      });
    });

    group('Widget Rendering', () {
      testWidgets('Widget renders with correct basic structure', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.byType(TickmarkWidget), findsOneWidget);
        expect(find.byType(Positioned), findsOneWidget);
        expect(find.byType(GestureDetector), findsOneWidget);
        expect(find.byType(Container), findsNWidgets(2)); // Outer and inner containers
      });

      testWidgets('Widget renders with correct dimensions', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final outerContainerFinder = find.byType(Container).first;
        final outerContainer = tester.widget<Container>(outerContainerFinder);

        expect(outerContainer.constraints?.maxWidth, equals(testSize));
        expect(outerContainer.constraints?.maxHeight, equals(testSize + 4.0));
      });

      testWidgets('Widget renders with correct inner tickmark dimensions', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final innerContainerFinder = find.byType(Container).last;
        final innerContainer = tester.widget<Container>(innerContainerFinder);

        expect(innerContainer.constraints?.maxWidth, equals(2.0));
        expect(innerContainer.constraints?.maxHeight, equals(testSize));
      });

      testWidgets('Widget renders with correct color', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final innerContainerFinder = find.byType(Container).last;
        final innerContainer = tester.widget<Container>(innerContainerFinder);
        final decoration = innerContainer.decoration as BoxDecoration;

        expect(decoration.color, equals(testColor));
      });

      testWidgets('Widget renders with correct border radius', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final innerContainerFinder = find.byType(Container).last;
        final innerContainer = tester.widget<Container>(innerContainerFinder);
        final decoration = innerContainer.decoration as BoxDecoration;

        expect(decoration.borderRadius, equals(BorderRadius.circular(1.0)));
      });
    });

    group('Widget Positioning - Below Track', () {
      testWidgets('Widget positions correctly below track', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(tickmarkPosition: TickmarkPosition.below));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        expect(positioned.left, equals(testLeftPosition));
        expect(positioned.bottom, isNotNull);

        // Calculate expected bottom position
        final expectedBottom = (testAvailableHeight / 2) - (testSize + testSpacing) - (testTrackHeight / 2);
        expect(positioned.bottom, equals(expectedBottom));
      });

      testWidgets('Widget positioning below track changes with parameters', (WidgetTester tester) async {
        const customSize = 12.0;
        const customSpacing = 16.0;
        const customAvailableHeight = 200.0;
        const customTrackHeight = 16.0;

        await tester.pumpWidget(
          createTestWidget(
            tickmarkPosition: TickmarkPosition.below,
            size: customSize,
            spacing: customSpacing,
            availableHeight: customAvailableHeight,
            trackHeight: customTrackHeight,
          ),
        );

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        final expectedBottom = (customAvailableHeight / 2) - (customSize + customSpacing) - (customTrackHeight / 2);
        expect(positioned.bottom, equals(expectedBottom));
      });
    });

    group('Widget Positioning - Above Track', () {
      testWidgets('Widget positions correctly above track', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(tickmarkPosition: TickmarkPosition.above));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        expect(positioned.left, equals(testLeftPosition));
        expect(positioned.top, isNotNull);

        // Calculate expected top position
        final expectedTop = (testAvailableHeight / 2) - ((testTrackHeight / 2) + testSpacing + testSize);
        expect(positioned.top, equals(expectedTop));
      });

      testWidgets('Widget positioning above track changes with parameters', (WidgetTester tester) async {
        const customSize = 12.0;
        const customSpacing = 16.0;
        const customAvailableHeight = 200.0;
        const customTrackHeight = 16.0;

        await tester.pumpWidget(
          createTestWidget(
            tickmarkPosition: TickmarkPosition.above,
            size: customSize,
            spacing: customSpacing,
            availableHeight: customAvailableHeight,
            trackHeight: customTrackHeight,
          ),
        );

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        final expectedTop = (customAvailableHeight / 2) - ((customTrackHeight / 2) + customSpacing + customSize);
        expect(positioned.top, equals(expectedTop));
      });
    });

    group('Widget Positioning - On Track', () {
      testWidgets('Widget positions correctly on track', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(tickmarkPosition: TickmarkPosition.onTrack));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        expect(positioned.left, equals(testLeftPosition));
        expect(positioned.top, isNotNull);

        // Calculate expected top position (including the +2 offset mentioned in the code)
        final expectedTop = (testAvailableHeight / 2) - ((testSize) / 2) - (testTrackHeight / 2) + 2;
        expect(positioned.top, equals(expectedTop));
      });

      testWidgets('Widget positioning on track changes with parameters', (WidgetTester tester) async {
        const customSize = 12.0;
        const customAvailableHeight = 200.0;
        const customTrackHeight = 16.0;

        await tester.pumpWidget(
          createTestWidget(
            tickmarkPosition: TickmarkPosition.onTrack,
            size: customSize,
            availableHeight: customAvailableHeight,
            trackHeight: customTrackHeight,
          ),
        );

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        final expectedTop = (customAvailableHeight / 2) - ((customSize) / 2) - (customTrackHeight / 2) + 2;
        expect(positioned.top, equals(expectedTop));
      });
    });

    group('Widget Interaction', () {
      testWidgets('Widget responds to tap when not read-only', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(isReadOnly: false, onTap: mockCallback));

        final gestureDetectorFinder = find.byType(GestureDetector);
        expect(gestureDetectorFinder, findsOneWidget);

        // Tap the widget
        await tester.tap(gestureDetectorFinder);
        await tester.pump();

        expect(callbackCalled, isTrue);
      });

      testWidgets('Widget does not respond to tap when read-only', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(isReadOnly: true, onTap: mockCallback));

        final gestureDetectorFinder = find.byType(GestureDetector);
        expect(gestureDetectorFinder, findsOneWidget);

        // Tap the widget
        await tester.tap(gestureDetectorFinder);
        await tester.pump();

        expect(callbackCalled, isFalse);
      });

      testWidgets('Widget handles null onTap callback', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(isReadOnly: false, onTap: null));

        final gestureDetectorFinder = find.byType(GestureDetector);
        expect(gestureDetectorFinder, findsOneWidget);

        // Should not crash when tapped
        await tester.tap(gestureDetectorFinder);
        await tester.pump();

        // No callback to call, so this should pass
        expect(true, isTrue);
      });
    });

    group('Widget Customization', () {
      testWidgets('Widget renders with custom size', (WidgetTester tester) async {
        const customSize = 16.0;

        await tester.pumpWidget(createTestWidget(size: customSize));

        final outerContainerFinder = find.byType(Container).first;
        final outerContainer = tester.widget<Container>(outerContainerFinder);

        expect(outerContainer.constraints?.maxWidth, equals(customSize));
        expect(outerContainer.constraints?.maxHeight, equals(customSize + 4.0));

        final innerContainerFinder = find.byType(Container).last;
        final innerContainer = tester.widget<Container>(innerContainerFinder);

        expect(innerContainer.constraints?.maxHeight, equals(customSize));
      });

      testWidgets('Widget renders with custom color', (WidgetTester tester) async {
        const customColor = Colors.red;

        await tester.pumpWidget(createTestWidget(color: customColor));

        final innerContainerFinder = find.byType(Container).last;
        final innerContainer = tester.widget<Container>(innerContainerFinder);
        final decoration = innerContainer.decoration as BoxDecoration;

        expect(decoration.color, equals(customColor));
      });

      testWidgets('Widget renders with custom left position', (WidgetTester tester) async {
        const customLeftPosition = 200.0;

        await tester.pumpWidget(createTestWidget(leftPosition: customLeftPosition));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        expect(positioned.left, equals(customLeftPosition));
      });
    });

    group('Widget Behavior', () {
      testWidgets('Widget rebuilds when parameters change', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Initial state
        expect(find.byType(TickmarkWidget), findsOneWidget);

        // Change color and rebuild
        await tester.pumpWidget(createTestWidget(color: Colors.red));

        // Should still find the widget
        expect(find.byType(TickmarkWidget), findsOneWidget);

        // Check that color changed
        final innerContainerFinder = find.byType(Container).last;
        final innerContainer = tester.widget<Container>(innerContainerFinder);
        final decoration = innerContainer.decoration as BoxDecoration;
        expect(decoration.color, equals(Colors.red));
      });

      testWidgets('Widget maintains position when non-positioning parameters change', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(tickmarkPosition: TickmarkPosition.below));

        // Get initial position
        final initialPositionedFinder = find.byType(Positioned);
        final initialPositioned = tester.widget<Positioned>(initialPositionedFinder);
        final initialBottom = initialPositioned.bottom;

        // Change color and rebuild
        await tester.pumpWidget(createTestWidget(tickmarkPosition: TickmarkPosition.below, color: Colors.red));

        // Position should remain the same
        final newPositionedFinder = find.byType(Positioned);
        final newPositioned = tester.widget<Positioned>(newPositionedFinder);
        expect(newPositioned.bottom, equals(initialBottom));
      });
    });

    group('Edge Cases', () {
      testWidgets('Widget handles zero size', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(size: 0.0));

        final outerContainerFinder = find.byType(Container).first;
        final outerContainer = tester.widget<Container>(outerContainerFinder);

        expect(outerContainer.constraints?.maxWidth, equals(0.0));
        expect(outerContainer.constraints?.maxHeight, equals(4.0)); // 0 + 4.0

        final innerContainerFinder = find.byType(Container).last;
        final innerContainer = tester.widget<Container>(innerContainerFinder);

        expect(innerContainer.constraints?.maxHeight, equals(0.0));
      });

      testWidgets('Widget handles very large size', (WidgetTester tester) async {
        const largeSize = 100.0;

        await tester.pumpWidget(createTestWidget(size: largeSize));

        final outerContainerFinder = find.byType(Container).first;
        final outerContainer = tester.widget<Container>(outerContainerFinder);

        expect(outerContainer.constraints?.maxWidth, equals(largeSize));
        expect(outerContainer.constraints?.maxHeight, equals(largeSize + 4.0));

        final innerContainerFinder = find.byType(Container).last;
        final innerContainer = tester.widget<Container>(innerContainerFinder);

        expect(innerContainer.constraints?.maxHeight, equals(largeSize));
      });

      testWidgets('Widget handles zero spacing', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(tickmarkPosition: TickmarkPosition.below, spacing: 0.0));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        // Should still calculate position correctly with zero spacing
        final expectedBottom = (testAvailableHeight / 2) - (testSize + 0.0) - (testTrackHeight / 2);
        expect(positioned.bottom, equals(expectedBottom));
      });

      testWidgets('Widget handles zero available height', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(tickmarkPosition: TickmarkPosition.below, availableHeight: 0.0));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        // Should still calculate position correctly with zero height
        final expectedBottom = (0.0 / 2) - (testSize + testSpacing) - (testTrackHeight / 2);
        expect(positioned.bottom, equals(expectedBottom));
      });

      testWidgets('Widget handles zero track height', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(tickmarkPosition: TickmarkPosition.below, trackHeight: 0.0));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        // Should still calculate position correctly with zero track height
        final expectedBottom = (testAvailableHeight / 2) - (testSize + testSpacing) - (0.0 / 2);
        expect(positioned.bottom, equals(expectedBottom));
      });

      testWidgets('Widget handles negative left position', (WidgetTester tester) async {
        const negativePosition = -50.0;

        await tester.pumpWidget(createTestWidget(leftPosition: negativePosition));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        expect(positioned.left, equals(negativePosition));
      });

      testWidgets('Widget handles very large left position', (WidgetTester tester) async {
        const largePosition = 1000.0;

        await tester.pumpWidget(createTestWidget(leftPosition: largePosition));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);

        expect(positioned.left, equals(largePosition));
      });
    });
  });
}
