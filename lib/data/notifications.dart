import '../models/notification.dart';
import '../models/news.dart';

List<Notification> news = [
  News(
    senderIconNetworkAddress: "https://pbs.twimg.com/media/FJ96vOQWUAwbIah.jpg",
    message: '''Version 1.0.0 is out! ^_^
        
        The full version contains various bug fixes and improvenets. Additionally, there are new, amazing features that everyone has to try.

        For example, you can now navigate using the navigation bar at the bottom. This way, you are able to reach other parts of the app apart from the home screen. Pretty neat, huh?
        
        But that's not all: The DWave compiler is finally working! If you visit the 'Coding' tab of the app, you can be among the first to interact with and solve problems on a quantum computer from your mobile. Actually, from anywhere, since Quantos is cross-platform. Go get it now on every OS imaginable!''',
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
    senderIconNetworkAddress:
        "https://seeklogo.com/images/S/supabase-logo-DCC676FFE2-seeklogo.com.png",
    message:
        "Actually, switching to Supabase. Apperently it's better because it's open source ¯\\_(ツ)_/¯",
    date: DateTime.now(),
  ),
];
