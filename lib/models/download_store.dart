import './download.dart';
import './download_category.dart';

class DownloadStore {
  final List<DownloadCategory> categories;
  final List<Download> items;

  const DownloadStore({required this.categories, required this.items});

  factory DownloadStore.empty() => DownloadStore(
      categories: List<DownloadCategory>.empty(growable: true),
      items: List<Download>.empty(growable: true));

  void clear() {
    categories.clear();
    items.clear();
  }

  void addCategory(DownloadCategory category) => categories.add(category);
  void removeCategory(String id) =>
      categories.removeWhere((category) => category.id == id);
  void updateCategory(String id, DownloadCategory category) {
    final index = categories.indexWhere((category) => category.id == id);
    if (index != -1) {
      categories[index] = category;
    }
  }

  void addItem(Download item) => items.add(item);
  void removeItem(String id) => items.removeWhere((item) => item.id == id);
  void updateItem(String id, Download item) {
    final index = items.indexWhere((item) => item.id == id);
    if (index != -1) {
      items[index] = item;
    }
  }

  List<Download> getDownloadsForCategory(String categoryId) =>
      items.where((item) => item.categoryId == categoryId).toList();

  DownloadCategory? getCategoryById(String id) {
    try {
      return categories.firstWhere((category) => category.id == id);
    } on StateError {
      return null;
    }
  }

  Download? getDownloadById(String id) {
    try {
      return items.firstWhere((item) => item.id == id);
    } on StateError {
      return null;
    }
  }
}
