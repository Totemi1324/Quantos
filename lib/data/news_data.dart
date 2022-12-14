import '../models/news.dart';

List<News> news = [
  News(
    senderIconNetworkAddress: "https://pbs.twimg.com/media/FJ96vOQWUAwbIah.jpg",
    message:
        "Version 1.0.0 is out! ^_^\nThe full version contains various bug fixes and improvenets.",
    date: DateTime.now(),
  ),
  News(
    senderIconNetworkAddress:
        "https://cdn.dribbble.com/users/528264/screenshots/3140440/firebase_logo.png",
    message:
        "Now using Firebase as our new backend. The user experience didn't recieve any impact.",
    date: DateTime.now(),
  ),
];
