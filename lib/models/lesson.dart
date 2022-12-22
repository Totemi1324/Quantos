class Lesson {
  final String id;
  final String lectionId;
  final String title;
  final String content;
  final int readTimeInMinutes;
  final double progress;

  const Lesson({
    required this.id,
    required this.lectionId,
    required this.title,
    required this.content,
    required this.readTimeInMinutes,
    this.progress = 0,
  });
}
