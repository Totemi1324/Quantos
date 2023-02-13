import './content/content_item.dart';

class Lesson {
  final String id;
  final int readTimeInMinutes;
  List<ContentItem> content = [];
  double progress;

  Lesson({
    required this.id,
    required this.readTimeInMinutes,
    this.progress = 0,
  });
}
