enum NotificationType {
  news,
  statistic,
}

abstract class Notification {
  final NotificationType type;
  final DateTime date;

  const Notification({
    required this.type,
    required this.date,
  });
}
