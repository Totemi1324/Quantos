import './content_item.dart';

class Equation extends ContentItem {
  static const contentType = ContentType.equation;

  final String tex;

  const Equation({
    required this.tex,
    required String altText,
  }) : super(type: contentType, altText: altText);
}
