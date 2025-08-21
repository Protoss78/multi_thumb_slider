import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

/// A reusable card widget for displaying examples
///
/// This widget provides a consistent layout and styling for all example
/// demonstrations, including title, description, and content areas.
class ExampleCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;
  final EdgeInsets? padding;
  final bool showDivider;

  const ExampleCard({
    super.key,
    required this.title,
    required this.description,
    required this.child,
    this.padding,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppConstants.cardElevation,
      color: AppConstants.cardBackgroundColor,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppConstants.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (showDivider) ...[const SizedBox(height: AppConstants.itemSpacing), _buildDivider()],
            const SizedBox(height: AppConstants.largeSpacing),
            child,
          ],
        ),
      ),
    );
  }

  /// Builds the card header with title and description
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: AppConstants.cardTitleFontSize,
            fontWeight: FontWeight.bold,
            color: AppConstants.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppConstants.itemSpacing),
        Text(
          description,
          style: TextStyle(fontSize: AppConstants.captionFontSize, color: AppConstants.textCaptionColor),
        ),
      ],
    );
  }

  /// Builds a visual divider between header and content
  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.transparent, Colors.grey.shade300, Colors.transparent]),
      ),
    );
  }
}

/// A specialized card for feature highlights
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color? iconColor;
  final Color? backgroundColor;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: (iconColor ?? Colors.blue).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor ?? Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: AppConstants.captionFontSize,
                    fontWeight: FontWeight.bold,
                    color: iconColor ?? Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: AppConstants.smallFontSize, color: iconColor ?? Colors.blue[700]),
          ),
        ],
      ),
    );
  }
}

/// A simple info chip widget for displaying status or categories
class InfoChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const InfoChip({super.key, required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 12, color: color), const SizedBox(width: 4)],
          Text(
            label,
            style: TextStyle(fontSize: AppConstants.smallFontSize, fontWeight: FontWeight.w500, color: color),
          ),
        ],
      ),
    );
  }
}
