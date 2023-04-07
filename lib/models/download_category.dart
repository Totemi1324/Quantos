import './platform.dart';

class DownloadCategory {
  final String id;
  final String title;
  final Set<Platform> availableOn;

  const DownloadCategory(this.id, {required this.title, required this.availableOn});
}
