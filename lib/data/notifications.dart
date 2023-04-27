import '../models/notification.dart';
import '../models/news.dart';
import '../models/statistic.dart';

import '../widgets/canvas/heatmap_chart.dart';

List<Notification> notifications = [
  Statistic(
    statistics: const HeatmapChart(
      height: 150,
    ),
    date: DateTime.now(),
  ),
];
