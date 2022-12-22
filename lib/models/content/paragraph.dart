import './content_item.dart';

class Paragraph extends ContentItem {
  static const contentType = ContentType.paragraph;

  final String text;

  Paragraph({
    required this.text,
    required String id,
  }) : super(id: id, type: contentType);
}