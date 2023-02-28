import './lesson.dart';

enum Difficulty {
  easy,
  advanced,
  challenging,
}

class Lection {
  final String id;
  final String iconAnimationAsset;
  final String headerAnimationAsset;
  final Difficulty difficultyLevel;
  final List<Lesson> lessons;

  Lection({
    required this.id,
    required this.iconAnimationAsset,
    required this.headerAnimationAsset,
    required this.difficultyLevel,
    required this.lessons,
  });
}
