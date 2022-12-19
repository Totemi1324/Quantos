enum DownloadSizeUnit {
  kilobyte,
  megabyte,
  gigabyte,
}

enum FileType {
  pdf,
  exe,
  json,
  ipynb,
}

class Download {
  final String categoryId;
  final String title;
  final DownloadSize size;
  final String description;
  final FileType type;
  final String link;

  const Download(
    this.title, {
    required this.categoryId,
    required this.description,
    required this.size,
    required this.type,
    required this.link,
  });
}

class DownloadSize {
  final double size;
  final DownloadSizeUnit unit;

  static const Map<DownloadSizeUnit, String> sizeUnitToString = {
    DownloadSizeUnit.kilobyte: "KB",
    DownloadSizeUnit.megabyte: "MB",
    DownloadSizeUnit.gigabyte: "GB"
  };

  const DownloadSize({required this.size, required this.unit});

  @override
  String toString() {
    return "${size.toStringAsFixed(1)} ${sizeUnitToString[unit]}";
  }
}
