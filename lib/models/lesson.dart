import './content/content_item.dart';

class Lesson {
  final String id;
  final int readTimeInMinutes;
  String title;
  List<ContentItem> content = [];
  double progress;

  Lesson({
    required this.id,
    required this.readTimeInMinutes,
    this.title = "",
    this.progress = 0,
  });
}
