import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/src/widgets/range_segment_widget.dart';
import 'test_config.dart';

void main() {
  group('RangeSegmentWidget Tests', () {
    const double testLeft = 50.0;
    const double testWidth = 100.0;
    const Color testColor = Colors.blue;
    const bool testIsFirst = false;
    const bool testIsLast = false;
    const double testTrackHeight = 8.0;

    Widget createTestWidget({
      double? left,
      double? width,
      Color? color,
      bool? isFirst,
      bool? isLast,
      double? trackHeight,
    }) {
      return TestConfig.createTestApp(
        child: SizedBox(
          width: 300,
          height: 100,
          child: Stack(
            children: [
              RangeSegmentWidget(
                left: left ?? testLeft,
                width: width ?? testWidth,
                color: color ?? testColor,
                isFirst: isFirst ?? testIsFirst,
                isLast: isLast ?? testIsLast,
                trackHeight: trackHeight ?? testTrackHeight,
              ),
            ],
          ),
        ),
      );
    }

    group('Widget Construction', () {
      test('Widget can be instantiated with all required parameters', () {
        expect(() {
          RangeSegmentWidget(
            left: testLeft,
            width: testWidth,
            color: testColor,
            isFirst: testIsFirst,
            isLast: testIsLast,
            trackHeight: testTrackHeight,
          );
        }, returnsNormally);
      });

      test('Widget has correct constructor parameters', () {
        const widget = RangeSegmentWidget(
          left: testLeft,
          width: testWidth,
          color: testColor,
          isFirst: testIsFirst,
          isLast: testIsLast,
          trackHeight: testTrackHeight,
        );

        expect(widget.left, equals(testLeft));
        expect(widget.width, equals(testWidth));
        expect(widget.color, equals(testColor));
        expect(widget.isFirst, equals(testIsFirst));
        expect(widget.isLast, equals(testIsLast));
        expect(widget.trackHeight, equals(testTrackHeight));
      });

      test('Widget can be instantiated with different parameter values', () {
        expect(() {
          RangeSegmentWidget(left: 0.0, width: 50.0, color: Colors.red, isFirst: true, isLast: true, trackHeight: 12.0);
        }, returnsNormally);
      });
    });

    group('Widget Rendering', () {
      testWidgets('Widget renders with correct basic structure', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final Finder positionedFinder = find.byType(Positioned);
        expect(positionedFinder, findsOneWidget);

        final Finder containerFinder = find.byType(Container);
        expect(containerFinder, findsAtLeastNWidgets(1));

        final Positioned positioned = tester.widget(positionedFinder);
        expect(positioned.left, equals(testLeft));
      });

      testWidgets('Widget renders with correct dimensions', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));

        // Use tester.getSize to verify the rendered dimensions
        final Size containerSize = tester.getSize(containerFinder);
        expect(containerSize.width, equals(testWidth));
        expect(containerSize.height, equals(testTrackHeight));
      });

      testWidgets('Widget renders with correct color', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;

        expect(decoration.color, equals(testColor));
      });

      testWidgets('Widget renders with different colors', (WidgetTester tester) async {
        final List<Color> testColors = [Colors.red, Colors.green, Colors.amber, Colors.purple];

        for (final color in testColors) {
          await tester.pumpWidget(createTestWidget(color: color));

          final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
          final Container container = tester.widget(containerFinder);
          final BoxDecoration decoration = container.decoration as BoxDecoration;

          expect(decoration.color, equals(color));
        }
      });
    });

    group('Positioning', () {
      testWidgets('Widget positions correctly with different left values', (WidgetTester tester) async {
        final List<double> leftValues = [0.0, 25.0, 50.0, 100.0, 200.0];

        for (final leftValue in leftValues) {
          await tester.pumpWidget(createTestWidget(left: leftValue));

          final Positioned positioned = tester.widget(find.byType(Positioned));
          expect(positioned.left, equals(leftValue));
        }
      });

      testWidgets('Widget handles zero left position', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(left: 0.0));

        final Positioned positioned = tester.widget(find.byType(Positioned));
        expect(positioned.left, equals(0.0));
      });

      testWidgets('Widget handles large left position', (WidgetTester tester) async {
        const largeLeft = 1000.0;
        await tester.pumpWidget(createTestWidget(left: largeLeft));

        final Positioned positioned = tester.widget(find.byType(Positioned));
        expect(positioned.left, equals(largeLeft));
      });
    });

    group('Dimensions', () {
      testWidgets('Widget handles different width values', (WidgetTester tester) async {
        final List<double> widthValues = [10.0, 50.0, 100.0, 250.0];

        for (final widthValue in widthValues) {
          await tester.pumpWidget(createTestWidget(width: widthValue));

          final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
          final Size containerSize = tester.getSize(containerFinder);

          expect(containerSize.width, equals(widthValue));
        }
      });

      testWidgets('Widget handles different track height values', (WidgetTester tester) async {
        final List<double> heightValues = [4.0, 8.0, 12.0, 20.0];

        for (final heightValue in heightValues) {
          await tester.pumpWidget(createTestWidget(trackHeight: heightValue));

          final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
          final Size containerSize = tester.getSize(containerFinder);

          expect(containerSize.height, equals(heightValue));
        }
      });

      testWidgets('Widget handles zero width gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(width: 0.0));

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Size containerSize = tester.getSize(containerFinder);

        expect(containerSize.width, equals(0.0));
      });

      testWidgets('Widget handles very small dimensions', (WidgetTester tester) async {
        const smallWidth = 0.1;
        const smallHeight = 0.1;

        await tester.pumpWidget(createTestWidget(width: smallWidth, trackHeight: smallHeight));

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Size containerSize = tester.getSize(containerFinder);

        expect(containerSize.width, equals(smallWidth));
        expect(containerSize.height, equals(smallHeight));
      });
    });

    group('Border Radius Behavior', () {
      testWidgets('Widget has no border radius when neither first nor last', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(isFirst: false, isLast: false));

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;
        final BorderRadius borderRadius = decoration.borderRadius as BorderRadius;

        expect(borderRadius.topLeft, equals(Radius.zero));
        expect(borderRadius.bottomLeft, equals(Radius.zero));
        expect(borderRadius.topRight, equals(Radius.zero));
        expect(borderRadius.bottomRight, equals(Radius.zero));
      });

      testWidgets('Widget has left border radius when isFirst is true', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(isFirst: true, isLast: false));

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;
        final BorderRadius borderRadius = decoration.borderRadius as BorderRadius;

        expect(borderRadius.topLeft, equals(const Radius.circular(4)));
        expect(borderRadius.bottomLeft, equals(const Radius.circular(4)));
        expect(borderRadius.topRight, equals(Radius.zero));
        expect(borderRadius.bottomRight, equals(Radius.zero));
      });

      testWidgets('Widget has right border radius when isLast is true', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(isFirst: false, isLast: true));

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;
        final BorderRadius borderRadius = decoration.borderRadius as BorderRadius;

        expect(borderRadius.topLeft, equals(Radius.zero));
        expect(borderRadius.bottomLeft, equals(Radius.zero));
        expect(borderRadius.topRight, equals(const Radius.circular(4)));
        expect(borderRadius.bottomRight, equals(const Radius.circular(4)));
      });

      testWidgets('Widget has both border radii when both first and last', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(isFirst: true, isLast: true));

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;
        final BorderRadius borderRadius = decoration.borderRadius as BorderRadius;

        expect(borderRadius.topLeft, equals(const Radius.circular(4)));
        expect(borderRadius.bottomLeft, equals(const Radius.circular(4)));
        expect(borderRadius.topRight, equals(const Radius.circular(4)));
        expect(borderRadius.bottomRight, equals(const Radius.circular(4)));
      });

      testWidgets('Widget border radius behavior with all combinations', (WidgetTester tester) async {
        final List<Map<String, bool>> combinations = [
          {'isFirst': false, 'isLast': false},
          {'isFirst': true, 'isLast': false},
          {'isFirst': false, 'isLast': true},
          {'isFirst': true, 'isLast': true},
        ];

        for (final combination in combinations) {
          await tester.pumpWidget(createTestWidget(isFirst: combination['isFirst']!, isLast: combination['isLast']!));

          final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
          final Container container = tester.widget(containerFinder);
          final BoxDecoration decoration = container.decoration as BoxDecoration;
          final BorderRadius borderRadius = decoration.borderRadius as BorderRadius;

          // Verify left border radius
          if (combination['isFirst']!) {
            expect(borderRadius.topLeft, equals(const Radius.circular(4)));
            expect(borderRadius.bottomLeft, equals(const Radius.circular(4)));
          } else {
            expect(borderRadius.topLeft, equals(Radius.zero));
            expect(borderRadius.bottomLeft, equals(Radius.zero));
          }

          // Verify right border radius
          if (combination['isLast']!) {
            expect(borderRadius.topRight, equals(const Radius.circular(4)));
            expect(borderRadius.bottomRight, equals(const Radius.circular(4)));
          } else {
            expect(borderRadius.topRight, equals(Radius.zero));
            expect(borderRadius.bottomRight, equals(Radius.zero));
          }
        }
      });
    });

    group('Edge Cases', () {
      testWidgets('Widget handles extreme positioning values', (WidgetTester tester) async {
        const extremeLeft = -100.0;
        await tester.pumpWidget(createTestWidget(left: extremeLeft));

        final Positioned positioned = tester.widget(find.byType(Positioned));
        expect(positioned.left, equals(extremeLeft));
      });

      testWidgets('Widget handles very large dimensions', (WidgetTester tester) async {
        const largeWidth = 10000.0;
        const largeHeight = 100.0;

        await tester.pumpWidget(createTestWidget(width: largeWidth, trackHeight: largeHeight));

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Size containerSize = tester.getSize(containerFinder);

        expect(containerSize.width, equals(largeWidth));
        expect(containerSize.height, equals(largeHeight));
      });

      testWidgets('Widget handles transparent color', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(color: Colors.transparent));

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;

        expect(decoration.color, equals(Colors.transparent));
      });

      testWidgets('Widget handles custom colors with opacity', (WidgetTester tester) async {
        final customColor = Colors.blue.withValues(alpha: 0.5);
        await tester.pumpWidget(createTestWidget(color: customColor));

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;

        expect(decoration.color, equals(customColor));
      });
    });

    group('Multiple Segments', () {
      testWidgets('Multiple segments can be rendered together', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: SizedBox(
              width: 300,
              height: 100,
              child: Stack(
                children: [
                  RangeSegmentWidget(
                    left: 0.0,
                    width: 50.0,
                    color: Colors.red,
                    isFirst: true,
                    isLast: false,
                    trackHeight: testTrackHeight,
                  ),
                  RangeSegmentWidget(
                    left: 50.0,
                    width: 100.0,
                    color: Colors.blue,
                    isFirst: false,
                    isLast: false,
                    trackHeight: testTrackHeight,
                  ),
                  RangeSegmentWidget(
                    left: 150.0,
                    width: 50.0,
                    color: Colors.green,
                    isFirst: false,
                    isLast: true,
                    trackHeight: testTrackHeight,
                  ),
                ],
              ),
            ),
          ),
        );

        // Should find 3 RangeSegmentWidgets
        final Finder segmentFinder = find.byType(RangeSegmentWidget);
        expect(segmentFinder, findsNWidgets(3));

        // Should find 3 Positioned widgets
        final Finder positionedFinder = find.byType(Positioned);
        expect(positionedFinder, findsNWidgets(3));
      });

      testWidgets('Segments maintain individual properties when multiple', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: SizedBox(
              width: 300,
              height: 100,
              child: Stack(
                children: [
                  RangeSegmentWidget(
                    left: 0.0,
                    width: 100.0,
                    color: Colors.red,
                    isFirst: true,
                    isLast: false,
                    trackHeight: 10.0,
                  ),
                  RangeSegmentWidget(
                    left: 100.0,
                    width: 50.0,
                    color: Colors.blue,
                    isFirst: false,
                    isLast: true,
                    trackHeight: 8.0,
                  ),
                ],
              ),
            ),
          ),
        );

        final List<Positioned> positionedWidgets = tester.widgetList<Positioned>(find.byType(Positioned)).toList();
        expect(positionedWidgets.length, equals(2));

        // Verify first segment
        expect(positionedWidgets[0].left, equals(0.0));

        // Verify second segment
        expect(positionedWidgets[1].left, equals(100.0));

        // Verify containers have different properties by checking their sizes
        final List<Widget> containerWidgets = tester
            .widgetList<Container>(find.descendant(of: find.byType(Positioned), matching: find.byType(Container)))
            .toList();

        expect(containerWidgets.length, equals(2));

        // Check rendered sizes of each container
        final List<Size> containerSizes = containerWidgets.asMap().entries.map((entry) {
          return tester.getSize(
            find.descendant(of: find.byType(Positioned), matching: find.byType(Container)).at(entry.key),
          );
        }).toList();

        expect(containerSizes[0].width, equals(100.0));
        expect(containerSizes[0].height, equals(10.0));
        expect(containerSizes[1].width, equals(50.0));
        expect(containerSizes[1].height, equals(8.0));
      });
    });

    group('Decoration Properties', () {
      testWidgets('Widget always has BoxDecoration', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Container container = tester.widget(containerFinder);

        expect(container.decoration, isA<BoxDecoration>());
      });

      testWidgets('Widget decoration has correct type of border radius', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;

        expect(decoration.borderRadius, isA<BorderRadius>());
      });

      testWidgets('Widget maintains consistent decoration structure across different states', (
        WidgetTester tester,
      ) async {
        final List<Map<String, dynamic>> testCases = [
          {'isFirst': true, 'isLast': true, 'color': Colors.red},
          {'isFirst': false, 'isLast': false, 'color': Colors.blue},
          {'isFirst': true, 'isLast': false, 'color': Colors.green},
          {'isFirst': false, 'isLast': true, 'color': Colors.yellow},
        ];

        for (final testCase in testCases) {
          await tester.pumpWidget(
            createTestWidget(
              isFirst: testCase['isFirst'] as bool,
              isLast: testCase['isLast'] as bool,
              color: testCase['color'] as Color,
            ),
          );

          final Finder containerFinder = find.descendant(of: find.byType(Positioned), matching: find.byType(Container));
          final Container container = tester.widget(containerFinder);
          final BoxDecoration decoration = container.decoration as BoxDecoration;

          // Verify consistent structure
          expect(decoration.color, equals(testCase['color']));
          expect(decoration.borderRadius, isA<BorderRadius>());
        }
      });
    });
  });
}
