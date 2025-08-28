import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_range_slider/src/widgets/thumb_widget.dart';
import 'test_config.dart';

void main() {
  group('ThumbWidget Tests', () {
    const double testRadius = 15.0;
    const Color testColor = Colors.blue;
    const bool testIsDragged = false;
    const bool testIsReadOnly = false;

    Widget createTestWidget({
      double? radius,
      Color? color,
      bool? isDragged,
      bool? isReadOnly,
    }) {
      return TestConfig.createTestApp(
        child: Center(
          child: ThumbWidget(
            radius: radius ?? testRadius,
            color: color ?? testColor,
            isDragged: isDragged ?? testIsDragged,
            isReadOnly: isReadOnly ?? testIsReadOnly,
          ),
        ),
      );
    }

    group('Widget Construction', () {
      test('Widget can be instantiated with all required parameters', () {
        expect(() {
          ThumbWidget(
            radius: testRadius,
            color: testColor,
            isDragged: testIsDragged,
            isReadOnly: testIsReadOnly,
          );
        }, returnsNormally);
      });

      test('Widget has correct constructor parameters', () {
        const widget = ThumbWidget(
          radius: testRadius,
          color: testColor,
          isDragged: testIsDragged,
          isReadOnly: testIsReadOnly,
        );

        expect(widget.radius, equals(testRadius));
        expect(widget.color, equals(testColor));
        expect(widget.isDragged, equals(testIsDragged));
        expect(widget.isReadOnly, equals(testIsReadOnly));
      });
    });

    group('Widget Rendering', () {
      testWidgets('Widget renders with correct basic structure', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());

        final Finder containerFinder = find.byType(Container);
        expect(containerFinder, findsOneWidget);

        // Verify the rendered size using tester.getSize()
        final Size containerSize = tester.getSize(containerFinder);
        expect(containerSize.width, equals(testRadius * 2));
        expect(containerSize.height, equals(testRadius * 2));
      });

      testWidgets('Widget renders with correct decoration properties', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());

        final Finder containerFinder = find.byType(Container);
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;

        expect(decoration.color, equals(testColor));
        expect(decoration.shape, equals(BoxShape.circle));
        expect(decoration.border, isNotNull);
      });

      testWidgets('Widget renders with correct border properties', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());

        final Finder containerFinder = find.byType(Container);
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;
        final Border border = decoration.border as Border;

        expect(border.top.width, equals(2.0));
        expect(border.top.color, equals(Colors.grey.shade400));
      });

      testWidgets('Widget renders with correct shadow when not read-only', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget());

        final Finder containerFinder = find.byType(Container);
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;

        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow!.length, equals(1));

        final BoxShadow shadow = decoration.boxShadow!.first;
        expect(shadow.color, equals(Colors.black.withValues(alpha: 0.3)));
        expect(shadow.spreadRadius, equals(1));
        expect(shadow.blurRadius, equals(3));
        expect(shadow.offset, equals(const Offset(0, 2)));
      });
    });

    group('Dragged State Behavior', () {
      testWidgets('Widget enlarges when isDragged is true', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(isDragged: true));

        final Finder containerFinder = find.byType(Container);

        // When dragged, radius should be 1.2 times the original
        final Size containerSize = tester.getSize(containerFinder);
        final double expectedSize = testRadius * 1.2 * 2;
        expect(containerSize.width, equals(expectedSize));
        expect(containerSize.height, equals(expectedSize));
      });

      testWidgets('Widget maintains normal size when isDragged is false', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(isDragged: false));

        final Finder containerFinder = find.byType(Container);

        // When not dragged, size should be exactly radius * 2
        final Size containerSize = tester.getSize(containerFinder);
        final double expectedSize = testRadius * 2;
        expect(containerSize.width, equals(expectedSize));
        expect(containerSize.height, equals(expectedSize));
      });

      testWidgets('Widget transitions between dragged and normal states', (
        WidgetTester tester,
      ) async {
        // Start with not dragged
        await tester.pumpWidget(createTestWidget(isDragged: false));

        Size containerSize = tester.getSize(find.byType(Container));
        expect(containerSize.width, equals(testRadius * 2));

        // Change to dragged state
        await tester.pumpWidget(createTestWidget(isDragged: true));

        containerSize = tester.getSize(find.byType(Container));
        expect(containerSize.width, equals(testRadius * 1.2 * 2));

        // Change back to not dragged
        await tester.pumpWidget(createTestWidget(isDragged: false));

        containerSize = tester.getSize(find.byType(Container));
        expect(containerSize.width, equals(testRadius * 2));
      });
    });

    group('Read-Only State Behavior', () {
      testWidgets('Widget applies read-only styling when isReadOnly is true', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(isReadOnly: true));

        final Finder containerFinder = find.byType(Container);
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;

        // Check that color has reduced opacity
        expect(decoration.color, equals(testColor.withValues(alpha: 0.6)));

        // Check that border has reduced width and different color
        final Border border = decoration.border as Border;
        expect(border.top.width, equals(1.5));
        expect(border.top.color, equals(Colors.grey.shade300));

        // Check that no shadow is applied
        expect(decoration.boxShadow, isEmpty);
      });

      testWidgets('Widget applies normal styling when isReadOnly is false', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(isReadOnly: false));

        final Finder containerFinder = find.byType(Container);
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;

        // Check that color has full opacity
        expect(decoration.color, equals(testColor));

        // Check that border has normal width and color
        final Border border = decoration.border as Border;
        expect(border.top.width, equals(2.0));
        expect(border.top.color, equals(Colors.grey.shade400));

        // Check that shadow is applied
        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow!.length, equals(1));
      });
    });

    group('Combined State Behavior', () {
      testWidgets(
        'Widget handles both dragged and read-only states correctly',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            createTestWidget(isDragged: true, isReadOnly: true),
          );

          final Finder containerFinder = find.byType(Container);
          final Container container = tester.widget(containerFinder);
          final BoxDecoration decoration =
              container.decoration as BoxDecoration;

          // Should be enlarged due to dragged state
          final Size containerSize = tester.getSize(containerFinder);
          final double expectedSize = testRadius * 1.2 * 2;
          expect(containerSize.width, equals(expectedSize));
          expect(containerSize.height, equals(expectedSize));

          // Should have read-only styling
          expect(decoration.color, equals(testColor.withValues(alpha: 0.6)));
          expect(decoration.boxShadow, isEmpty);

          final Border border = decoration.border as Border;
          expect(border.top.width, equals(1.5));
          expect(border.top.color, equals(Colors.grey.shade300));
        },
      );

      testWidgets('Widget handles all state combinations correctly', (
        WidgetTester tester,
      ) async {
        // Test all four combinations
        final List<Map<String, bool>> stateCombinations = [
          {'isDragged': false, 'isReadOnly': false},
          {'isDragged': false, 'isReadOnly': true},
          {'isDragged': true, 'isReadOnly': false},
          {'isDragged': true, 'isReadOnly': true},
        ];

        for (final state in stateCombinations) {
          await tester.pumpWidget(
            createTestWidget(
              isDragged: state['isDragged']!,
              isReadOnly: state['isReadOnly']!,
            ),
          );

          final Container container = tester.widget(find.byType(Container));
          final BoxDecoration decoration =
              container.decoration as BoxDecoration;
          final Size containerSize = tester.getSize(find.byType(Container));

          // Verify size based on dragged state
          final double expectedSize = state['isDragged']!
              ? testRadius * 1.2 * 2
              : testRadius * 2;
          expect(containerSize.width, equals(expectedSize));
          expect(containerSize.height, equals(expectedSize));

          // Verify color based on read-only state
          final Color expectedColor = state['isReadOnly']!
              ? testColor.withValues(alpha: 0.6)
              : testColor;
          expect(decoration.color, equals(expectedColor));

          // Verify shadow based on read-only state
          if (state['isReadOnly']!) {
            expect(decoration.boxShadow, isEmpty);
          } else {
            expect(decoration.boxShadow, isNotNull);
            expect(decoration.boxShadow!.length, equals(1));
          }
        }
      });
    });

    group('Edge Cases', () {
      testWidgets('Widget handles zero radius gracefully', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(createTestWidget(radius: 0.0));

        final Finder containerFinder = find.byType(Container);
        final Size containerSize = tester.getSize(containerFinder);

        expect(containerSize.width, equals(0.0));
        expect(containerSize.height, equals(0.0));
      });

      testWidgets('Widget handles very small radius', (
        WidgetTester tester,
      ) async {
        const double smallRadius = 0.1;
        await tester.pumpWidget(createTestWidget(radius: smallRadius));

        final Finder containerFinder = find.byType(Container);
        final Size containerSize = tester.getSize(containerFinder);

        expect(containerSize.width, equals(smallRadius * 2));
        expect(containerSize.height, equals(smallRadius * 2));
      });

      testWidgets('Widget handles transparent color', (
        WidgetTester tester,
      ) async {
        const Color transparentColor = Colors.transparent;
        await tester.pumpWidget(createTestWidget(color: transparentColor));

        final Finder containerFinder = find.byType(Container);
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;

        expect(decoration.color, equals(transparentColor));
      });

      testWidgets('Widget maintains circular shape regardless of radius', (
        WidgetTester tester,
      ) async {
        final List<double> radiusValues = [1.0, 5.0, 10.0, 20.0, 50.0];

        for (final radius in radiusValues) {
          await tester.pumpWidget(createTestWidget(radius: radius));

          final Container container = tester.widget(find.byType(Container));
          final BoxDecoration decoration =
              container.decoration as BoxDecoration;

          expect(decoration.shape, equals(BoxShape.circle));
        }
      });
    });
  });
}
