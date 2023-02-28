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
  final String? name;
  final String? team;
  final Age age;
  final Experience experience;
  final bool firstTimeCoding;

  const UserData({
    required this.age,
    required this.experience,
    this.name,
    this.team,
    this.firstTimeCoding = true,
  });

  factory UserData.empty() => const UserData(
        name: "Tamas",
        team: "Universität Regensburg",
        age: Age.student,
        experience: Experience.beginner,
      );
}
