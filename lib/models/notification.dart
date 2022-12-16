enum NotificationType {
  news,
}

abstract class Notification {
  final NotificationType type;
  final DateTime date;

  const Notification({
    required this.type,
    required this.date,
  });
}
