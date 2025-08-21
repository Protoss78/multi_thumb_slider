import 'package:flutter/material.dart';

/// Service for calculating positions and handling positioning logic
class PositionCalculator {
  final GlobalKey sliderKey;
  
  PositionCalculator(this.sliderKey);
  
  /// Calculates normalized position from global coordinates
  double calculateNormalizedPosition(Offset globalPosition) {
    final RenderBox? renderBox = sliderKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return 0.0;
    
    final Offset localPosition = renderBox.globalToLocal(globalPosition);
    final double normalizedPosition = localPosition.dx / renderBox.size.width;
    return normalizedPosition.clamp(0.0, 1.0);
  }
  
  /// Finds the thumb index closest to a given position
  int findNearestThumbIndex(double normalizedPosition, List<double> normalizedPositions) {
    int nearestIndex = 0;
    double minDistance = double.infinity;
    
    for (int i = 0; i < normalizedPositions.length; i++) {
      final double distance = (normalizedPosition - normalizedPositions[i]).abs();
      if (distance < minDistance) {
        minDistance = distance;
        nearestIndex = i;
      }
    }
    
    return nearestIndex;
  }
  
  /// Calculates boundaries for a thumb based on neighboring thumbs
  double calculateLowerBound(int thumbIndex, List<double> normalizedPositions) {
    return thumbIndex == 0 ? 0.0 : normalizedPositions[thumbIndex - 1];
  }
  
  /// Calculates upper boundary for a thumb based on neighboring thumbs
  double calculateUpperBound(int thumbIndex, List<double> normalizedPositions) {
    return thumbIndex == normalizedPositions.length - 1 ? 1.0 : normalizedPositions[thumbIndex + 1];
  }
}
