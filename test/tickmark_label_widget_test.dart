import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/src/widgets/tickmark_label_widget.dart';
import 'package:multi_thumb_slider/src/constants.dart';
import 'test_config.dart';

void main() {
  group('TickmarkLabelWidget Tests', () {
    const double testLeftPosition = 100.0;
    const String testText = '50';
    const Color testColor = Colors.blue;
    const double testFontSize = 12.0;
    const double testTickmarkSize = 8.0;
    const double testLabelSpacing = 4.0;
    const double testAvailableHeight = 100.0;
    const double testTrackHeight = 8.0;
    const double testTickmarkSpacing = 8.0;
    const bool testIsReadOnly = false;

    // Mock callback for testing
    bool callbackCalled = false;
    void mockCallback() {
      callbackCalled = true;
    }

    Widget createTestWidget({
      double? leftPosition,
      String? text,
      Color? color,
      double? fontSize,
      VoidCallback? onTap,
      bool? isReadOnly,
      TickmarkPosition? tickmarkPosition,
      double? tickmarkSize,
      double? labelSpacing,
      double? availableHeight,
      double? trackHeight,
      double? tickmarkSpacing,
    }) {
      return TestConfig.createTestApp(
        child: Stack(
          children: [
            TickmarkLabelWidget(
              leftPosition: leftPosition ?? testLeftPosition,
              text: text ?? testText,
              color: color ?? testColor,
              fontSize: fontSize ?? testFontSize,
              onTap: onTap ?? mockCallback,
              isReadOnly: isReadOnly ?? testIsReadOnly,
              tickmarkPosition: tickmarkPosition ?? TickmarkPosition.below,
              tickmarkSize: tickmarkSize ?? testTickmarkSize,
              labelSpacing: labelSpacing ?? testLabelSpacing,
              availableHeight: availableHeight ?? testAvailableHeight,
              trackHeight: trackHeight ?? testTrackHeight,
              tickmarkSpacing: tickmarkSpacing ?? testTickmarkSpacing,
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
          TickmarkLabelWidget(
            leftPosition: testLeftPosition,
            text: testText,
            color: testColor,
            fontSize: testFontSize,
            onTap: mockCallback,
            isReadOnly: testIsReadOnly,
            tickmarkPosition: TickmarkPosition.below,
            tickmarkSize: testTickmarkSize,
            labelSpacing: testLabelSpacing,
            availableHeight: testAvailableHeight,
            trackHeight: testTrackHeight,
            tickmarkSpacing: testTickmarkSpacing,
          );
        }, returnsNormally);
      });

      test('Widget has correct constructor parameters', () {
        final widget = TickmarkLabelWidget(
          leftPosition: testLeftPosition,
          text: testText,
          color: testColor,
          fontSize: testFontSize,
          onTap: mockCallback,
          isReadOnly: testIsReadOnly,
          tickmarkPosition: TickmarkPosition.below,
          tickmarkSize: testTickmarkSize,
          labelSpacing: testLabelSpacing,
          availableHeight: testAvailableHeight,
          trackHeight: testTrackHeight,
          tickmarkSpacing: testTickmarkSpacing,
        );

        expect(widget.leftPosition, equals(testLeftPosition));
        expect(widget.text, equals(testText));
        expect(widget.color, equals(testColor));
        expect(widget.fontSize, equals(testFontSize));
        expect(widget.onTap, equals(mockCallback));
        expect(widget.isReadOnly, equals(testIsReadOnly));
        expect(widget.tickmarkPosition, equals(TickmarkPosition.below));
        expect(widget.tickmarkSize, equals(testTickmarkSize));
        expect(widget.labelSpacing, equals(testLabelSpacing));
        expect(widget.availableHeight, equals(testAvailableHeight));
        expect(widget.trackHeight, equals(testTrackHeight));
        expect(widget.tickmarkSpacing, equals(testTickmarkSpacing));
      });
    });

    group('Widget Rendering', () {
      testWidgets('Widget renders with correct basic structure', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.byType(TickmarkLabelWidget), findsOneWidget);
        expect(find.byType(Positioned), findsOneWidget);
        expect(find.byType(GestureDetector), findsOneWidget);
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('Widget renders with correct text content', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.descendant(of: find.byType(TickmarkLabelWidget), matching: find.text(testText)), findsOneWidget);
      });

      testWidgets('Widget renders with correct text styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final textFinder = find.descendant(of: find.byType(TickmarkLabelWidget), matching: find.byType(Text));
        final text = tester.widget<Text>(textFinder);

        expect(text.textAlign, equals(TextAlign.center));
        expect(text.style?.color, equals(testColor));
        expect(text.style?.fontSize, equals(testFontSize));
        expect(text.style?.fontWeight, equals(FontWeight.w500));
      });

      testWidgets('Widget renders with correct SizedBox dimensions', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Find the SizedBox that's part of the TickmarkLabelWidget (not the test wrapper)
        final sizedBoxFinder = find.descendant(of: find.byType(TickmarkLabelWidget), matching: find.byType(SizedBox));
        final sizedBox = tester.widget<SizedBox>(sizedBoxFinder);

        expect(sizedBox.width, equals(40.0));
        expect(sizedBox.height, isNull); // Height is not constrained
      });
    });

    group('Widget Positioning - Below Track', () {
      testWidgets('Widget positions correctly below track', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(tickmarkPosition: TickmarkPosition.below));

        final positionedFinder = find.descendant(
          of: find.byType(TickmarkLabelWidget),
          matching: find.byType(Positioned),
        );
        final positioned = tester.widget<Positioned>(positionedFinder);

        expect(positioned.left, equals(testLeftPosition - 16)); // Centered relative to tickmark
        expect(positioned.bottom, isNotNull);

        // Calculate expected bottom position
        final expectedBottom =
            (testAvailableHeight / 2) -
            (testLabelSpacing + testTickmarkSize) -
            (testTrackHeight / 2) -
            testLabelSpacing -
            testFontSize;
        expect(positioned.bottom, equals(expectedBottom));
      });

      testWidgets('Widget positioning below track changes with parameters', (WidgetTester tester) async {
        const customTickmarkSize = 12.0;
        const customLabelSpacing = 8.0;
        const customAvailableHeight = 200.0;
        const customTrackHeight = 16.0;
        const customFontSize = 16.0;

        await tester.pumpWidget(
          createTestWidget(
            tickmarkPosition: TickmarkPosition.below,
            tickmarkSize: customTickmarkSize,
            labelSpacing: customLabelSpacing,
            availableHeight: customAvailableHeight,
            trackHeight: customTrackHeight,
            fontSize: customFontSize,
          ),
        );

        final positionedFinder = find.descendant(
          of: find.byType(TickmarkLabelWidget),
          matching: find.byType(Positioned),
        );
        final positioned = tester.widget<Positioned>(positionedFinder);

        final expectedBottom =
            (customAvailableHeight / 2) -
            (customLabelSpacing + customTickmarkSize) -
            (customTrackHeight / 2) -
            customLabelSpacing -
            customFontSize;
        expect(positioned.bottom, equals(expectedBottom));
      });
    });

    group('Widget Positioning - Above Track', () {
      testWidgets('Widget positions correctly above track', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(tickmarkPosition: TickmarkPosition.above));

        final positionedFinder = find.descendant(
          of: find.byType(TickmarkLabelWidget),
          matching: find.byType(Positioned),
        );
        final positioned = tester.widget<Positioned>(positionedFinder);

        expect(positioned.left, equals(testLeftPosition - 16)); // Centered relative to tickmark
        expect(positioned.top, isNotNull);

        // Calculate expected top position
        final expectedTop =
            (testAvailableHeight / 2) -
            (testLabelSpacing + testTickmarkSize) -
            (testTrackHeight / 2) -
            testLabelSpacing -
            testFontSize;
        expect(positioned.top, equals(expectedTop));
      });

      testWidgets('Widget positioning above track changes with parameters', (WidgetTester tester) async {
        const customTickmarkSize = 12.0;
        const customLabelSpacing = 8.0;
        const customAvailableHeight = 200.0;
        const customTrackHeight = 16.0;
        const customFontSize = 16.0;

        await tester.pumpWidget(
          createTestWidget(
            tickmarkPosition: TickmarkPosition.above,
            tickmarkSize: customTickmarkSize,
            labelSpacing: customLabelSpacing,
            availableHeight: customAvailableHeight,
            trackHeight: customTrackHeight,
            fontSize: customFontSize,
          ),
        );

        final positionedFinder = find.descendant(
          of: find.byType(TickmarkLabelWidget),
          matching: find.byType(Positioned),
        );
        final positioned = tester.widget<Positioned>(positionedFinder);

        final expectedTop =
            (customAvailableHeight / 2) -
            (customLabelSpacing + customTickmarkSize) -
            (customTrackHeight / 2) -
            customLabelSpacing -
            customFontSize;
        expect(positioned.top, equals(expectedTop));
      });
    });

    group('Widget Positioning - On Track', () {
      testWidgets('Widget positions correctly on track', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(tickmarkPosition: TickmarkPosition.onTrack));

        final positionedFinder = find.descendant(
          of: find.byType(TickmarkLabelWidget),
          matching: find.byType(Positioned),
        );
        final positioned = tester.widget<Positioned>(positionedFinder);

        expect(positioned.left, equals(testLeftPosition - 16)); // Centered relative to tickmark
        expect(positioned.top, isNotNull);

        // Calculate expected top position
        final expectedTop = (testTickmarkSize / 2) + testLabelSpacing + 20;
        expect(positioned.top, equals(expectedTop));
      });

      testWidgets('Widget positioning on track changes with parameters', (WidgetTester tester) async {
        const customTickmarkSize = 12.0;
        const customLabelSpacing = 8.0;

        await tester.pumpWidget(
          createTestWidget(
            tickmarkPosition: TickmarkPosition.onTrack,
            tickmarkSize: customTickmarkSize,
            labelSpacing: customLabelSpacing,
          ),
        );

        final positionedFinder = find.descendant(
          of: find.byType(TickmarkLabelWidget),
          matching: find.byType(Positioned),
        );
        final positioned = tester.widget<Positioned>(positionedFinder);

        final expectedTop = (customTickmarkSize / 2) + customLabelSpacing + 20;
        expect(positioned.top, equals(expectedTop));
      });
    });

    group('Gesture Handling', () {
      testWidgets('Widget responds to tap when not read-only', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(isReadOnly: false));

        final gestureDetectorFinder = find.descendant(
          of: find.byType(TickmarkLabelWidget),
          matching: find.byType(GestureDetector),
        );
        final gestureDetector = tester.widget<GestureDetector>(gestureDetectorFinder);

        expect(gestureDetector.onTap, isNotNull);
        expect(callbackCalled, isFalse);

        // Simulate tap
        await tester.tap(find.descendant(of: find.byType(TickmarkLabelWidget), matching: find.byType(Text)));
        expect(callbackCalled, isTrue);
      });

      testWidgets('Widget does not respond to tap when read-only', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(isReadOnly: true));

        final gestureDetectorFinder = find.descendant(
          of: find.byType(TickmarkLabelWidget),
          matching: find.byType(GestureDetector),
        );
        final gestureDetector = tester.widget<GestureDetector>(gestureDetectorFinder);

        expect(gestureDetector.onTap, isNull);
        expect(callbackCalled, isFalse);

        // Simulate tap - should not trigger callback
        await tester.tap(find.descendant(of: find.byType(TickmarkLabelWidget), matching: find.byType(Text)));
        expect(callbackCalled, isFalse);
      });

      testWidgets('Widget handles null onTap callback gracefully', (WidgetTester tester) async {
        // Create widget directly to avoid the default callback
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Stack(
              children: [
                TickmarkLabelWidget(
                  leftPosition: testLeftPosition,
                  text: testText,
                  color: testColor,
                  fontSize: testFontSize,
                  onTap: null, // Explicitly pass null
                  isReadOnly: testIsReadOnly,
                  tickmarkPosition: TickmarkPosition.below,
                  tickmarkSize: testTickmarkSize,
                  labelSpacing: testLabelSpacing,
                  availableHeight: testAvailableHeight,
                  trackHeight: testTrackHeight,
                  tickmarkSpacing: testTickmarkSpacing,
                ),
              ],
            ),
          ),
        );

        // Find the GestureDetector that's part of the TickmarkLabelWidget
        final gestureDetectorFinder = find.descendant(
          of: find.byType(TickmarkLabelWidget),
          matching: find.byType(GestureDetector),
        );
        final gestureDetector = tester.widget<GestureDetector>(gestureDetectorFinder);

        expect(gestureDetector.onTap, isNull);
      });
    });

    group('Edge Cases', () {
      testWidgets('Widget handles zero values correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestWidget(
            leftPosition: 0.0,
            tickmarkSize: 0.0,
            labelSpacing: 0.0,
            availableHeight: 0.0,
            trackHeight: 0.0,
            fontSize: 0.0,
          ),
        );

        expect(find.byType(TickmarkLabelWidget), findsOneWidget);
        expect(find.byType(Positioned), findsOneWidget);
      });

      testWidgets('Widget handles very large values correctly', (WidgetTester tester) async {
        const largeValue = 10000.0;
        await tester.pumpWidget(
          createTestWidget(
            leftPosition: largeValue,
            tickmarkSize: largeValue,
            labelSpacing: largeValue,
            availableHeight: largeValue,
            trackHeight: largeValue,
            fontSize: largeValue,
          ),
        );

        expect(find.byType(TickmarkLabelWidget), findsOneWidget);
        expect(find.byType(Positioned), findsOneWidget);
      });

      testWidgets('Widget handles empty text correctly', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(text: ''));

        expect(find.byType(TickmarkLabelWidget), findsOneWidget);
        expect(find.descendant(of: find.byType(TickmarkLabelWidget), matching: find.text('')), findsOneWidget);
      });

      testWidgets('Widget handles long text correctly', (WidgetTester tester) async {
        const longText = 'This is a very long text that might exceed the normal label length';
        await tester.pumpWidget(createTestWidget(text: longText));

        expect(find.byType(TickmarkLabelWidget), findsOneWidget);
        expect(find.descendant(of: find.byType(TickmarkLabelWidget), matching: find.text(longText)), findsOneWidget);
      });
    });

    group('Integration Tests', () {
      testWidgets('Widget integrates correctly with different tickmark positions', (WidgetTester tester) async {
        for (final position in TickmarkPosition.values) {
          await tester.pumpWidget(createTestWidget(tickmarkPosition: position));

          expect(find.byType(TickmarkLabelWidget), findsOneWidget);
          expect(find.byType(Positioned), findsOneWidget);

          // Verify positioning is correct for each position
          final positionedFinder = find.descendant(
            of: find.byType(TickmarkLabelWidget),
            matching: find.byType(Positioned),
          );
          final positioned = tester.widget<Positioned>(positionedFinder);

          expect(positioned.left, equals(testLeftPosition - 16));

          switch (position) {
            case TickmarkPosition.above:
              expect(positioned.top, isNotNull);
              expect(positioned.bottom, isNull);
              break;
            case TickmarkPosition.below:
              expect(positioned.bottom, isNotNull);
              expect(positioned.top, isNull);
              break;
            case TickmarkPosition.onTrack:
              expect(positioned.top, isNotNull);
              expect(positioned.bottom, isNull);
              break;
          }
        }
      });

      testWidgets('Widget maintains consistent positioning across rebuilds', (WidgetTester tester) async {
        const customLeftPosition = 150.0;
        const customFontSize = 16.0;

        // First build
        await tester.pumpWidget(createTestWidget(leftPosition: customLeftPosition, fontSize: customFontSize));

        final firstPositioned = tester.widget<Positioned>(
          find.descendant(of: find.byType(TickmarkLabelWidget), matching: find.byType(Positioned)),
        );
        final firstLeft = firstPositioned.left;
        final firstTop = firstPositioned.top;
        final firstBottom = firstPositioned.bottom;

        // Rebuild with same parameters
        await tester.pumpWidget(createTestWidget(leftPosition: customLeftPosition, fontSize: customFontSize));

        final secondPositioned = tester.widget<Positioned>(
          find.descendant(of: find.byType(TickmarkLabelWidget), matching: find.byType(Positioned)),
        );
        final secondLeft = secondPositioned.left;
        final secondTop = secondPositioned.top;
        final secondBottom = secondPositioned.bottom;

        expect(secondLeft, equals(firstLeft));
        expect(secondTop, equals(firstTop));
        expect(secondBottom, equals(firstBottom));
      });
    });
  });
}
