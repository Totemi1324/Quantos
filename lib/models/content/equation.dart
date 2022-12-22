import './content_item.dart';

class Equation extends ContentItem {
  static const contentType = ContentType.equation;

  final String tex;

  Equation({
    required this.tex,
    required String id,
    required String altText,
  }) : super(id: id, type: contentType, altText: altText);
}