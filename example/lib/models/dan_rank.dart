/// Enum representing martial arts Dan (black belt) ranking system
///
/// The Dan ranking system is used in various martial arts to indicate
/// the level of expertise beyond the basic kyu (colored belt) ranks.
enum DanRank {
  firstDan, // 1st Dan (Shodan) - First level black belt
  secondDan, // 2nd Dan (Nidan) - Second level black belt
  thirdDan, // 3rd Dan (Sandan) - Third level black belt
  fourthDan, // 4th Dan (Yondan) - Fourth level black belt
  fifthDan, // 5th Dan (Godan) - Fifth level black belt
  sixthDan, // 6th Dan (Rokudan) - Sixth level black belt
  seventhDan, // 7th Dan (Shichidan/Nanadan) - Seventh level black belt
  eighthDan, // 8th Dan (Hachidan) - Eighth level black belt
  ninthDan, // 9th Dan (Kudan) - Ninth level black belt
  tenthDan, // 10th Dan (Judan) - Tenth level black belt (highest)
}

/// Extension providing display and utility methods for DanRank enum
extension DanRankExtension on DanRank {
  /// Returns the English display name for the Dan rank
  String get displayName {
    switch (this) {
      case DanRank.firstDan:
        return '1st Dan';
      case DanRank.secondDan:
        return '2nd Dan';
      case DanRank.thirdDan:
        return '3rd Dan';
      case DanRank.fourthDan:
        return '4th Dan';
      case DanRank.fifthDan:
        return '5th Dan';
      case DanRank.sixthDan:
        return '6th Dan';
      case DanRank.seventhDan:
        return '7th Dan';
      case DanRank.eighthDan:
        return '8th Dan';
      case DanRank.ninthDan:
        return '9th Dan';
      case DanRank.tenthDan:
        return '10th Dan';
    }
  }

  /// Returns the traditional Japanese name for the Dan rank
  String get japaneseName {
    switch (this) {
      case DanRank.firstDan:
        return 'Shodan';
      case DanRank.secondDan:
        return 'Nidan';
      case DanRank.thirdDan:
        return 'Sandan';
      case DanRank.fourthDan:
        return 'Yondan';
      case DanRank.fifthDan:
        return 'Godan';
      case DanRank.sixthDan:
        return 'Rokudan';
      case DanRank.seventhDan:
        return 'Nanadan';
      case DanRank.eighthDan:
        return 'Hachidan';
      case DanRank.ninthDan:
        return 'Kudan';
      case DanRank.tenthDan:
        return 'Judan';
    }
  }

  /// Returns the rank level as a number (1-10)
  int get level => index + 1;

  /// Returns true if this is a master-level Dan rank (8th Dan and above)
  bool get isMasterLevel => this == DanRank.eighthDan || this == DanRank.ninthDan || this == DanRank.tenthDan;

  /// Returns true if this is a senior-level Dan rank (6th-7th Dan)
  bool get isSeniorLevel => this == DanRank.sixthDan || this == DanRank.seventhDan;

  /// Returns true if this is an intermediate-level Dan rank (3rd-5th Dan)
  bool get isIntermediateLevel => this == DanRank.thirdDan || this == DanRank.fourthDan || this == DanRank.fifthDan;

  /// Returns true if this is a junior-level Dan rank (1st-2nd Dan)
  bool get isJuniorLevel => this == DanRank.firstDan || this == DanRank.secondDan;
}
