import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/src/widgets/segment_display_widget.dart';
import 'package:multi_thumb_slider/src/constants.dart';
import 'test_config.dart';

void main() {
  group('SegmentDisplayWidget Tests', () {
    const List<int> testIntValues = [25, 50, 75];
    const List<double> testDoubleValues = [25.5, 50.0, 75.7];
    const int testIntMin = 0;
    const int testIntMax = 100;
    const double testDoubleMin = 0.0;
    const double testDoubleMax = 100.0;

    Widget createTestWidget<T extends num>({
      List<T>? values,
      T? min,
      T? max,
      SegmentContentType? contentType,
      String Function(T)? valueFormatter,
      double? height,
      double? cardPadding,
      double? cardMargin,
      double? cardBorderRadius,
      Color? cardBackgroundColor,
      Color? cardBorderColor,
      Color? textColor,
      double? textSize,
      FontWeight? textWeight,
      bool? showBorders,
      bool? showBackgrounds,
      bool? enableEditMode,
      void Function(int)? onSegmentAdd,
      void Function(int)? onSegmentRemove,
      Color? addButtonColor,
      Color? removeButtonColor,
      double? buttonSize,
    }) {
      return TestConfig.createTestApp(
        child: SegmentDisplayWidget<T>(
          values: values ?? (T == int ? testIntValues as List<T> : testDoubleValues as List<T>),
          min: min ?? (T == int ? testIntMin as T : testDoubleMin as T),
          max: max ?? (T == int ? testIntMax as T : testDoubleMax as T),
          contentType: contentType ?? SegmentContentType.fromToRange,
          valueFormatter: valueFormatter,
          height: height ?? SliderConstants.defaultSegmentHeight,
          cardPadding: cardPadding ?? SliderConstants.defaultSegmentCardPadding,
          cardMargin: cardMargin ?? SliderConstants.defaultSegmentCardMargin,
          cardBorderRadius: cardBorderRadius ?? SliderConstants.defaultSegmentCardBorderRadius,
          cardBackgroundColor: cardBackgroundColor ?? SliderConstants.defaultSegmentBackgroundColor,
          cardBorderColor: cardBorderColor ?? SliderConstants.defaultSegmentBorderColor,
          textColor: textColor ?? SliderConstants.defaultSegmentTextColor,
          textSize: textSize ?? SliderConstants.defaultSegmentTextSize,
          textWeight: textWeight ?? FontWeight.normal,
          showBorders: showBorders ?? true,
          showBackgrounds: showBackgrounds ?? true,
          enableEditMode: enableEditMode ?? false,
          onSegmentAdd: onSegmentAdd,
          onSegmentRemove: onSegmentRemove,
          addButtonColor: addButtonColor ?? SliderConstants.defaultSegmentAddButtonColor,
          removeButtonColor: removeButtonColor ?? SliderConstants.defaultSegmentRemoveButtonColor,
          buttonSize: buttonSize ?? SliderConstants.defaultSegmentButtonSize,
        ),
      );
    }

    group('Widget Construction', () {
      test('Widget can be instantiated with int values', () {
        expect(() {
          SegmentDisplayWidget<int>(values: testIntValues, min: testIntMin, max: testIntMax);
        }, returnsNormally);
      });

      test('Widget can be instantiated with double values', () {
        expect(() {
          SegmentDisplayWidget<double>(values: testDoubleValues, min: testDoubleMin, max: testDoubleMax);
        }, returnsNormally);
      });

      test('Widget has correct constructor parameters', () {
        const widget = SegmentDisplayWidget<int>(
          values: testIntValues,
          min: testIntMin,
          max: testIntMax,
          contentType: SegmentContentType.width,
          height: 80.0,
          textColor: Colors.red,
        );

        expect(widget.values, equals(testIntValues));
        expect(widget.min, equals(testIntMin));
        expect(widget.max, equals(testIntMax));
        expect(widget.contentType, equals(SegmentContentType.width));
        expect(widget.height, equals(80.0));
        expect(widget.textColor, equals(Colors.red));
      });

      test('Widget uses default values correctly', () {
        const widget = SegmentDisplayWidget<int>(values: testIntValues, min: testIntMin, max: testIntMax);

        expect(widget.contentType, equals(SegmentContentType.fromToRange));
        expect(widget.height, equals(SliderConstants.defaultSegmentHeight));
        expect(widget.cardPadding, equals(SliderConstants.defaultSegmentCardPadding));
        expect(widget.showBorders, equals(true));
        expect(widget.enableEditMode, equals(false));
      });
    });

    group('Widget Rendering - Display Mode', () {
      testWidgets('Widget renders with correct basic structure', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget<int>());

        // Find the specific SizedBox for the SegmentDisplayWidget (not the TestConfig one)
        final Finder segmentDisplayFinder = find.byType(SegmentDisplayWidget<int>);
        expect(segmentDisplayFinder, findsOneWidget);

        final Finder rowFinder = find.byType(Row);
        expect(rowFinder, findsOneWidget);
      });

      testWidgets('Widget creates correct number of segments for int values', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget<int>(values: [25, 75]));

        // Should create 3 segments: [0-25], [25-75], [75-100]
        final Finder expandedFinder = find.byType(Expanded);
        expect(expandedFinder, findsNWidgets(3));
      });

      testWidgets('Widget creates correct number of segments for empty values', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget<int>(values: []));

        // Should create 1 segment for the entire range
        final Finder expandedFinder = find.byType(Expanded);
        expect(expandedFinder, findsOneWidget);
      });

      testWidgets('Widget displays correct segment content with fromToRange type', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget<int>(values: [50], contentType: SegmentContentType.fromToRange));

        // Should show "0 - 50" and "50 - 100"
        expect(find.text('0 - 50'), findsOneWidget);
        expect(find.text('50 - 100'), findsOneWidget);
      });

      testWidgets('Widget displays correct segment content with toRange type', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget<int>(values: [50], contentType: SegmentContentType.toRange));

        // Should show "- 50" and "- 100"
        expect(find.text('- 50'), findsOneWidget);
        expect(find.text('- 100'), findsOneWidget);
      });

      testWidgets('Widget displays correct segment content with width type', (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestWidget<double>(values: [50.0], min: 0.0, max: 100.0, contentType: SegmentContentType.width),
        );

        // Should show actual numeric widths (not percentages)
        expect(find.text('50.0'), findsNWidgets(2)); // Two segments with width 50.0
      });
    });

    group('Widget Styling', () {
      testWidgets('Widget applies custom styling correctly', (WidgetTester tester) async {
        const customTextColor = Colors.red;
        const customTextSize = 16.0;
        const customBackgroundColor = Colors.yellow;

        await tester.pumpWidget(
          createTestWidget<int>(
            textColor: customTextColor,
            textSize: customTextSize,
            cardBackgroundColor: customBackgroundColor,
          ),
        );

        final Finder textFinder = find.byType(Text).first;
        final Text textWidget = tester.widget(textFinder);
        expect(textWidget.style?.color, equals(customTextColor));
        expect(textWidget.style?.fontSize, equals(customTextSize));

        final Finder containerFinder = find.byType(Container).first;
        final Container container = tester.widget(containerFinder);
        final BoxDecoration decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(customBackgroundColor));
      });

      testWidgets('Widget handles showBorders correctly', (WidgetTester tester) async {
        // Test with borders enabled
        await tester.pumpWidget(createTestWidget<int>(showBorders: true));

        Container container = tester.widget(find.byType(Container).first);
        BoxDecoration decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isNotNull);

        // Test with borders disabled
        await tester.pumpWidget(createTestWidget<int>(showBorders: false));

        container = tester.widget(find.byType(Container).first);
        decoration = container.decoration as BoxDecoration;
        expect(decoration.border, isNull);
      });

      testWidgets('Widget handles showBackgrounds correctly', (WidgetTester tester) async {
        // Test with backgrounds enabled
        await tester.pumpWidget(createTestWidget<int>(showBackgrounds: true));

        Container container = tester.widget(find.byType(Container).first);
        BoxDecoration decoration = container.decoration as BoxDecoration;
        expect(decoration.color, isNot(Colors.transparent));

        // Test with backgrounds disabled
        await tester.pumpWidget(createTestWidget<int>(showBackgrounds: false));

        container = tester.widget(find.byType(Container).first);
        decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(Colors.transparent));
      });
    });

    group('Edit Mode', () {
      testWidgets('Widget switches to edit mode layout when enabled', (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestWidget<int>(enableEditMode: true, onSegmentAdd: (index) {}, onSegmentRemove: (index) {}),
        );

        // Should have add buttons (one before each segment and one after)
        final Finder addButtonFinder = find.byIcon(Icons.add);
        expect(addButtonFinder, findsWidgets); // Should find multiple add buttons

        // Should have remove buttons (one for each segment if there are values)
        final Finder removeButtonFinder = find.byIcon(Icons.close);
        expect(removeButtonFinder, findsWidgets);
      });

      testWidgets('Add button callback works correctly', (WidgetTester tester) async {
        int? addedIndex;

        await tester.pumpWidget(
          createTestWidget<int>(enableEditMode: true, onSegmentAdd: (index) => addedIndex = index),
        );

        final Finder addButtonFinder = find.byIcon(Icons.add).first;
        await tester.tap(addButtonFinder);
        await tester.pump();

        expect(addedIndex, isNotNull);
      });

      testWidgets('Remove button callback works correctly', (WidgetTester tester) async {
        int? removedIndex;

        await tester.pumpWidget(
          createTestWidget<int>(
            enableEditMode: true,
            values: [25, 50, 75], // Multiple values to ensure remove buttons appear
            onSegmentRemove: (index) => removedIndex = index,
          ),
        );

        final Finder removeButtonFinder = find.byIcon(Icons.close).first;
        await tester.tap(removeButtonFinder);
        await tester.pump();

        expect(removedIndex, isNotNull);
      });

      testWidgets('Edit mode buttons use correct colors and sizes', (WidgetTester tester) async {
        const customAddColor = Colors.purple;
        const customRemoveColor = Colors.orange;
        const customButtonSize = 30.0;

        await tester.pumpWidget(
          createTestWidget<int>(
            enableEditMode: true,
            addButtonColor: customAddColor,
            removeButtonColor: customRemoveColor,
            buttonSize: customButtonSize,
          ),
        );

        // Check that add and remove buttons are present
        final Finder addButtonFinder = find.byIcon(Icons.add);
        expect(addButtonFinder, findsWidgets);

        final Finder removeButtonFinder = find.byIcon(Icons.close);
        expect(removeButtonFinder, findsWidgets);

        // Verify button containers have the expected decorations
        final List<Container> allContainers = tester.widgetList<Container>(find.byType(Container)).toList();
        final bool hasAddButtonColor = allContainers.any((container) {
          final BoxDecoration? decoration = container.decoration as BoxDecoration?;
          return decoration?.color == customAddColor;
        });
        final bool hasRemoveButtonColor = allContainers.any((container) {
          final BoxDecoration? decoration = container.decoration as BoxDecoration?;
          return decoration?.color == customRemoveColor;
        });

        expect(hasAddButtonColor, isTrue);
        expect(hasRemoveButtonColor, isTrue);
      });
    });

    group('Value Formatter', () {
      testWidgets('Widget uses custom value formatter correctly', (WidgetTester tester) async {
        String customFormatter(int value) => 'Value: $value';

        await tester.pumpWidget(
          createTestWidget<int>(
            values: [50],
            valueFormatter: customFormatter,
            contentType: SegmentContentType.fromToRange,
          ),
        );

        expect(find.text('Value: 0 - Value: 50'), findsOneWidget);
        expect(find.text('Value: 50 - Value: 100'), findsOneWidget);
      });

      testWidgets('Widget works without value formatter', (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestWidget<int>(values: [50], valueFormatter: null, contentType: SegmentContentType.fromToRange),
        );

        expect(find.text('0 - 50'), findsOneWidget);
        expect(find.text('50 - 100'), findsOneWidget);
      });
    });

    group('Double Values', () {
      testWidgets('Widget handles double values correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestWidget<double>(
            values: [25.5, 75.7],
            min: 0.0,
            max: 100.0,
            contentType: SegmentContentType.fromToRange,
          ),
        );

        expect(find.text('0.0 - 25.5'), findsOneWidget);
        expect(find.text('25.5 - 75.7'), findsOneWidget);
        expect(find.text('75.7 - 100.0'), findsOneWidget);
      });

      testWidgets('Widget formats double values with custom formatter', (WidgetTester tester) async {
        String doubleFormatter(double value) => value.toStringAsFixed(1);

        await tester.pumpWidget(
          createTestWidget<double>(
            values: [25.555],
            min: 0.0,
            max: 100.0,
            valueFormatter: doubleFormatter,
            contentType: SegmentContentType.fromToRange,
          ),
        );

        expect(find.text('0.0 - 25.6'), findsOneWidget);
        expect(find.text('25.6 - 100.0'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('Widget handles single value correctly', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget<int>(values: [50]));

        final Finder expandedFinder = find.byType(Expanded);
        expect(expandedFinder, findsNWidgets(2)); // Two segments
      });

      testWidgets('Widget handles values at boundaries', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget<int>(values: [0, 100], min: 0, max: 100));

        final Finder expandedFinder = find.byType(Expanded);
        expect(expandedFinder, findsNWidgets(3)); // Three segments
      });

      testWidgets('Widget handles unsorted values correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestWidget<int>(
            values: [75, 25, 50], // Unsorted values
            contentType: SegmentContentType.fromToRange,
          ),
        );

        // Should still create correct segments after sorting
        expect(find.text('0 - 25'), findsOneWidget);
        expect(find.text('25 - 50'), findsOneWidget);
        expect(find.text('50 - 75'), findsOneWidget);
        expect(find.text('75 - 100'), findsOneWidget);
      });

      testWidgets('Widget handles very small ranges', (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestWidget<double>(values: [0.5], min: 0.0, max: 1.0, contentType: SegmentContentType.fromToRange),
        );

        expect(find.text('0.0 - 0.5'), findsOneWidget);
        expect(find.text('0.5 - 1.0'), findsOneWidget);
      });

      testWidgets('Widget handles identical min/max values gracefully', (WidgetTester tester) async {
        await tester.pumpWidget(createTestWidget<int>(values: [], min: 50, max: 50));

        // Should not crash, even with identical min/max
        final Finder segmentDisplayFinder = find.byType(SegmentDisplayWidget<int>);
        expect(segmentDisplayFinder, findsOneWidget);
      });
    });

    group('Text Properties', () {
      testWidgets('Widget applies text styling correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          createTestWidget<int>(textWeight: FontWeight.bold, textSize: 20.0, textColor: Colors.blue),
        );

        final Finder textFinder = find.byType(Text).first;
        final Text textWidget = tester.widget(textFinder);

        expect(textWidget.style?.fontWeight, equals(FontWeight.bold));
        expect(textWidget.style?.fontSize, equals(20.0));
        expect(textWidget.style?.color, equals(Colors.blue));
        expect(textWidget.textAlign, equals(TextAlign.center));
        expect(textWidget.maxLines, equals(2));
        expect(textWidget.overflow, equals(TextOverflow.ellipsis));
      });

      testWidgets('Widget handles long text correctly', (WidgetTester tester) async {
        String longFormatter(int value) => 'This is a very long text for value $value that should be truncated';

        await tester.pumpWidget(createTestWidget<int>(values: [50], valueFormatter: longFormatter));

        final Finder textFinder = find.byType(Text).first;
        final Text textWidget = tester.widget(textFinder);

        expect(textWidget.maxLines, equals(2));
        expect(textWidget.overflow, equals(TextOverflow.ellipsis));
      });
    });
  });
}
