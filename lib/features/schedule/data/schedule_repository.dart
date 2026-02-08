import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../model/schedule_model.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepository(ref.watch(databaseProvider));
});

class ScheduleRepository {
  final AppDatabase _db;

  ScheduleRepository(this._db);

  Stream<List<ScheduleModel>> watchSchedules() {
    return _db.select(_db.schedules).watch().map((rows) {
      return rows.map((row) => _toModel(row)).toList();
    });
  }

  Future<void> addSchedule(ScheduleModel schedule) async {
    await _db.into(_db.schedules).insert(
          SchedulesCompanion(
            id: Value(schedule.id),
            name: Value(schedule.name),
            startHour: Value(schedule.startTime.hour),
            startMinute: Value(schedule.startTime.minute),
            endHour: Value(schedule.endTime.hour),
            endMinute: Value(schedule.endTime.minute),
            weekdays: Value(schedule.weekdays.join(',')),
            isEnabled: Value(schedule.isEnabled),
          ),
        );
  }

  Future<void> updateSchedule(ScheduleModel schedule) async {
    await (_db.update(_db.schedules)..where((t) => t.id.equals(schedule.id)))
        .write(
      SchedulesCompanion(
        name: Value(schedule.name),
        startHour: Value(schedule.startTime.hour),
        startMinute: Value(schedule.startTime.minute),
        endHour: Value(schedule.endTime.hour),
        endMinute: Value(schedule.endTime.minute),
        weekdays: Value(schedule.weekdays.join(',')),
        isEnabled: Value(schedule.isEnabled),
      ),
    );
  }

  Future<void> deleteSchedule(String id) async {
    await (_db.delete(_db.schedules)..where((t) => t.id.equals(id))).go();
  }

  Future<void> toggleSchedule(String id, bool isEnabled) async {
    await (_db.update(_db.schedules)..where((t) => t.id.equals(id)))
        .write(SchedulesCompanion(isEnabled: Value(isEnabled)));
  }

  ScheduleModel _toModel(Schedule row) {
    return ScheduleModel(
      id: row.id,
      name: row.name,
      startTime: TimeOfDay(hour: row.startHour, minute: row.startMinute),
      endTime: TimeOfDay(hour: row.endHour, minute: row.endMinute),
      weekdays: row.weekdays
          .split(',')
          .where((e) => e.isNotEmpty)
          .map(int.parse)
          .toList(),
      isEnabled: row.isEnabled,
    );
  }
}
