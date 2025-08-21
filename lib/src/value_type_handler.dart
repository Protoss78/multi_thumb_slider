/// Abstract base class for handling different value types in the slider
abstract class ValueTypeHandler<T> {
  /// Converts a value to a normalized position (0.0-1.0)
  double toNormalized(T value, T min, T max);
  
  /// Converts a normalized position back to a value
  T fromNormalized(double normalized, T min, T max);
  
  /// Gets all possible values between min and max
  List<T> getAllPossibleValues(T min, T max, List<T>? allPossibleValues);
  
  /// Checks if tickmarks should be shown for this type
  bool shouldShowTickmarks();
  
  /// Formats a value for display
  String formatValue(T value, String Function(T)? customFormatter);
}

/// Handler for numeric value types (int, double)
class NumericValueHandler<T extends num> implements ValueTypeHandler<T> {
  @override
  double toNormalized(T value, T min, T max) {
    return (value - min) / (max - min);
  }
  
  @override
  T fromNormalized(double normalized, T min, T max) {
    final double value = normalized * (max.toDouble() - min.toDouble()) + min.toDouble();
    
    if (T == int) {
      return value.round() as T;
    } else {
      return value as T;
    }
  }
  
  @override
  List<T> getAllPossibleValues(T min, T max, List<T>? allPossibleValues) {
    if (allPossibleValues != null) return allPossibleValues;
    
    final List<T> values = [];
    if (T == int) {
      for (int i = min.toInt(); i <= max.toInt(); i++) {
        values.add(i as T);
      }
    } else {
      // For doubles, we can't enumerate all possible values
      values.add(min);
      values.add(max);
    }
    return values;
  }
  
  @override
  bool shouldShowTickmarks() => true;
  
  @override
  String formatValue(T value, String Function(T)? customFormatter) {
    if (customFormatter != null) return customFormatter(value);
    return value.toString();
  }
}

/// Handler for enum value types
class EnumValueHandler<T extends Enum> implements ValueTypeHandler<T> {
  @override
  double toNormalized(T value, T min, T max) {
    final int minIndex = min.index;
    final int maxIndex = max.index;
    final int valueIndex = value.index;
    return (valueIndex - minIndex) / (maxIndex - minIndex);
  }
  
  @override
  T fromNormalized(double normalized, T min, T max) {
    // For enums, we need allPossibleValues to convert normalized positions back
    // This is a limitation of the current implementation
    // In practice, this method should not be called directly for enums
    return min;
  }
  
  @override
  List<T> getAllPossibleValues(T min, T max, List<T>? allPossibleValues) {
    if (allPossibleValues == null) {
      throw ArgumentError('allPossibleValues must be provided for enum types');
    }
    
    final int minIndex = min.index;
    final int maxIndex = max.index;
    final int startIndex = minIndex < maxIndex ? minIndex : maxIndex;
    final int endIndex = minIndex < maxIndex ? maxIndex : minIndex;
    
    return allPossibleValues.where((value) {
      final int index = value.index;
      return index >= startIndex && index <= endIndex;
    }).toList();
  }
  
  @override
  bool shouldShowTickmarks() => true;
  
  @override
  String formatValue(T value, String Function(T)? customFormatter) {
    if (customFormatter != null) return customFormatter(value);
    return value.toString().split('.').last;
  }
}

/// Handler for generic value types
class GenericValueHandler<T> implements ValueTypeHandler<T> {
  @override
  double toNormalized(T value, T min, T max) {
    // Use runtime type checking to handle different types
    if (min is num && max is num && value is num) {
      return (value - min) / (max - min);
    } else if (min is Enum && max is Enum && value is Enum) {
      final int minIndex = min.index;
      final int maxIndex = max.index;
      final int valueIndex = value.index;
      return (valueIndex - minIndex) / (maxIndex - minIndex);
    } else {
      // For other types, we can't easily calculate normalized positions
      return 0.5;
    }
  }
  
  @override
  T fromNormalized(double normalized, T min, T max) {
    // Use runtime type checking to handle different types
    if (min is num && max is num) {
      final double value = normalized * (max.toDouble() - min.toDouble()) + min.toDouble();
      
      if (T == int) {
        return value.round() as T;
      } else if (T == double) {
        return value as T;
      } else {
        return value as T;
      }
    } else if (min is Enum && max is Enum) {
      // For enums, we need allPossibleValues to convert normalized positions back
      // This is a limitation of the current implementation
      return min;
    } else {
      // For other types, we can't easily convert normalized positions back
      return min;
    }
  }
  
  @override
  List<T> getAllPossibleValues(T min, T max, List<T>? allPossibleValues) {
    if (allPossibleValues != null) return allPossibleValues;
    
    if (min is num && max is num) {
      final List<T> values = [];
      if (T == int) {
        for (int i = min.toInt(); i <= max.toInt(); i++) {
          values.add(i as T);
        }
      } else {
        // For doubles, we can't enumerate all possible values
        values.add(min);
        values.add(max);
      }
      return values;
    } else if (min is Enum && max is Enum) {
      // For enums, we need allPossibleValues to be provided
      return [min, max];
    } else {
      return [min, max];
    }
  }
  
  @override
  bool shouldShowTickmarks() {
    // This method doesn't have access to min/max, so we'll return true
    // The actual check will be done at runtime in the calling code
    return true;
  }
  
  @override
  String formatValue(T value, String Function(T)? customFormatter) {
    if (customFormatter != null) return customFormatter(value);
    
    if (value is num) {
      return value.toString();
    } else if (value is Enum) {
      return value.toString().split('.').last;
    } else {
      return value.toString();
    }
  }
}

/// Factory for creating appropriate value type handlers
class ValueTypeHandlerFactory {
  static ValueTypeHandler<T> create<T>() {
    // Use runtime type checking instead of compile-time type checking
    // This is a workaround for Dart's generic type system limitations
    return GenericValueHandler<T>();
  }
}
