import 'package:flutter/material.dart';

/// Test configuration and utilities for the multi-thumb slider tests
class TestConfig {
  /// Common test colors for consistent testing
  static const List<Color> testColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
  ];

  /// Common test values for int sliders
  static const List<int> testIntValues = [0, 25, 50, 75, 100];

  /// Common test values for double sliders
  static const List<double> testDoubleValues = [0.0, 25.5, 50.0, 75.7, 100.0];

  /// Test enum for difficulty levels
  static const List<TestDifficulty> testEnumValues = [
    TestDifficulty.easy,
    TestDifficulty.medium,
    TestDifficulty.hard,
    TestDifficulty.expert,
  ];

  /// Common test dimensions
  static const double testHeight = 30.0;
  static const double testThumbRadius = 15.0;
  static const double testWidth = 300.0;

  /// Creates a test MaterialApp wrapper with proper configuration
  static Widget createTestApp({required Widget child, ThemeData? theme}) {
    return MaterialApp(
      theme: theme ?? ThemeData(),
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: testWidth,
            height: 200, // Provide height constraint
            child: child,
          ),
        ),
      ),
    );
  }

  /// Creates a mock gesture details object for testing
  static DragStartDetails createMockDragStartDetails({Offset? globalPosition}) {
    return DragStartDetails(
      globalPosition: globalPosition ?? const Offset(100, 100),
    );
  }

  /// Creates a mock gesture update details object for testing
  static DragUpdateDetails createMockDragUpdateDetails({
    Offset? globalPosition,
    Offset? delta,
  }) {
    return DragUpdateDetails(
      globalPosition: globalPosition ?? const Offset(150, 100),
      delta: delta ?? const Offset(50, 0),
    );
  }

  /// Creates a mock gesture end details object for testing
  static DragEndDetails createMockDragEndDetails({Velocity? velocity}) {
    return DragEndDetails(
      velocity: velocity ?? const Velocity(pixelsPerSecond: Offset(100, 0)),
    );
  }
}

/// Test enum for difficulty levels
enum TestDifficulty { easy, medium, hard, expert }

/// Mock callback functions for testing
class MockCallbacks {
  static void Function(List<int>)? intCallback;
  static void Function(List<double>)? doubleCallback;
  static void Function(List<TestDifficulty>)? enumCallback;

  static void Function(List<int>) createIntCallback() {
    return (values) => intCallback?.call(values);
  }

  static void Function(List<double>) createDoubleCallback() {
    return (values) => doubleCallback?.call(values);
  }

  static void Function(List<TestDifficulty>) createEnumCallback() {
    return (values) => enumCallback?.call(values);
  }

  static void reset() {
    intCallback = null;
    doubleCallback = null;
    enumCallback = null;
  }
}
