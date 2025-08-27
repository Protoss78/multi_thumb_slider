import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_range_slider/src/widgets/tooltip_widget.dart';
import 'test_config.dart';

void main() {
  group('TooltipWidget Tests', () {
    const double testLeftPosition = 100.0;
    const String testText = 'Test Tooltip';
    const Color testBackgroundColor = Colors.blue;
    const Color testTextColor = Colors.white;
    const double testFontSize = 14.0;

    Widget createTestWidget({
      double? leftPosition,
      String? text,
      Color? backgroundColor,
      Color? textColor,
      double? fontSize,
    }) {
      return TestConfig.createTestApp(
        child: Stack(
          children: [
            TooltipWidget(
              leftPosition: leftPosition ?? testLeftPosition,
              text: text ?? testText,
              backgroundColor: backgroundColor ?? testBackgroundColor,
              textColor: textColor ?? testTextColor,
              fontSize: fontSize ?? testFontSize,
            ),
          ],
        ),
      );
    }

    group('Widget Construction', () {
      test('Widget can be instantiated with all required parameters', () {
        expect(() {
          TooltipWidget(
            leftPosition: testLeftPosition,
            text: testText,
            backgroundColor: testBackgroundColor,
            textColor: testTextColor,
            fontSize: testFontSize,
          );
        }, returnsNormally);
      });

      test('Widget has correct constructor parameters', () {
        const widget = TooltipWidget(
          leftPosition: testLeftPosition,
          text: testText,
          backgroundColor: testBackgroundColor,
          textColor: testTextColor,
          fontSize: testFontSize,
        );

        expect(widget.leftPosition, equals(testLeftPosition));
        expect(widget.text, equals(testText));
        expect(widget.backgroundColor, equals(testBackgroundColor));
        expect(widget.textColor, equals(testTextColor));
        expect(widget.fontSize, equals(testFontSize));
      });
    });

    group('Widget Rendering', () {
      testWidgets('Widget renders with correct text', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        expect(find.text(testText), findsOneWidget);
      });

      testWidgets('Widget renders with correct positioning', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final tooltipFinder = find.byType(TooltipWidget);
        expect(tooltipFinder, findsOneWidget);

        final tooltip = tester.widget<TooltipWidget>(tooltipFinder);
        expect(tooltip.leftPosition, equals(testLeftPosition));
      });

      testWidgets('Widget renders with correct styling', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final textFinder = find.text(testText);
        expect(textFinder, findsOneWidget);

        final textWidget = tester.widget<Text>(textFinder);
        expect(textWidget.style?.color, equals(testTextColor));
        expect(textWidget.style?.fontSize, equals(testFontSize));
        expect(textWidget.style?.fontWeight, equals(FontWeight.w500));
      });

      testWidgets('Widget renders with correct background color', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final containerFinder = find.byType(Container);
        expect(containerFinder, findsOneWidget);

        final container = tester.widget<Container>(containerFinder);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(testBackgroundColor));
      });
    });

    group('Widget Layout', () {
      testWidgets('Widget is positioned correctly in Stack', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final positionedFinder = find.byType(Positioned);
        expect(positionedFinder, findsOneWidget);

        final positioned = tester.widget<Positioned>(positionedFinder);
        expect(positioned.left, equals(testLeftPosition));
        expect(positioned.top, equals(-35));
      });

      testWidgets('Widget has correct padding and decoration', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        final containerFinder = find.byType(Container);
        final container = tester.widget<Container>(containerFinder);

        // Check padding
        expect(container.padding, equals(const EdgeInsets.symmetric(horizontal: 8, vertical: 4)));

        // Check decoration
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.borderRadius, equals(BorderRadius.circular(6)));

        // Check box shadow
        expect(decoration.boxShadow, isNotNull);
        expect(decoration.boxShadow!.length, equals(1));
        expect(decoration.boxShadow!.first.color, equals(Colors.black26));
        expect(decoration.boxShadow!.first.blurRadius, equals(4));
        expect(decoration.boxShadow!.first.offset, equals(const Offset(0, 2)));
      });
    });

    group('Widget Customization', () {
      testWidgets('Widget renders with custom colors', (WidgetTester tester) async {
        const customBackgroundColor = Colors.red;
        const customTextColor = Colors.yellow;

        await tester.pumpWidget(createTestWidget(backgroundColor: customBackgroundColor, textColor: customTextColor));

        // Check background color
        final containerFinder = find.byType(Container);
        final container = tester.widget<Container>(containerFinder);
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(customBackgroundColor));

        // Check text color
        final textFinder = find.text(testText);
        final textWidget = tester.widget<Text>(textFinder);
        expect(textWidget.style?.color, equals(customTextColor));
      });

      testWidgets('Widget renders with custom font size', (WidgetTester tester) async {
        const customFontSize = 18.0;

        await tester.pumpWidget(createTestWidget(fontSize: customFontSize));

        final textFinder = find.text(testText);
        final textWidget = tester.widget<Text>(textFinder);
        expect(textWidget.style?.fontSize, equals(customFontSize));
      });

      testWidgets('Widget renders with custom position', (WidgetTester tester) async {
        const customLeftPosition = 200.0;

        await tester.pumpWidget(createTestWidget(leftPosition: customLeftPosition));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);
        expect(positioned.left, equals(customLeftPosition));
      });

      testWidgets('Widget renders with custom text', (WidgetTester tester) async {
        const customText = 'Custom Tooltip Text';

        await tester.pumpWidget(createTestWidget(text: customText));

        expect(find.text(customText), findsOneWidget);
      });
    });

    group('Widget Behavior', () {
      testWidgets('Widget rebuilds when parameters change', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Initial state
        expect(find.text(testText), findsOneWidget);

        // Change text and rebuild
        const newText = 'Updated Tooltip';
        await tester.pumpWidget(createTestWidget(text: newText));

        // Should show new text
        expect(find.text(newText), findsOneWidget);
        expect(find.text(testText), findsNothing);
      });

      testWidgets('Widget maintains position when other parameters change', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget());

        // Change background color
        await tester.pumpWidget(createTestWidget(backgroundColor: Colors.green));

        // Position should remain the same
        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);
        expect(positioned.left, equals(testLeftPosition));
        expect(positioned.top, equals(-35));
      });
    });

    group('Edge Cases', () {
      testWidgets('Widget handles empty text', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(text: ''));

        expect(find.text(''), findsOneWidget);
      });

      testWidgets('Widget handles very long text', (WidgetTester tester) async {
        const longText =
            'This is a very long tooltip text that should still render properly without breaking the layout';

        await tester.pumpWidget(createTestWidget(text: longText));

        expect(find.text(longText), findsOneWidget);
      });

      testWidgets('Widget handles zero position', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(leftPosition: 0.0));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);
        expect(positioned.left, equals(0.0));
      });

      testWidgets('Widget handles negative position', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(leftPosition: -50.0));

        final positionedFinder = find.byType(Positioned);
        final positioned = tester.widget<Positioned>(positionedFinder);
        expect(positioned.left, equals(-50.0));
      });

      testWidgets('Widget handles very small font size', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(fontSize: 8.0));

        final textFinder = find.text(testText);
        final textWidget = tester.widget<Text>(textFinder);
        expect(textWidget.style?.fontSize, equals(8.0));
      });

      testWidgets('Widget handles very large font size', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget(fontSize: 32.0));

        final textFinder = find.text(testText);
        final textWidget = tester.widget<Text>(textFinder);
        expect(textWidget.style?.fontSize, equals(32.0));
      });
    });
  });
}
