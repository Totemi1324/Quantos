class Lesson {
  final String id;
  final int readTimeInMinutes;
  double progress;

  Lesson({
    required this.id,
    required this.readTimeInMinutes,
    this.progress = 0,
  });
}
