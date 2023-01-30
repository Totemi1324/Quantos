import './content_item.dart';

class Image extends ContentItem {
  static const contentType = ContentType.image;

  final String asset;
  final String caption;

  const Image({
    required this.asset,
    required this.caption,
    required String altText,
  }) : super(type: contentType, altText: altText);
}
