import '../models/daily_activity_record.dart';

List<DailyActivityRecord> dailyActivities = [
  DailyActivityRecord(
    lastOnline: DateTime.now().subtract(const Duration(days: 0)),
    completedLessons: 2,
  ),
];
