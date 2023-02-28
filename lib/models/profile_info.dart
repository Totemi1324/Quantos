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
  final bool firstTimeCoding;

  const ProfileInfo({
    required this.age,
    required this.experience,
    this.name,
    this.team,
    this.firstTimeCoding = true,
  });

  factory ProfileInfo.empty() => const ProfileInfo(
        name: "Tamas",
        team: "Universität Regensburg",
        age: Age.student,
        experience: Experience.beginner,
      );
}
