import './content_item.dart';

enum ParagraphSpanType {
  normal,
  bold,
  equation,
}

class Paragraph extends ContentItem {
  static const contentType = ContentType.paragraph;

  final List<ParagraphSpan> texts;

  const Paragraph({
    required this.texts,
  }) : super(type: contentType);
}

class ParagraphSpan {
  final ParagraphSpanType type;
  final String text;

  const ParagraphSpan({required this.type, required this.text});
}
