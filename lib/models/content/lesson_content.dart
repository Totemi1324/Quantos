import './content_item.dart';
import './section_title.dart';

class LessonContent {
  String lessonId;
  final List<List<ContentItem>> content;
  final List<ContentItem> contentCache = [];

  LessonContent({required this.lessonId, required this.content});

  factory LessonContent.empty() => LessonContent(lessonId: "", content: []);

  List<String> get sectionTitles => content
      .expand((element) => element)
      .where((item) => item.type == ContentType.sectionTitle)
      .map((item) => item as SectionTitle)
      .map((sectionTitle) => sectionTitle.title)
      .toList();

  void addContentItem(ContentItem item) => contentCache.add(item);

  void breakPage() {
    content.add(contentCache.toList());
    contentCache.clear();
  }

  void clearContentData() {
    content.clear();
    contentCache.clear();
  }

  bool moveNextIsSafe(int currentIndex) => currentIndex + 1 < content.length;

  bool movePreviousIsSafe(int currentIndex) => currentIndex - 1 >= 0;

  int indexOfPageWithSectionTitle(String sectionTitle) => content.indexWhere(
        (page) => page
            .where((item) => item.type == ContentType.sectionTitle)
            .map((item) => item as SectionTitle)
            .any((title) => title.title == sectionTitle),
      );
}
