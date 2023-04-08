import './download.dart';
import './download_category.dart';

class DownloadStore {
  final List<DownloadCategory> categories;
  final List<Download> items;

  const DownloadStore({required this.categories, required this.items});

  factory DownloadStore.empty() =>
      const DownloadStore(categories: [], items: []);

  void addCategory(DownloadCategory category) => categories.add(category);
  void removeCategory(String id) =>
      categories.removeWhere((category) => category.id == id);

  void addItem(Download item) => items.add(item);
  void removeItem(String id) => items.removeWhere((item) => item.id == id);
  Download? getItemById(String id) {
    try {
      return items.firstWhere((item) => item.id == id);
    } on StateError {
      return null;
    }
  }

  List<Download> getDownloadsForCategory(String categoryId) =>
      items.where((item) => item.categoryId == categoryId).toList();
}
