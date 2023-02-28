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

class ProfileInfo {
  final String? name;
  final String? team;
  final Age age;
  final Experience experience;

  const ProfileInfo({
    required this.age,
    required this.experience,
    this.name,
    this.team,
  });

  factory ProfileInfo.empty() => const ProfileInfo(
        name: "Tamas",
        team: "Universität Regensburg",
        age: Age.student,
        experience: Experience.advanced,
      );
}
