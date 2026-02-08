import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Schedules extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get startHour => integer()();
  IntColumn get startMinute => integer()();
  IntColumn get endHour => integer()();
  IntColumn get endMinute => integer()();
  // Store weekdays as comma-separated integers (e.g., "1,2,3")
  TextColumn get weekdays => text()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class UsageSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  IntColumn get durationSeconds =>
      integer().nullable()(); // Calculated on completion
  TextColumn get scheduleId => text().nullable()(); // Linked schedule if any
}

@DriftDatabase(tables: [Schedules, UsageSessions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
