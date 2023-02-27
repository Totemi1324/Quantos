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
  final Age age;
  final Experience experience;

  const ProfileInfo({required this.age, required this.experience, this.name});

  factory ProfileInfo.empty() => const ProfileInfo(
        name: "Tamas",
        age: Age.student,
        experience: Experience.beginner,
      );
}
