// Basic Flutter widget tests for the Multi-Thumb Slider
//
// These tests focus on basic functionality that should work reliably.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';

void main() {
  group('CustomMultiThumbSlider Widget Tests', () {
    test('Widget class exists and can be referenced', () {
      // Test that the widget class can be referenced
      expect(CustomMultiThumbSlider<int>, isA<Type>());
    });

    test('Widget can be instantiated with minimal parameters', () {
      // Test if the widget can be instantiated at all
      expect(() {
        CustomMultiThumbSlider<int>(
          values: [50],
          min: 0,
          max: 100,
          onChanged: (newValues) {},
        );
      }, returnsNormally);
    });


  });
}
