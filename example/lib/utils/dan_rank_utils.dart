import 'package:flutter/material.dart';
import '../models/dan_rank.dart';
import '../constants/app_constants.dart';

/// Utility class for Dan rank related operations and styling
class DanRankUtils {
  /// Returns the appropriate color for a given Dan rank based on level
  static Color getDanColor(DanRank rank) {
    if (rank.isMasterLevel) {
      return SliderColorSchemes.masterDanColor;
    } else if (rank.isSeniorLevel) {
      return SliderColorSchemes.seniorDanColor;
    } else if (rank.isIntermediateLevel) {
      return SliderColorSchemes.intermediateDanColor;
    } else {
      return SliderColorSchemes.juniorDanColor;
    }
  }

  /// Returns a descriptive category name for the Dan rank level
  static String getDanCategory(DanRank rank) {
    if (rank.isMasterLevel) {
      return 'Master Level';
    } else if (rank.isSeniorLevel) {
      return 'Senior Level';
    } else if (rank.isIntermediateLevel) {
      return 'Intermediate Level';
    } else {
      return 'Junior Level';
    }
  }

  /// Returns a list of all Dan ranks in a specific category
  static List<DanRank> getDanRanksByCategory(String category) {
    return DanRank.values.where((rank) {
      return getDanCategory(rank) == category;
    }).toList();
  }

  /// Returns the years typically required to achieve each Dan rank
  static int getTypicalYearsToAchieve(DanRank rank) {
    switch (rank) {
      case DanRank.firstDan:
        return 3; // Typically 3 years from white belt
      case DanRank.secondDan:
        return 2; // 2 years from 1st Dan
      case DanRank.thirdDan:
        return 3; // 3 years from 2nd Dan
      case DanRank.fourthDan:
        return 4; // 4 years from 3rd Dan
      case DanRank.fifthDan:
        return 5; // 5 years from 4th Dan
      case DanRank.sixthDan:
        return 6; // 6 years from 5th Dan
      case DanRank.seventhDan:
        return 7; // 7 years from 6th Dan
      case DanRank.eighthDan:
        return 8; // 8 years from 7th Dan
      case DanRank.ninthDan:
        return 9; // 9 years from 8th Dan
      case DanRank.tenthDan:
        return 10; // 10 years from 9th Dan
    }
  }

  /// Returns the cumulative years to achieve a rank from white belt
  static int getCumulativeYears(DanRank rank) {
    int totalYears = 0;
    for (int i = 0; i <= rank.index; i++) {
      totalYears += getTypicalYearsToAchieve(DanRank.values[i]);
    }
    return totalYears;
  }

  /// Returns a formatted string showing the rank progression
  static String getProgressionInfo(DanRank rank) {
    final years = getTypicalYearsToAchieve(rank);
    final cumulative = getCumulativeYears(rank);
    final category = getDanCategory(rank);

    return '${rank.displayName} (${rank.japaneseName})\n'
        'Category: $category\n'
        'Years from previous: $years\n'
        'Total years: $cumulative';
  }

  /// Returns true if the rank requires a master-level instructor
  static bool requiresMasterInstructor(DanRank rank) {
    return rank.isSeniorLevel || rank.isMasterLevel;
  }

  /// Returns the minimum age typically required for the rank
  static int getMinimumAge(DanRank rank) {
    switch (rank) {
      case DanRank.firstDan:
        return 16;
      case DanRank.secondDan:
        return 18;
      case DanRank.thirdDan:
        return 21;
      case DanRank.fourthDan:
        return 25;
      case DanRank.fifthDan:
        return 30;
      case DanRank.sixthDan:
        return 36;
      case DanRank.seventhDan:
        return 43;
      case DanRank.eighthDan:
        return 51;
      case DanRank.ninthDan:
        return 60;
      case DanRank.tenthDan:
        return 70;
    }
  }

  /// Creates a widget displaying Dan rank information
  static Widget createDanRankChip(DanRank rank) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: getDanColor(rank),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rank.displayName,
            style: const TextStyle(
              fontSize: AppConstants.smallFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(rank.japaneseName, style: const TextStyle(fontSize: 10, color: Colors.white70)),
        ],
      ),
    );
  }
}
