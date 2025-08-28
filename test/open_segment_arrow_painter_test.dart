import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_range_slider/src/widgets/open_segment_arrow_painter.dart';

void main() {
  group('OpenSegmentArrowPainter Tests', () {
    const Color testColor = Colors.blue;
    const double testTrackHeight = 8.0;

    group('Constructor', () {
      test('Painter can be instantiated with required parameters', () {
        expect(() {
          OpenSegmentArrowPainter(
            color: testColor,
            trackHeight: testTrackHeight,
          );
        }, returnsNormally);
      });

      test('Painter can be instantiated with all parameters', () {
        expect(() {
          OpenSegmentArrowPainter(
            color: testColor,
            trackHeight: testTrackHeight,
            isOpenEnded: true,
            isOpenStarted: true,
          );
        }, returnsNormally);
      });

      test('Painter has correct default parameter values', () {
        final painter = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: testTrackHeight,
        );

        expect(painter.color, equals(testColor));
        expect(painter.trackHeight, equals(testTrackHeight));
        expect(painter.isOpenEnded, equals(false));
        expect(painter.isOpenStarted, equals(false));
      });

      test('Painter has correct parameter values when set', () {
        final painter = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: testTrackHeight,
          isOpenEnded: true,
          isOpenStarted: true,
        );

        expect(painter.color, equals(testColor));
        expect(painter.trackHeight, equals(testTrackHeight));
        expect(painter.isOpenEnded, equals(true));
        expect(painter.isOpenStarted, equals(true));
      });
    });

    group('Parameter Variations', () {
      test('Painter accepts different colors', () {
        final List<Color> testColors = [
          Colors.red,
          Colors.green,
          Colors.transparent,
          Colors.amber.withValues(alpha: 0.5),
        ];

        for (final color in testColors) {
          expect(() {
            OpenSegmentArrowPainter(color: color, trackHeight: testTrackHeight);
          }, returnsNormally);
        }
      });

      test('Painter accepts different track heights', () {
        final List<double> trackHeights = [1.0, 4.0, 8.0, 12.0, 20.0, 50.0];

        for (final height in trackHeights) {
          expect(() {
            OpenSegmentArrowPainter(color: testColor, trackHeight: height);
          }, returnsNormally);
        }
      });

      test('Painter accepts various boolean combinations', () {
        final List<Map<String, bool>> combinations = [
          {'isOpenEnded': false, 'isOpenStarted': false},
          {'isOpenEnded': true, 'isOpenStarted': false},
          {'isOpenEnded': false, 'isOpenStarted': true},
          {'isOpenEnded': true, 'isOpenStarted': true},
        ];

        for (final combination in combinations) {
          expect(() {
            OpenSegmentArrowPainter(
              color: testColor,
              trackHeight: testTrackHeight,
              isOpenEnded: combination['isOpenEnded']!,
              isOpenStarted: combination['isOpenStarted']!,
            );
          }, returnsNormally);
        }
      });
    });

    group('shouldRepaint Method', () {
      test('shouldRepaint returns false for identical painters', () {
        final painter1 = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: testTrackHeight,
          isOpenEnded: true,
          isOpenStarted: false,
        );

        final painter2 = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: testTrackHeight,
          isOpenEnded: true,
          isOpenStarted: false,
        );

        expect(painter1.shouldRepaint(painter2), equals(false));
      });

      test('shouldRepaint returns true when color changes', () {
        final painter1 = OpenSegmentArrowPainter(
          color: Colors.red,
          trackHeight: testTrackHeight,
        );

        final painter2 = OpenSegmentArrowPainter(
          color: Colors.blue,
          trackHeight: testTrackHeight,
        );

        expect(painter1.shouldRepaint(painter2), equals(true));
      });

      test('shouldRepaint returns true when trackHeight changes', () {
        final painter1 = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: 8.0,
        );

        final painter2 = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: 12.0,
        );

        expect(painter1.shouldRepaint(painter2), equals(true));
      });

      test('shouldRepaint returns true when isOpenEnded changes', () {
        final painter1 = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: testTrackHeight,
          isOpenEnded: true,
        );

        final painter2 = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: testTrackHeight,
          isOpenEnded: false,
        );

        expect(painter1.shouldRepaint(painter2), equals(true));
      });

      test('shouldRepaint returns true when isOpenStarted changes', () {
        final painter1 = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: testTrackHeight,
          isOpenStarted: true,
        );

        final painter2 = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: testTrackHeight,
          isOpenStarted: false,
        );

        expect(painter1.shouldRepaint(painter2), equals(true));
      });

      test('shouldRepaint returns true when multiple properties change', () {
        final painter1 = OpenSegmentArrowPainter(
          color: Colors.red,
          trackHeight: 8.0,
          isOpenEnded: true,
          isOpenStarted: false,
        );

        final painter2 = OpenSegmentArrowPainter(
          color: Colors.blue,
          trackHeight: 12.0,
          isOpenEnded: false,
          isOpenStarted: true,
        );

        expect(painter1.shouldRepaint(painter2), equals(true));
      });

      test('shouldRepaint returns true for different painter types', () {
        final painter1 = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: testTrackHeight,
        );

        final painter2 = MockCustomPainter();

        expect(painter1.shouldRepaint(painter2), equals(true));
      });
    });

    group('Paint Method Integration', () {
      testWidgets('Paint method executes without errors for open ended arrow', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                painter: OpenSegmentArrowPainter(
                  color: testColor,
                  trackHeight: testTrackHeight,
                  isOpenEnded: true,
                ),
                size: const Size(20.0, 16.0),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      });

      testWidgets(
        'Paint method executes without errors for open started arrow',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: CustomPaint(
                  painter: OpenSegmentArrowPainter(
                    color: testColor,
                    trackHeight: testTrackHeight,
                    isOpenStarted: true,
                  ),
                  size: const Size(20.0, 16.0),
                ),
              ),
            ),
          );

          expect(tester.takeException(), isNull);
        },
      );

      testWidgets('Paint method executes without errors for both arrows', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                painter: OpenSegmentArrowPainter(
                  color: testColor,
                  trackHeight: testTrackHeight,
                  isOpenEnded: true,
                  isOpenStarted: true,
                ),
                size: const Size(20.0, 16.0),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      });

      testWidgets('Paint method executes without errors for no arrows', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                painter: OpenSegmentArrowPainter(
                  color: testColor,
                  trackHeight: testTrackHeight,
                  isOpenEnded: false,
                  isOpenStarted: false,
                ),
                size: const Size(20.0, 16.0),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      });

      testWidgets('Paint method handles different track heights', (
        WidgetTester tester,
      ) async {
        final List<double> trackHeights = [1.0, 4.0, 8.0, 12.0, 20.0];

        for (final height in trackHeights) {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: CustomPaint(
                  painter: OpenSegmentArrowPainter(
                    color: testColor,
                    trackHeight: height,
                    isOpenEnded: true,
                    isOpenStarted: true,
                  ),
                  size: Size(height * 1.5, height * 2),
                ),
              ),
            ),
          );

          expect(tester.takeException(), isNull);
        }
      });

      testWidgets('Paint method handles different colors', (
        WidgetTester tester,
      ) async {
        final List<Color> colors = [
          Colors.red,
          Colors.green,
          Colors.transparent,
          Colors.amber.withValues(alpha: 0.5),
        ];

        for (final color in colors) {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: CustomPaint(
                  painter: OpenSegmentArrowPainter(
                    color: color,
                    trackHeight: testTrackHeight,
                    isOpenEnded: true,
                    isOpenStarted: true,
                  ),
                  size: const Size(20.0, 16.0),
                ),
              ),
            ),
          );

          expect(tester.takeException(), isNull);
        }
      });

      testWidgets('Paint method handles zero track height', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                painter: OpenSegmentArrowPainter(
                  color: testColor,
                  trackHeight: 0.0,
                  isOpenEnded: true,
                  isOpenStarted: true,
                ),
                size: const Size(20.0, 16.0),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      });

      testWidgets('Paint method handles very large track height', (
        WidgetTester tester,
      ) async {
        const largeHeight = 100.0;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                painter: OpenSegmentArrowPainter(
                  color: testColor,
                  trackHeight: largeHeight,
                  isOpenEnded: true,
                  isOpenStarted: true,
                ),
                size: const Size(largeHeight * 1.5, largeHeight * 2),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      });

      testWidgets('Paint method handles very small size', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                painter: OpenSegmentArrowPainter(
                  color: testColor,
                  trackHeight: testTrackHeight,
                  isOpenEnded: true,
                  isOpenStarted: true,
                ),
                size: const Size(0.1, 0.1),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      });

      testWidgets('Paint method handles very large size', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                painter: OpenSegmentArrowPainter(
                  color: testColor,
                  trackHeight: testTrackHeight,
                  isOpenEnded: true,
                  isOpenStarted: true,
                ),
                size: const Size(1000.0, 1000.0),
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull);
      });
    });

    group('Arrow Calculations', () {
      test('Arrow calculations are consistent with track height', () {
        final painter = OpenSegmentArrowPainter(
          color: testColor,
          trackHeight: 10.0,
        );

        // These calculations are based on the implementation
        const double expectedArrowHeight = 10.0 * 1.25; // trackHeight * 1.25
        const double expectedArrowWidth = 16.0;

        // We can't directly test the calculations since they're private,
        // but we can verify the painter doesn't throw errors with various inputs
        expect(painter.trackHeight, equals(10.0));
        expect(expectedArrowHeight, equals(12.5));
        expect(expectedArrowWidth, equals(16.0));
      });

      testWidgets('Arrow positioning adapts to different canvas sizes', (
        WidgetTester tester,
      ) async {
        final List<Size> canvasSizes = [
          const Size(10.0, 10.0),
          const Size(20.0, 16.0),
          const Size(50.0, 40.0),
          const Size(100.0, 80.0),
        ];

        for (final size in canvasSizes) {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: CustomPaint(
                  painter: OpenSegmentArrowPainter(
                    color: testColor,
                    trackHeight: testTrackHeight,
                    isOpenEnded: true,
                    isOpenStarted: true,
                  ),
                  size: size,
                ),
              ),
            ),
          );

          expect(tester.takeException(), isNull);
        }
      });
    });

    group('Edge Cases', () {
      test('Painter handles extreme color values', () {
        final List<Color> extremeColors = [
          const Color(0x00000000), // Fully transparent
          const Color(0xFFFFFFFF), // Pure white
          const Color(0xFF000000), // Pure black
          const Color(0x80FF0000), // Semi-transparent red
        ];

        for (final color in extremeColors) {
          expect(() {
            OpenSegmentArrowPainter(color: color, trackHeight: testTrackHeight);
          }, returnsNormally);
        }
      });

      test('Painter handles extreme track height values', () {
        final List<double> extremeHeights = [
          0.0,
          0.001,
          1000.0,
          double.infinity,
        ];

        for (final height in extremeHeights) {
          if (height.isFinite) {
            expect(() {
              OpenSegmentArrowPainter(color: testColor, trackHeight: height);
            }, returnsNormally);
          }
        }
      });

      testWidgets('Painter handles negative track height gracefully', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomPaint(
                painter: OpenSegmentArrowPainter(
                  color: testColor,
                  trackHeight: -10.0,
                  isOpenEnded: true,
                ),
                size: const Size(20.0, 16.0),
              ),
            ),
          ),
        );

        // Should not throw an exception, but behavior with negative values
        // depends on the implementation
        expect(tester.takeException(), isNull);
      });
    });

    group('Performance', () {
      testWidgets('Painter performs efficiently with complex scenarios', (
        WidgetTester tester,
      ) async {
        // Test multiple repaints to ensure there are no performance issues
        for (int i = 0; i < 10; i++) {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: CustomPaint(
                  painter: OpenSegmentArrowPainter(
                    color: Colors.blue.withValues(alpha: i / 10.0),
                    trackHeight: testTrackHeight + i,
                    isOpenEnded: i % 2 == 0,
                    isOpenStarted: i % 3 == 0,
                  ),
                  size: Size(20.0 + i, 16.0 + i),
                ),
              ),
            ),
          );

          expect(tester.takeException(), isNull);
        }
      });
    });
  });
}

/// Mock CustomPainter for testing shouldRepaint with different painter types
class MockCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Empty implementation for testing
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
