class Levels {
  final String title;

  final int tier;
  final int target;
  final int reward;

  Levels(
    this.title,
    this.tier,
    this.target,
    this.reward,
  );
  static int? getCommission(int sales) {
    if (sales < 1000000) {
      return (sales / 100 * 5).toInt();
    } else if (sales >= 1000000 && sales <= 1999999) {
      return (sales / 100 * 10).toInt();
    } else if (sales >= 2000000 && sales <= 2999999) {
      return (sales / 100 * 15).toInt();
    } else if (sales >= 3000000 && sales <= 3999999) {
      return (sales / 100 * 20).toInt();
    } else if (sales >= 4000000 && sales <= 4999999) {
      return (sales / 100 * 25).toInt();
    } else if (sales >= 5000000) {
      return (sales / 100 * 30).toInt();
    }
  }

  static int? getTier(int sales) {
    if (sales < 1000000) {
      return 0;
    } else if (sales >= 1000000 && sales <= 1999999) {
      return 1;
    } else if (sales >= 2000000 && sales <= 2999999) {
      return 2;
    } else if (sales >= 3000000 && sales <= 3999999) {
      return 3;
    } else if (sales >= 4000000 && sales <= 4999999) {
      return 4;
    } else if (sales >= 5000000) {
      return 5;
    }
  }

  static List<Levels> generateLevels() {
    return [
      Levels("M5", 5, 5000000, 30),
      Levels("M4", 4, 4000000, 25),
      Levels("M3", 3, 3000000, 20),
      Levels("M2", 2, 2000000, 15),
      Levels("M1", 1, 1000000, 10),
      Levels("Below M1", 0, 0, 5),
    ];
  }
}
