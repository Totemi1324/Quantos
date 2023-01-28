import './content/content_item.dart';

class Lesson {
  final String id;
  final String title;
  final int readTimeInMinutes;
  final List<ContentItem> content;
  double progress;

  Lesson({
    required this.id,
    required this.title,
    required this.readTimeInMinutes,
    required this.content,
    this.progress = 0,
  });
}
