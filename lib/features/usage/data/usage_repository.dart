import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../schedule/data/schedule_repository.dart'; // Import for databaseProvider

final usageRepositoryProvider = Provider<UsageRepository>((ref) {
  return UsageRepository(ref.watch(databaseProvider));
});

class UsageRepository {
  final AppDatabase _db;

  UsageRepository(this._db);

  /// Starts a new session and returns its ID
  Future<int> startSession({String? scheduleId}) async {
    final id = await _db.into(_db.usageSessions).insert(
          UsageSessionsCompanion(
            startTime: Value(DateTime.now()),
            scheduleId: Value(scheduleId),
          ),
        );
    return id;
  }

  /// Ends a session by ID and calculates duration
  Future<void> endSession(int sessionId) async {
    final endTime = DateTime.now();
    final session = await (_db.select(_db.usageSessions)
          ..where((t) => t.id.equals(sessionId)))
        .getSingleOrNull();

    if (session != null) {
      final startTime = session.startTime;
      final duration = endTime.difference(startTime).inSeconds;

      await (_db.update(_db.usageSessions)
            ..where((t) => t.id.equals(sessionId)))
          .write(
        UsageSessionsCompanion(
          endTime: Value(endTime),
          durationSeconds: Value(duration),
        ),
      );
    }
  }

  /// Get total duration in seconds for today
  Future<int> getTodayUsageSeconds() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final query = _db.select(_db.usageSessions)
      ..where((t) => t.startTime.isBetween(
            Variable(startOfDay),
            Variable(endOfDay),
          ))
      ..where((t) => t.durationSeconds.isNotNull());

    final sessions = await query.get();
    return sessions.fold<int>(
        0, (sum, session) => sum + (session.durationSeconds ?? 0));
  }

  /// Get usage duration for yesterday (for comparison)
  Future<int> getYesterdayUsageSeconds() async {
    final now = DateTime.now();
    final startOfYesterday = DateTime(now.year, now.month, now.day - 1);
    final endOfYesterday = DateTime(now.year, now.month, now.day);

    final query = _db.select(_db.usageSessions)
      ..where((t) => t.startTime.isBetween(
            Variable(startOfYesterday),
            Variable(endOfYesterday),
          ))
      ..where((t) => t.durationSeconds.isNotNull());

    final sessions = await query.get();
    return sessions.fold<int>(
        0, (sum, session) => sum + (session.durationSeconds ?? 0));
  }

  /// Get total duration all time
  Future<int> getTotalUsageSeconds() async {
    final sessions = await (_db.select(_db.usageSessions)
          ..where((t) => t.durationSeconds.isNotNull()))
        .get();
    return sessions.fold<int>(
        0, (sum, session) => sum + (session.durationSeconds ?? 0));
  }

  /// Get count of deep work sessions (completed sessions > 25 mins) today
  Future<int> getDeepWorkSlotsToday() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final sessions = await (_db.select(_db.usageSessions)
          ..where((t) => t.startTime.isBetween(
                Variable(startOfDay),
                Variable(endOfDay),
              ))
          ..where(
              (t) => t.durationSeconds.isBiggerThan(const Constant(25 * 60))))
        .get();

    return sessions.length;
  }

  /// Get usage duration for the last 7 days (inclusive of today)
  /// Returns a map of DateTime (start of day) -> duration in seconds
  Future<Map<DateTime, int>> getWeeklyUsage() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startOfPeriod = today.subtract(const Duration(days: 6));
    final endOfPeriod = today.add(const Duration(days: 1)); // End of today

    final sessions = await (_db.select(_db.usageSessions)
          ..where((t) => t.startTime.isBetween(
                Variable(startOfPeriod),
                Variable(endOfPeriod),
              ))
          ..where((t) => t.durationSeconds.isNotNull()))
        .get();

    final Map<DateTime, int> dailyUsage = {};

    // Initialize map with 0 for all 7 days
    for (int i = 0; i < 7; i++) {
      final day = startOfPeriod.add(Duration(days: i));
      dailyUsage[day] = 0;
    }

    for (var session in sessions) {
      final date = session.startTime;
      final dayKey = DateTime(date.year, date.month, date.day);
      if (dailyUsage.containsKey(dayKey)) {
        dailyUsage[dayKey] =
            (dailyUsage[dayKey] ?? 0) + (session.durationSeconds ?? 0);
      }
    }

    return dailyUsage;
  }
}
