import '../models/notification.dart';
import '../models/news.dart';

List<Notification> news = [
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
  News(
    senderIconNetworkAddress: "https://seeklogo.com/images/S/supabase-logo-DCC676FFE2-seeklogo.com.png",
    message:
        "Actually, switching to Supabase. Apperently it's better because it's open source ¯\\_(ツ)_/¯",
    date: DateTime.now(),
  ),
];
