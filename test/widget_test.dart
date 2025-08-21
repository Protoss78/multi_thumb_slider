// Basic test to verify the widget can be imported
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

void main() {
  test('Widget can be imported', () {
    // Just verify the import works
    expect(CustomMultiThumbSlider<int>, isA<Type>());
  });
}
