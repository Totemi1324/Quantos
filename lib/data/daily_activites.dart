import '../models/daily_activity_record.dart';

List<DailyActivityRecord> dailyActivities = [
  DailyActivityRecord(
    lastOnline: DateTime.now().subtract(const Duration(days: 0)),
    completedLessons: 2,
  ),
  DailyActivityRecord(
    lastOnline: DateTime.now().subtract(const Duration(days: 1)),
    completedLessons: 1,
  ),
  DailyActivityRecord(
    lastOnline: DateTime.now().subtract(const Duration(days: 2)),
    completedLessons: 5,
  ),
  DailyActivityRecord(
    lastOnline: DateTime.now().subtract(const Duration(days: 3)),
    completedLessons: 1,
  ),
  DailyActivityRecord(
    lastOnline: DateTime.now().subtract(const Duration(days: 5)),
    completedLessons: 3,
  ),
  DailyActivityRecord(
    lastOnline: DateTime.now().subtract(const Duration(days: 6)),
    completedLessons: 2,
  ),
];
