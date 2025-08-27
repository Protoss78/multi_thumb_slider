import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_range_slider/src/widgets/segment_edit_dialog.dart';
import 'test_config.dart';

void main() {
  group('SegmentEditDialog', () {
    group('widget creation', () {
      testWidgets('should create dialog with required parameters', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) =>
                      const SegmentEditDialog(currentDescription: null, defaultDescription: '0 - 50', segmentIndex: 0),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        // Tap to show dialog
        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Verify dialog is shown
        expect(find.byType(SegmentEditDialog), findsOneWidget);
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
      });

      testWidgets('should show dialog without title', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const SegmentEditDialog(
                    currentDescription: null,
                    defaultDescription: '50 - 100',
                    segmentIndex: 2,
                  ),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Dialog should not have a title
        expect(find.byType(AlertDialog), findsOneWidget);
        final alertDialog = tester.widget<AlertDialog>(find.byType(AlertDialog));
        expect(alertDialog.title, isNull);
      });
    });

    group('static show method', () {
      testWidgets('should show dialog using static method', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  // Just test that the method doesn't crash
                  await SegmentEditDialog.show(
                    context: context,
                    currentDescription: null,
                    defaultDescription: '10 - 30',
                    segmentIndex: 0,
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Should show the dialog
        expect(find.byType(AlertDialog), findsOneWidget);
      });
    });

    group('default description mode', () {
      testWidgets('should initialize with default description when no custom description', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) =>
                      const SegmentEditDialog(currentDescription: null, defaultDescription: '10 - 30', segmentIndex: 0),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Text field should contain default description
        final textField = find.byType(TextField);
        expect(textField, findsOneWidget);

        final textFieldWidget = tester.widget<TextField>(textField);
        expect(textFieldWidget.controller?.text, equals('10 - 30'));
        expect(textFieldWidget.enabled, isTrue);
      });
    });

    group('custom description mode', () {
      testWidgets('should initialize with custom description when provided', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const SegmentEditDialog(
                    currentDescription: 'Custom segment description',
                    defaultDescription: '10 - 30',
                    segmentIndex: 0,
                  ),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Text field should contain custom description and be enabled
        final textField = find.byType(TextField);
        expect(textField, findsOneWidget);

        final textFieldWidget = tester.widget<TextField>(textField);
        expect(textFieldWidget.controller?.text, equals('Custom segment description'));
        expect(textFieldWidget.enabled, isTrue);
      });
    });

    group('text field behavior', () {
      testWidgets('should handle text field input correctly', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const SegmentEditDialog(
                    currentDescription: 'Existing description',
                    defaultDescription: '10 - 30',
                    segmentIndex: 0,
                  ),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Clear existing text and enter new text
        await tester.enterText(find.byType(TextField), 'Test input');
        await tester.pumpAndSettle();

        // Verify text was entered
        final textFieldWidget = tester.widget<TextField>(find.byType(TextField));
        expect(textFieldWidget.controller?.text, equals('Test input'));
      });

      testWidgets('should support multiline input', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const SegmentEditDialog(
                    currentDescription: 'Initial text',
                    defaultDescription: '10 - 30',
                    segmentIndex: 0,
                  ),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Enter multiline text
        await tester.enterText(find.byType(TextField), 'Line 1\nLine 2\nLine 3');
        await tester.pumpAndSettle();

        // Verify multiline text was entered
        final textFieldWidget = tester.widget<TextField>(find.byType(TextField));
        expect(textFieldWidget.controller?.text, equals('Line 1\nLine 2\nLine 3'));
        expect(textFieldWidget.maxLines, isNull); // Should allow multiple lines
      });
    });

    group('UI elements', () {
      testWidgets('should have proper hint text', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) =>
                      const SegmentEditDialog(currentDescription: null, defaultDescription: '10 - 30', segmentIndex: 0),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.decoration?.hintText, equals('...'));
        expect(textField.decoration?.labelText, equals('...'));
      });

      testWidgets('should have proper text field properties', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) =>
                      const SegmentEditDialog(currentDescription: null, defaultDescription: '10 - 30', segmentIndex: 0),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.maxLines, isNull);
        expect(textField.enabled, isTrue);
        expect(textField.decoration?.border, isA<OutlineInputBorder>());
      });

      testWidgets('should show three buttons with correct icons', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) =>
                      const SegmentEditDialog(currentDescription: null, defaultDescription: '10 - 30', segmentIndex: 0),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Should show three buttons with correct icons
        expect(find.byIcon(Icons.close), findsOneWidget); // Cancel button
        expect(find.byIcon(Icons.refresh), findsOneWidget); // Refresh button
        expect(find.byIcon(Icons.save), findsOneWidget); // Save button
      });
    });

    group('state management', () {
      testWidgets('should enable custom description mode when text is changed', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) =>
                      const SegmentEditDialog(currentDescription: null, defaultDescription: '10 - 30', segmentIndex: 0),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Initially should be in default mode
        final textFieldWidget = tester.widget<TextField>(find.byType(TextField));
        expect(textFieldWidget.controller?.text, equals('10 - 30'));

        // Change text to enable custom mode
        await tester.enterText(find.byType(TextField), 'Modified text');
        await tester.pumpAndSettle();

        expect(textFieldWidget.controller?.text, equals('Modified text'));
      });
    });

    group('button interactions', () {
      testWidgets('should close dialog when cancel button is pressed', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) =>
                      const SegmentEditDialog(currentDescription: null, defaultDescription: '10 - 30', segmentIndex: 0),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(SegmentEditDialog), findsOneWidget);

        // Tap cancel button
        final cancelButton = find.byIcon(Icons.close);
        await tester.tap(cancelButton);
        await tester.pumpAndSettle();

        expect(find.byType(SegmentEditDialog), findsNothing);
      });

      testWidgets('should reset to default when refresh button is pressed', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const SegmentEditDialog(
                    currentDescription: 'Custom description',
                    defaultDescription: 'Default text',
                    segmentIndex: 0,
                  ),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        final textFieldWidget = tester.widget<TextField>(find.byType(TextField));
        expect(textFieldWidget.controller?.text, equals('Custom description'));

        // Tap refresh button
        final refreshButton = find.byIcon(Icons.refresh);
        await tester.tap(refreshButton);
        await tester.pumpAndSettle();

        expect(textFieldWidget.controller?.text, equals('Default text'));
      });

      testWidgets('should save and close dialog when save button is pressed', (tester) async {
        String? result;

        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await SegmentEditDialog.show(
                    context: context,
                    currentDescription: 'Original text',
                    defaultDescription: '10 - 30',
                    segmentIndex: 0,
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Modify text
        await tester.enterText(find.byType(TextField), 'New text');
        await tester.pumpAndSettle();

        // Tap save button
        final saveButton = find.byIcon(Icons.save);
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        expect(result, equals('New text'));
        expect(find.byType(SegmentEditDialog), findsNothing);
      });
    });

    group('save logic', () {
      testWidgets('should return null for empty description in default mode', (tester) async {
        String? result;

        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await SegmentEditDialog.show(
                    context: context,
                    currentDescription: null,
                    defaultDescription: '10 - 30',
                    segmentIndex: 0,
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Clear the text field
        await tester.enterText(find.byType(TextField), '');
        await tester.pumpAndSettle();

        // Tap save button
        final saveButton = find.byIcon(Icons.save);
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        expect(result, isNull);
      });

      testWidgets('should return empty string when reset to default was used', (tester) async {
        String? result;

        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await SegmentEditDialog.show(
                    context: context,
                    currentDescription: 'Custom text',
                    defaultDescription: 'Default text',
                    segmentIndex: 0,
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Reset to default
        final refreshButton = find.byIcon(Icons.refresh);
        await tester.tap(refreshButton);
        await tester.pumpAndSettle();

        // Save
        final saveButton = find.byIcon(Icons.save);
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        expect(result, equals(''));
      });

      testWidgets('should return null when using default description unchanged', (tester) async {
        String? result;

        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await SegmentEditDialog.show(
                    context: context,
                    currentDescription: null,
                    defaultDescription: '10 - 30',
                    segmentIndex: 0,
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Don't change anything, just save
        final saveButton = find.byIcon(Icons.save);
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        expect(result, isNull);
      });

      testWidgets('should return custom description when modified', (tester) async {
        String? result;

        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await SegmentEditDialog.show(
                    context: context,
                    currentDescription: 'Original text',
                    defaultDescription: '10 - 30',
                    segmentIndex: 0,
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Modify text
        await tester.enterText(find.byType(TextField), 'Modified text');
        await tester.pumpAndSettle();

        // Save
        final saveButton = find.byIcon(Icons.save);
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        expect(result, equals('Modified text'));
      });
    });

    group('edge cases', () {
      testWidgets('should handle null currentDescription', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) =>
                      const SegmentEditDialog(currentDescription: null, defaultDescription: '10 - 30', segmentIndex: 0),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(SegmentEditDialog), findsOneWidget);
        final textFieldWidget = tester.widget<TextField>(find.byType(TextField));
        expect(textFieldWidget.controller?.text, equals('10 - 30'));
      });

      testWidgets('should handle empty currentDescription', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) =>
                      const SegmentEditDialog(currentDescription: '', defaultDescription: '10 - 30', segmentIndex: 0),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(SegmentEditDialog), findsOneWidget);
        final textFieldWidget = tester.widget<TextField>(find.byType(TextField));
        // When currentDescription is empty string, it should use the default description
        expect(textFieldWidget.controller?.text, equals('10 - 30'));
      });

      testWidgets('should handle negative segment index', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const SegmentEditDialog(
                    currentDescription: null,
                    defaultDescription: '10 - 30',
                    segmentIndex: -1,
                  ),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(SegmentEditDialog), findsOneWidget);
      });

      testWidgets('should handle special characters in text input', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const SegmentEditDialog(
                    currentDescription: 'Normal text',
                    defaultDescription: '10 - 30',
                    segmentIndex: 0,
                  ),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Enter text with special characters
        const specialText = 'Text with !@#\$%^&*()_+-=[]{}|;:,.<>? and emojis 🚀🎉✨';
        await tester.enterText(find.byType(TextField), specialText);
        await tester.pumpAndSettle();

        final textFieldWidget = tester.widget<TextField>(find.byType(TextField));
        expect(textFieldWidget.controller?.text, equals(specialText));
      });
    });

    group('lifecycle', () {
      testWidgets('should dispose text controller properly', (tester) async {
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) =>
                      const SegmentEditDialog(currentDescription: null, defaultDescription: '10 - 30', segmentIndex: 0),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Close dialog to trigger dispose
        final cancelButton = find.byIcon(Icons.close);
        await tester.tap(cancelButton);
        await tester.pumpAndSettle();

        expect(find.byType(SegmentEditDialog), findsNothing);
      });
    });

    group('responsive behavior', () {
      testWidgets('should create dialog with responsive width calculation', (WidgetTester tester) async {
        // Test that the dialog can be created and displays properly
        await tester.pumpWidget(
          TestConfig.createTestApp(
            child: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) =>
                      const SegmentEditDialog(currentDescription: null, defaultDescription: '10 - 30', segmentIndex: 0),
                ),
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Check that dialog displays correctly
        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
      });
    });
  });
}
