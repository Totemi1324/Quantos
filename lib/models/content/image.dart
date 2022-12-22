import './content_item.dart';

class Image extends ContentItem {
  static const contentType = ContentType.image;

  final String asset;
  final String caption;

  Image({
    required this.asset,
    required this.caption,
    required String id,
    required String altText,
  }) : super(id: id, type: contentType, altText: altText);
}