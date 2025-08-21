import 'package:flutter/material.dart';
import 'package:multi_thumb_slider/multi_thumb_slider.dart';
import '../../constants/app_constants.dart';

/// Price range slider example for e-commerce applications
///
/// This widget demonstrates:
/// - Custom color scheme suitable for pricing
/// - Price formatting with currency symbols
/// - Range selection for filtering products
/// - E-commerce style visual design
class PriceRangeExampleWidget extends StatefulWidget {
  const PriceRangeExampleWidget({super.key});

  @override
  State<PriceRangeExampleWidget> createState() => _PriceRangeExampleWidgetState();
}

class _PriceRangeExampleWidgetState extends State<PriceRangeExampleWidget> {
  List<int> _values = List.from(ExampleData.priceValues);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSlider(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildPriceDisplay(),
        const SizedBox(height: AppConstants.itemSpacing),
        _buildPriceRangeInfo(),
      ],
    );
  }

  /// Builds the main slider widget
  Widget _buildSlider() {
    return CustomMultiThumbSlider.withInt(
      values: _values,
      min: ExampleData.priceMin,
      max: ExampleData.priceMax,
      rangeColors: SliderColorSchemes.priceRangeColors,
      showTooltip: true,
      tooltipColor: SliderColorSchemes.priceTooltipColor,
      tooltipTextColor: Colors.white,
      tooltipTextSize: 13.0,
      valueFormatter: Formatters.price,
      onChanged: _handleValueChange,
    );
  }

  /// Builds the price range display
  Widget _buildPriceDisplay() {
    return Text(
      'Price ranges: ${_values.map(Formatters.price).join(", ")}',
      style: TextStyle(fontSize: AppConstants.bodyFontSize, color: AppConstants.textSecondaryColor),
    );
  }

  /// Builds additional price range information
  Widget _buildPriceRangeInfo() {
    final categories = _getPriceCategories();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shopping_cart, color: Colors.green[700], size: 16),
              const SizedBox(width: 8),
              Text(
                'Price Categories',
                style: TextStyle(
                  fontSize: AppConstants.captionFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...categories.map((category) => _buildCategoryRow(category)),
        ],
      ),
    );
  }

  /// Gets price category information
  List<Map<String, dynamic>> _getPriceCategories() {
    final sortedValues = List<int>.from(_values)..sort();
    final ranges = [ExampleData.priceMin, ...sortedValues, ExampleData.priceMax];

    return [
      {
        'range': '${Formatters.price(ranges[0])} - ${Formatters.price(ranges[1])}',
        'category': 'Budget',
        'color': SliderColorSchemes.priceRangeColors[0],
      },
      {
        'range': '${Formatters.price(ranges[1])} - ${Formatters.price(ranges[2])}',
        'category': 'Mid-range',
        'color': SliderColorSchemes.priceRangeColors[1],
      },
      {
        'range': '${Formatters.price(ranges[2])} - ${Formatters.price(ranges[3])}',
        'category': 'Premium',
        'color': SliderColorSchemes.priceRangeColors[2],
      },
    ];
  }

  /// Builds a category information row
  Widget _buildCategoryRow(Map<String, dynamic> category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: category['color'] as Color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${category['category']}: ${category['range']}',
              style: TextStyle(fontSize: AppConstants.smallFontSize, color: Colors.green[700]),
            ),
          ),
        ],
      ),
    );
  }

  /// Handles slider value changes
  void _handleValueChange(List<int> newValues) {
    setState(() {
      _values = newValues;
    });
  }
}
