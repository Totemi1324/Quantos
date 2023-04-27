import '../../bloc/storage_service.dart';

import './content_item.dart';

class Image extends ContentItem {
  static const contentType = ContentType.image;

  late String _asset;
  final String caption;

  Image({
    required String asset,
    required this.caption,
    required String altText,
  }) : super(type: contentType, altText: altText) {
    _asset = asset;
  }

  String get asset => _asset;
}

extension AssetTransformator on Image {
  Future getDownloadLinks(StorageService service) async {
    await service.getDownloadLinkForLessonImage(_asset);
    _asset = service.state.content;
  }
}
