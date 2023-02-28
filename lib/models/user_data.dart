import '../models/content/content_outline.dart';

enum Age {
  adolescent,
  student,
  adult,
  elder,
}

enum Experience {
  beginner,
  advanced,
  skilled,
}

class UserData {
  String? name;
  String? team;
  Age age;
  Experience experience;
  Map<String, bool> lectionUnlocked;
  Map<String, double> lessonProgress;
  Map<DateTime, int> activityLog;

  UserData({
    required this.age,
    required this.experience,
    required this.lectionUnlocked,
    required this.lessonProgress,
    required this.activityLog,
    this.name,
    this.team,
  });

  factory UserData.defaultUser(ContentOutline outline) => UserData(
        age: Age.student,
        experience: Experience.beginner,
        lectionUnlocked: Map.fromIterable(outline.lectionIds, value: (element) => element == "8hg",),
        lessonProgress: Map.fromIterable(outline.lessonIds, value: (_) => 0.0,),
        activityLog: {}
      );
}