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
  News(
    senderIconNetworkAddress:
        "https://raw.githubusercontent.com/Totemi1324/Quantos/main/assets/images/logo.png",
    message: '''Version 1.0.0 is out! ^_^
        
        The full version contains various bug fixes and improvenets. Additionally, there are new, amazing features that everyone has to try.

        For example, you can now navigate using the navigation bar at the bottom. This way, you are able to reach other parts of the app apart from the home screen. Pretty neat, huh?
        
        But that's not all: The DWave compiler is finally working! If you visit the 'Coding' tab of the app, you can be among the first to interact with and solve problems on a quantum computer from your mobile. Actually, from anywhere, since Quantos is cross-platform. Go get it now on every OS imaginable!''',
    date: DateTime.now(),
  ),
];
