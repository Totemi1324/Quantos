import './content_item.dart';
import './section_title.dart';

class LessonContent {
  String lessonId;
  final List<ContentItem> content;

  LessonContent({required this.lessonId, required this.content});

  factory LessonContent.empty() => LessonContent(lessonId: "", content: []);

  List<String> get sectionTitles => content
      .where((item) => item.type == ContentType.sectionTitle)
      .map((item) => item as SectionTitle)
      .map((sectionTitle) => sectionTitle.title)
      .toList();

  void addContentItem(ContentItem item) => content.add(item);

  void clearContentData() => content.clear();
}
