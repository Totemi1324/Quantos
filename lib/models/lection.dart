enum Difficulty {
  easy,
  advanced,
  challenging,
}

class Lection {
  final String id;
  final String iconAnimationAsset;
  final String headerAnimationAsset;
  final String title;
  final String description;
  final Difficulty difficultyLevel;
  double progressPercent;
  bool unlocked;

  Lection({
    required this.id,
    required this.iconAnimationAsset,
    required this.headerAnimationAsset,
    required this.title,
    required this.description,
    required this.difficultyLevel,
    this.progressPercent = 0.0,
    this.unlocked = false,
  });
}
