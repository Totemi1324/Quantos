import '../bloc/storage_service.dart';

import './lesson.dart';

enum Difficulty {
  easy,
  advanced,
  challenging,
}

class Lection {
  final String id;
  late String _iconAnimation;
  late String _headerAnimation;
  final Difficulty difficultyLevel;
  late List<Lesson> _lessons;

  Lection({
    required this.id,
    required String iconAnimation,
    required String headerAnimation,
    required this.difficultyLevel,
    required List<Lesson> lessons,
  }) {
    _iconAnimation = iconAnimation;
    _headerAnimation = headerAnimation;
    _lessons = lessons;
  }

  String get iconAnimation => _iconAnimation;
  String get headerAnimation => _headerAnimation;
  List<Lesson> get lessons => _lessons;
}

extension AssetTransformator on Lection {
  Future getDownloadLinks(StorageService service) async {
    await service.getDownloadLinkForLectionAnimation(_iconAnimation);
    _iconAnimation = service.state.content;
    await service.getDownloadLinkForLectionAnimation(_headerAnimation);
    _headerAnimation = service.state.content;
  }

  void getAssetLocations(String assetPath) {
    if (assetPath.isEmpty) {
      return;
    }
    _iconAnimation = "$assetPath/$_iconAnimation";
    _headerAnimation = "$assetPath/$_headerAnimation";
  }
}
