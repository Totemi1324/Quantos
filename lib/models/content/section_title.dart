import './content_item.dart';

class SectionTitle extends ContentItem {
  static const contentType = ContentType.sectionTitle;

  final String title;

  const SectionTitle({
    required this.title,
  }) : super(type: contentType);
}
