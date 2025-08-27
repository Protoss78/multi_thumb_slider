import 'package:flutter/material.dart';
import 'package:multi_thumb_range_slider/multi_thumb_range_slider.dart';
import '../../constants/app_constants.dart';
import '../../models/dan_rank.dart';
import '../../utils/dan_rank_utils.dart';

/// Dan rank slider example demonstrating enum value handling
///
/// This widget shows a multi-thumb slider with:
/// - Enum values (DanRank) from 1st to 10th Dan
/// - Custom formatting with Japanese names
/// - Tickmarks and labels for each rank
/// - Visual rank indicators with appropriate colors
/// - Educational information about martial arts rankings
class DanRankExampleWidget extends StatefulWidget {
  const DanRankExampleWidget({super.key});

  @override
  State<DanRankExampleWidget> createState() => _DanRankExampleWidgetState();
}

class _DanRankExampleWidgetState extends State<DanRankExampleWidget> {
  List<DanRank> _values = [DanRank.fifthDan, DanRank.eighthDan];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSlider(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildRankDisplay(),
        const SizedBox(height: AppConstants.largeSpacing),
        _buildRankChips(),
        const SizedBox(height: AppConstants.itemSpacing),
        _buildEducationalInfo(),
      ],
    );
  }

  /// Builds the main slider widget
  Widget _buildSlider() {
    return CustomMultiThumbSlider.withEnum<DanRank>(
      values: _values,
      min: DanRank.firstDan,
      max: DanRank.tenthDan,
      allPossibleValues: DanRank.values,
      trackHeight: 8.0,
      showTickmarks: true,
      tickmarkColor: SliderColorSchemes.danTooltipColor,
      tickmarkSize: 8.0,
      tickmarkInterval: 1,
      showTickmarkLabels: true,
      tickmarkLabelInterval: 1,
      tickmarkLabelColor: SliderColorSchemes.danTooltipColor,
      tickmarkLabelSize: 11.0,
      tickmarkPosition: TickmarkPosition.below,
      tickmarkSpacing: 8.0,
      labelSpacing: 4.0,
      showTooltip: true,
      tooltipColor: SliderColorSchemes.danTooltipColor,
      tooltipTextColor: Colors.white,
      tooltipTextSize: 12.0,
      valueFormatter: (value) => value.displayName,
      onChanged: _handleValueChange,
    );
  }

  /// Builds the rank information display
  Widget _buildRankDisplay() {
    return Column(
      children: [
        Text(
          'Selected Ranks: ${_values.map((v) => v.displayName).join(", ")}',
          style: TextStyle(
            fontSize: AppConstants.bodyFontSize,
            color: AppConstants.textSecondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.itemSpacing),
        Text(
          'Japanese Names: ${_values.map((v) => v.japaneseName).join(", ")}',
          style: TextStyle(
            fontSize: AppConstants.captionFontSize,
            color: AppConstants.textCaptionColor,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  /// Builds visual rank indicators (chips)
  Widget _buildRankChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _values
          .map((rank) => DanRankUtils.createDanRankChip(rank))
          .toList(),
    );
  }

  /// Builds educational information about the rankings
  Widget _buildEducationalInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange[700], size: 16),
              const SizedBox(width: 8),
              Text(
                'Dan Ranking System',
                style: TextStyle(
                  fontSize: AppConstants.captionFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildRankCategories(),
        ],
      ),
    );
  }

  /// Builds the rank categories information
  Widget _buildRankCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCategoryInfo(
          'Junior (1st-2nd Dan)',
          DanRankUtils.getDanColor(DanRank.firstDan),
        ),
        _buildCategoryInfo(
          'Intermediate (3rd-5th Dan)',
          DanRankUtils.getDanColor(DanRank.thirdDan),
        ),
        _buildCategoryInfo(
          'Senior (6th-7th Dan)',
          DanRankUtils.getDanColor(DanRank.sixthDan),
        ),
        _buildCategoryInfo(
          'Master (8th-10th Dan)',
          DanRankUtils.getDanColor(DanRank.eighthDan),
        ),
      ],
    );
  }

  /// Builds individual category information
  Widget _buildCategoryInfo(String category, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            category,
            style: TextStyle(
              fontSize: AppConstants.smallFontSize,
              color: Colors.orange[700],
            ),
          ),
        ],
      ),
    );
  }

  /// Handles slider value changes
  void _handleValueChange(List<DanRank> newValues) {
    setState(() {
      _values = newValues;
    });
  }
}
