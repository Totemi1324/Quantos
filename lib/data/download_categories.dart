import '../models/download_category.dart';
import '../models/platform.dart';

List<DownloadCategory> downloadCategories = const [
  DownloadCategory(
    "2fT",
    title: "Programs",
    availableOn: {Platform.desktop}
  ),
  DownloadCategory(
    "VpJ",
    title: "Documents",
    availableOn: {Platform.mobile, Platform.desktop}
  ),
  DownloadCategory(
    "U7s",
    title: "Databases",
    availableOn: {Platform.mobile, Platform.desktop}
  ),
  DownloadCategory(
    "ft1",
    title: "Code",
    availableOn: {Platform.mobile, Platform.desktop}
  ),
];
