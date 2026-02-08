import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:screen_time_blocker/screen_time_blocker.dart';

import '../../schedule/model/schedule_model.dart';
import '../../usage/data/usage_repository.dart';

final screenBlockerServiceProvider = Provider<ScreenBlockerService>((ref) {
  return ScreenBlockerService(ref);
});

class ScreenBlockerService {
  final Ref _ref;
  final ScreenTimeBlocker _blocker = const ScreenTimeBlocker();

  ScreenBlockerService(this._ref);

  Future<bool> isSupported() async {
    return _blocker.isSupported;
  }

  Future<bool> requestAuthorization() async {
    try {
      return await _blocker.requestAuthorization();
    } catch (e) {
      debugPrint('Error requesting authorization: $e');
      return false;
    }
  }

  Future<AuthorizationStatus> getAuthorizationStatus() async {
    return await _blocker.getAuthorizationStatus();
  }

  Future<void> selectAppsForSchedule(String scheduleId) async {
    try {
      // Authorization Check
      final status = await _blocker.getAuthorizationStatus();
      if (status != AuthorizationStatus.approved) {
        final authorized = await _blocker.requestAuthorization();
        if (!authorized) {
          // throw Exception("Authorization required");
          return;
        }
      }

      await _blocker.selectAppsToBlock(scheduleId: scheduleId);
    } catch (e) {
      debugPrint('Error selecting apps: $e');
    }
  }

  Future<SelectionSummary> selectAppsToBlock() async {
    try {
      return await _blocker.selectAppsToBlock();
    } catch (e) {
      debugPrint('Error selecting apps: $e');
      rethrow;
    }
  }

  Future<SelectionSummary> getSelectionSummary() async {
    return await _blocker.getSelectionSummary();
  }

  // Track current session ID
  int? _currentSessionId;

  Future<bool> scheduleBlocking(ScheduleModel schedule) async {
    bool success = true;
    for (final weekday in schedule.weekdays) {
      // Create a unique ID for each day of the schedule
      // Format: scheduleId_weekday
      final uniqueId = '${schedule.id}_$weekday';
      final result = await _blocker.startSchedule(
        scheduleId: uniqueId,
        hour: schedule.startTime.hour,
        minute: schedule.startTime.minute,
        endHour: schedule.endTime.hour,
        endMinute: schedule.endTime.minute,
        weekday: weekday,
      );
      if (!result) success = false;
    }
    return success;
  }

  Future<void> cancelSchedule(ScheduleModel schedule) async {
    for (final weekday in schedule.weekdays) {
      final uniqueId = '${schedule.id}_$weekday';
      await _blocker.stopSchedule(uniqueId);
    }
  }

  Future<bool> startSchedule({
    required int hour,
    required int minute,
    String? scheduleId,
  }) async {
    // Deprecated: keeping for compatibility but should use scheduleBlocking
    try {
      return await _blocker.startSchedule(
        scheduleId: scheduleId ?? 'default_schedule',
        hour: hour,
        minute: minute,
        endHour: 23, // Default to end of day
        endMinute: 59,
      );
    } catch (e) {
      debugPrint('Error starting schedule: $e');
      return false;
    }
  }

  Future<bool> stopSchedule(String scheduleId) async {
    return await _blocker.stopSchedule(scheduleId);
  }

  Future<bool> stopAllSchedules() async {
    // End current session if active
    if (_currentSessionId != null) {
      final usageRepo = _ref.read(usageRepositoryProvider);
      await usageRepo.endSession(_currentSessionId!);
      _currentSessionId = null;
    }
    return await _blocker.stopAllSchedules();
  }

  Future<bool> blockNow() async {
    try {
      final result = await _blocker.blockNow();
      if (result) {
        // Start usage session
        final usageRepo = _ref.read(usageRepositoryProvider);
        _currentSessionId = await usageRepo.startSession();
      }
      return result;
    } catch (e) {
      debugPrint('Error blocking now: $e');
      return false;
    }
  }

  Future<bool> unblockUntilNextSchedule() async {
    // End current session if active
    if (_currentSessionId != null) {
      final usageRepo = _ref.read(usageRepositoryProvider);
      await usageRepo.endSession(_currentSessionId!);
      _currentSessionId = null;
    }
    return await _blocker.unblockUntilNextSchedule();
  }
}
