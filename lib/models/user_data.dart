import '../models/content/content_outline.dart';

enum QuizAnswer {
  yes,
  no,
  unsure,
}

enum Experience {
  beginner,
  advanced,
  skilled,
}

class UserData {
  String? name;
  String? team;
  Map<int, QuizAnswer> quizAnswers;
  Experience experience;
  Map<String, bool> lectionUnlocked;
  Map<String, double> lessonProgress;
  Map<DateTime, int> activityLog;

  UserData({
    required this.quizAnswers,
    required this.experience,
    required this.lectionUnlocked,
    required this.lessonProgress,
    required this.activityLog,
    this.name,
    this.team,
  });

  factory UserData.defaultUser(ContentOutline outline) => UserData(
        quizAnswers: {},
        experience: Experience.beginner,
        lectionUnlocked: Map.fromIterable(
          outline.lectionIds,
          value: (element) => true,
        ),
        lessonProgress: Map.fromIterable(
          outline.lessonIds,
          value: (_) => 0.0,
        ),
        activityLog: {},
      );
}
