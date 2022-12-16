import './notification.dart';

class News extends Notification {
  static const notificationType = NotificationType.news;

  final String senderIconNetworkAddress;
  final String message;

  News({
    required this.senderIconNetworkAddress,
    required this.message,
    required DateTime date
  }) : super(type: notificationType, date: date);
}
