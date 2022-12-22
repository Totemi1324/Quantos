import './content_item.dart';

class SectionTitle extends ContentItem {
  static const contentType = ContentType.sectionTitle;

  final String title;

  SectionTitle({
    required this.title,
    required String id,
  }) : super(id: id, type: contentType);
}