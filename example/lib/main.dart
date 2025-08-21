import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'widgets/common/example_card.dart';
import 'widgets/examples/examples.dart';

/// Multi-Thumb Slider Example Application
///
/// This application demonstrates the various features and use cases of the
/// multi_thumb_slider package through interactive examples.
///
/// The app is organized into separate example widgets, each showcasing
/// different aspects of the slider functionality.
void main() {
  runApp(const MultiThumbSliderExampleApp());
}

/// Root application widget
class MultiThumbSliderExampleApp extends StatelessWidget {
  const MultiThumbSliderExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      theme: _buildTheme(),
      home: const ExamplesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  /// Builds the application theme
  ThemeData _buildTheme() {
    return ThemeData(
      fontFamily: AppConstants.fontFamily,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.primaryColor, brightness: Brightness.light),
    );
  }
}

/// Main examples screen containing all slider demonstrations
class ExamplesScreen extends StatefulWidget {
  const ExamplesScreen({super.key});

  @override
  State<ExamplesScreen> createState() => _ExamplesScreenState();
}

class _ExamplesScreenState extends State<ExamplesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), backgroundColor: AppConstants.backgroundColor, body: _buildBody());
  }

  /// Builds the application bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(AppConstants.appTitle),
      elevation: AppConstants.appBarElevation,
      backgroundColor: Colors.teal.shade700,
      foregroundColor: Colors.white,
    );
  }

  /// Builds the main body content
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(),
          const SizedBox(height: AppConstants.sectionSpacing),
          ..._buildExampleSections(),
        ],
      ),
    );
  }

  /// Builds the page header
  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Examples',
          style: TextStyle(
            fontSize: AppConstants.titleFontSize,
            fontWeight: FontWeight.bold,
            color: AppConstants.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppConstants.itemSpacing),
        Text(
          'Explore the various features and use cases of the Multi-Thumb Slider',
          style: TextStyle(fontSize: AppConstants.bodyFontSize, color: AppConstants.textSecondaryColor),
        ),
      ],
    );
  }

  /// Builds all example sections
  List<Widget> _buildExampleSections() {
    final examples = _getExampleData();

    return examples.map((example) {
      return Column(
        children: [
          ExampleCard(
            title: example['title'] as String,
            description: example['description'] as String,
            child: example['widget'] as Widget,
          ),
          const SizedBox(height: AppConstants.sectionSpacing),
        ],
      );
    }).toList();
  }

  /// Gets the example data with titles, descriptions, and widgets
  List<Map<String, dynamic>> _getExampleData() {
    return [
      {
        'title': 'Basic Multi-Thumb Slider (Int)',
        'description':
            'Simple slider with three thumbs for range selection using int values. '
            'Features percentage formatting, tickmarks, labels, and visual segment display.',
        'widget': const BasicExampleWidget(),
      },
      {
        'title': 'Double Values Slider',
        'description':
            'Slider using double values for precise measurements. '
            'Demonstrates decimal precision and smooth value transitions.',
        'widget': const DoubleExampleWidget(),
      },
      {
        'title': 'Dan Belt Ranking Slider',
        'description':
            'Martial arts belt ranking system from 1st Dan to 10th Dan. '
            'Shows enum value handling with educational information and color coding.',
        'widget': const DanRankExampleWidget(),
      },
      {
        'title': 'Price Range Selector',
        'description':
            'E-commerce style price range with custom colors and currency formatting. '
            'Perfect for filtering products by price categories.',
        'widget': const PriceRangeExampleWidget(),
      },
      {
        'title': 'Weight Class Selector',
        'description':
            'Sports/fitness application with larger thumbs and weight formatting. '
            'Demonstrates enhanced touch interaction for mobile devices.',
        'widget': const WeightClassExampleWidget(),
      },
      {
        'title': 'Custom Styling',
        'description':
            'Fully customized appearance and colors showing the complete range '
            'of visual customization options available.',
        'widget': const CustomStylingExampleWidget(),
      },
      {
        'title': 'Read-Only Mode',
        'description':
            'Display-only slider with disabled interaction. '
            'Useful for data visualization and status indicators.',
        'widget': const ReadOnlyExampleWidget(),
      },
    ];
  }
}
