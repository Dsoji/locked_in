// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SchedulesTable extends Schedules
    with TableInfo<$SchedulesTable, Schedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startHourMeta =
      const VerificationMeta('startHour');
  @override
  late final GeneratedColumn<int> startHour = GeneratedColumn<int>(
      'start_hour', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startMinuteMeta =
      const VerificationMeta('startMinute');
  @override
  late final GeneratedColumn<int> startMinute = GeneratedColumn<int>(
      'start_minute', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endHourMeta =
      const VerificationMeta('endHour');
  @override
  late final GeneratedColumn<int> endHour = GeneratedColumn<int>(
      'end_hour', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endMinuteMeta =
      const VerificationMeta('endMinute');
  @override
  late final GeneratedColumn<int> endMinute = GeneratedColumn<int>(
      'end_minute', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weekdaysMeta =
      const VerificationMeta('weekdays');
  @override
  late final GeneratedColumn<String> weekdays = GeneratedColumn<String>(
      'weekdays', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        startHour,
        startMinute,
        endHour,
        endMinute,
        weekdays,
        isEnabled
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedules';
  @override
  VerificationContext validateIntegrity(Insertable<Schedule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_hour')) {
      context.handle(_startHourMeta,
          startHour.isAcceptableOrUnknown(data['start_hour']!, _startHourMeta));
    } else if (isInserting) {
      context.missing(_startHourMeta);
    }
    if (data.containsKey('start_minute')) {
      context.handle(
          _startMinuteMeta,
          startMinute.isAcceptableOrUnknown(
              data['start_minute']!, _startMinuteMeta));
    } else if (isInserting) {
      context.missing(_startMinuteMeta);
    }
    if (data.containsKey('end_hour')) {
      context.handle(_endHourMeta,
          endHour.isAcceptableOrUnknown(data['end_hour']!, _endHourMeta));
    } else if (isInserting) {
      context.missing(_endHourMeta);
    }
    if (data.containsKey('end_minute')) {
      context.handle(_endMinuteMeta,
          endMinute.isAcceptableOrUnknown(data['end_minute']!, _endMinuteMeta));
    } else if (isInserting) {
      context.missing(_endMinuteMeta);
    }
    if (data.containsKey('weekdays')) {
      context.handle(_weekdaysMeta,
          weekdays.isAcceptableOrUnknown(data['weekdays']!, _weekdaysMeta));
    } else if (isInserting) {
      context.missing(_weekdaysMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Schedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Schedule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      startHour: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_hour'])!,
      startMinute: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_minute'])!,
      endHour: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_hour'])!,
      endMinute: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_minute'])!,
      weekdays: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}weekdays'])!,
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
    );
  }

  @override
  $SchedulesTable createAlias(String alias) {
    return $SchedulesTable(attachedDatabase, alias);
  }
}

class Schedule extends DataClass implements Insertable<Schedule> {
  final String id;
  final String name;
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  final String weekdays;
  final bool isEnabled;
  const Schedule(
      {required this.id,
      required this.name,
      required this.startHour,
      required this.startMinute,
      required this.endHour,
      required this.endMinute,
      required this.weekdays,
      required this.isEnabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['start_hour'] = Variable<int>(startHour);
    map['start_minute'] = Variable<int>(startMinute);
    map['end_hour'] = Variable<int>(endHour);
    map['end_minute'] = Variable<int>(endMinute);
    map['weekdays'] = Variable<String>(weekdays);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  SchedulesCompanion toCompanion(bool nullToAbsent) {
    return SchedulesCompanion(
      id: Value(id),
      name: Value(name),
      startHour: Value(startHour),
      startMinute: Value(startMinute),
      endHour: Value(endHour),
      endMinute: Value(endMinute),
      weekdays: Value(weekdays),
      isEnabled: Value(isEnabled),
    );
  }

  factory Schedule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Schedule(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      startHour: serializer.fromJson<int>(json['startHour']),
      startMinute: serializer.fromJson<int>(json['startMinute']),
      endHour: serializer.fromJson<int>(json['endHour']),
      endMinute: serializer.fromJson<int>(json['endMinute']),
      weekdays: serializer.fromJson<String>(json['weekdays']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'startHour': serializer.toJson<int>(startHour),
      'startMinute': serializer.toJson<int>(startMinute),
      'endHour': serializer.toJson<int>(endHour),
      'endMinute': serializer.toJson<int>(endMinute),
      'weekdays': serializer.toJson<String>(weekdays),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  Schedule copyWith(
          {String? id,
          String? name,
          int? startHour,
          int? startMinute,
          int? endHour,
          int? endMinute,
          String? weekdays,
          bool? isEnabled}) =>
      Schedule(
        id: id ?? this.id,
        name: name ?? this.name,
        startHour: startHour ?? this.startHour,
        startMinute: startMinute ?? this.startMinute,
        endHour: endHour ?? this.endHour,
        endMinute: endMinute ?? this.endMinute,
        weekdays: weekdays ?? this.weekdays,
        isEnabled: isEnabled ?? this.isEnabled,
      );
  Schedule copyWithCompanion(SchedulesCompanion data) {
    return Schedule(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      startHour: data.startHour.present ? data.startHour.value : this.startHour,
      startMinute:
          data.startMinute.present ? data.startMinute.value : this.startMinute,
      endHour: data.endHour.present ? data.endHour.value : this.endHour,
      endMinute: data.endMinute.present ? data.endMinute.value : this.endMinute,
      weekdays: data.weekdays.present ? data.weekdays.value : this.weekdays,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Schedule(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startHour: $startHour, ')
          ..write('startMinute: $startMinute, ')
          ..write('endHour: $endHour, ')
          ..write('endMinute: $endMinute, ')
          ..write('weekdays: $weekdays, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, startHour, startMinute, endHour,
      endMinute, weekdays, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Schedule &&
          other.id == this.id &&
          other.name == this.name &&
          other.startHour == this.startHour &&
          other.startMinute == this.startMinute &&
          other.endHour == this.endHour &&
          other.endMinute == this.endMinute &&
          other.weekdays == this.weekdays &&
          other.isEnabled == this.isEnabled);
}

class SchedulesCompanion extends UpdateCompanion<Schedule> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> startHour;
  final Value<int> startMinute;
  final Value<int> endHour;
  final Value<int> endMinute;
  final Value<String> weekdays;
  final Value<bool> isEnabled;
  final Value<int> rowid;
  const SchedulesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startHour = const Value.absent(),
    this.startMinute = const Value.absent(),
    this.endHour = const Value.absent(),
    this.endMinute = const Value.absent(),
    this.weekdays = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SchedulesCompanion.insert({
    required String id,
    required String name,
    required int startHour,
    required int startMinute,
    required int endHour,
    required int endMinute,
    required String weekdays,
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        startHour = Value(startHour),
        startMinute = Value(startMinute),
        endHour = Value(endHour),
        endMinute = Value(endMinute),
        weekdays = Value(weekdays);
  static Insertable<Schedule> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? startHour,
    Expression<int>? startMinute,
    Expression<int>? endHour,
    Expression<int>? endMinute,
    Expression<String>? weekdays,
    Expression<bool>? isEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startHour != null) 'start_hour': startHour,
      if (startMinute != null) 'start_minute': startMinute,
      if (endHour != null) 'end_hour': endHour,
      if (endMinute != null) 'end_minute': endMinute,
      if (weekdays != null) 'weekdays': weekdays,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SchedulesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int>? startHour,
      Value<int>? startMinute,
      Value<int>? endHour,
      Value<int>? endMinute,
      Value<String>? weekdays,
      Value<bool>? isEnabled,
      Value<int>? rowid}) {
    return SchedulesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startHour: startHour ?? this.startHour,
      startMinute: startMinute ?? this.startMinute,
      endHour: endHour ?? this.endHour,
      endMinute: endMinute ?? this.endMinute,
      weekdays: weekdays ?? this.weekdays,
      isEnabled: isEnabled ?? this.isEnabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startHour.present) {
      map['start_hour'] = Variable<int>(startHour.value);
    }
    if (startMinute.present) {
      map['start_minute'] = Variable<int>(startMinute.value);
    }
    if (endHour.present) {
      map['end_hour'] = Variable<int>(endHour.value);
    }
    if (endMinute.present) {
      map['end_minute'] = Variable<int>(endMinute.value);
    }
    if (weekdays.present) {
      map['weekdays'] = Variable<String>(weekdays.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchedulesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startHour: $startHour, ')
          ..write('startMinute: $startMinute, ')
          ..write('endHour: $endHour, ')
          ..write('endMinute: $endMinute, ')
          ..write('weekdays: $weekdays, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsageSessionsTable extends UsageSessions
    with TableInfo<$UsageSessionsTable, UsageSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsageSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
      'end_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _scheduleIdMeta =
      const VerificationMeta('scheduleId');
  @override
  late final GeneratedColumn<String> scheduleId = GeneratedColumn<String>(
      'schedule_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, startTime, endTime, durationSeconds, scheduleId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usage_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<UsageSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    }
    if (data.containsKey('schedule_id')) {
      context.handle(
          _scheduleIdMeta,
          scheduleId.isAcceptableOrUnknown(
              data['schedule_id']!, _scheduleIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsageSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsageSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time'])!,
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_time']),
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds']),
      scheduleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}schedule_id']),
    );
  }

  @override
  $UsageSessionsTable createAlias(String alias) {
    return $UsageSessionsTable(attachedDatabase, alias);
  }
}

class UsageSession extends DataClass implements Insertable<UsageSession> {
  final int id;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationSeconds;
  final String? scheduleId;
  const UsageSession(
      {required this.id,
      required this.startTime,
      this.endTime,
      this.durationSeconds,
      this.scheduleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || scheduleId != null) {
      map['schedule_id'] = Variable<String>(scheduleId);
    }
    return map;
  }

  UsageSessionsCompanion toCompanion(bool nullToAbsent) {
    return UsageSessionsCompanion(
      id: Value(id),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      scheduleId: scheduleId == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduleId),
    );
  }

  factory UsageSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsageSession(
      id: serializer.fromJson<int>(json['id']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      scheduleId: serializer.fromJson<String?>(json['scheduleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'scheduleId': serializer.toJson<String?>(scheduleId),
    };
  }

  UsageSession copyWith(
          {int? id,
          DateTime? startTime,
          Value<DateTime?> endTime = const Value.absent(),
          Value<int?> durationSeconds = const Value.absent(),
          Value<String?> scheduleId = const Value.absent()}) =>
      UsageSession(
        id: id ?? this.id,
        startTime: startTime ?? this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        durationSeconds: durationSeconds.present
            ? durationSeconds.value
            : this.durationSeconds,
        scheduleId: scheduleId.present ? scheduleId.value : this.scheduleId,
      );
  UsageSession copyWithCompanion(UsageSessionsCompanion data) {
    return UsageSession(
      id: data.id.present ? data.id.value : this.id,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      scheduleId:
          data.scheduleId.present ? data.scheduleId.value : this.scheduleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsageSession(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('scheduleId: $scheduleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, startTime, endTime, durationSeconds, scheduleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsageSession &&
          other.id == this.id &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.durationSeconds == this.durationSeconds &&
          other.scheduleId == this.scheduleId);
}

class UsageSessionsCompanion extends UpdateCompanion<UsageSession> {
  final Value<int> id;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<int?> durationSeconds;
  final Value<String?> scheduleId;
  const UsageSessionsCompanion({
    this.id = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.scheduleId = const Value.absent(),
  });
  UsageSessionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.scheduleId = const Value.absent(),
  }) : startTime = Value(startTime);
  static Insertable<UsageSession> custom({
    Expression<int>? id,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? durationSeconds,
    Expression<String>? scheduleId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (scheduleId != null) 'schedule_id': scheduleId,
    });
  }

  UsageSessionsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? startTime,
      Value<DateTime?>? endTime,
      Value<int?>? durationSeconds,
      Value<String?>? scheduleId}) {
    return UsageSessionsCompanion(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      scheduleId: scheduleId ?? this.scheduleId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (scheduleId.present) {
      map['schedule_id'] = Variable<String>(scheduleId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsageSessionsCompanion(')
          ..write('id: $id, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('scheduleId: $scheduleId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SchedulesTable schedules = $SchedulesTable(this);
  late final $UsageSessionsTable usageSessions = $UsageSessionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [schedules, usageSessions];
}

typedef $$SchedulesTableCreateCompanionBuilder = SchedulesCompanion Function({
  required String id,
  required String name,
  required int startHour,
  required int startMinute,
  required int endHour,
  required int endMinute,
  required String weekdays,
  Value<bool> isEnabled,
  Value<int> rowid,
});
typedef $$SchedulesTableUpdateCompanionBuilder = SchedulesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> startHour,
  Value<int> startMinute,
  Value<int> endHour,
  Value<int> endMinute,
  Value<String> weekdays,
  Value<bool> isEnabled,
  Value<int> rowid,
});

class $$SchedulesTableFilterComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startHour => $composableBuilder(
      column: $table.startHour, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startMinute => $composableBuilder(
      column: $table.startMinute, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endHour => $composableBuilder(
      column: $table.endHour, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endMinute => $composableBuilder(
      column: $table.endMinute, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get weekdays => $composableBuilder(
      column: $table.weekdays, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));
}

class $$SchedulesTableOrderingComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startHour => $composableBuilder(
      column: $table.startHour, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startMinute => $composableBuilder(
      column: $table.startMinute, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endHour => $composableBuilder(
      column: $table.endHour, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endMinute => $composableBuilder(
      column: $table.endMinute, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get weekdays => $composableBuilder(
      column: $table.weekdays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));
}

class $$SchedulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchedulesTable> {
  $$SchedulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get startHour =>
      $composableBuilder(column: $table.startHour, builder: (column) => column);

  GeneratedColumn<int> get startMinute => $composableBuilder(
      column: $table.startMinute, builder: (column) => column);

  GeneratedColumn<int> get endHour =>
      $composableBuilder(column: $table.endHour, builder: (column) => column);

  GeneratedColumn<int> get endMinute =>
      $composableBuilder(column: $table.endMinute, builder: (column) => column);

  GeneratedColumn<String> get weekdays =>
      $composableBuilder(column: $table.weekdays, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);
}

class $$SchedulesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SchedulesTable,
    Schedule,
    $$SchedulesTableFilterComposer,
    $$SchedulesTableOrderingComposer,
    $$SchedulesTableAnnotationComposer,
    $$SchedulesTableCreateCompanionBuilder,
    $$SchedulesTableUpdateCompanionBuilder,
    (Schedule, BaseReferences<_$AppDatabase, $SchedulesTable, Schedule>),
    Schedule,
    PrefetchHooks Function()> {
  $$SchedulesTableTableManager(_$AppDatabase db, $SchedulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchedulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchedulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchedulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> startHour = const Value.absent(),
            Value<int> startMinute = const Value.absent(),
            Value<int> endHour = const Value.absent(),
            Value<int> endMinute = const Value.absent(),
            Value<String> weekdays = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SchedulesCompanion(
            id: id,
            name: name,
            startHour: startHour,
            startMinute: startMinute,
            endHour: endHour,
            endMinute: endMinute,
            weekdays: weekdays,
            isEnabled: isEnabled,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required int startHour,
            required int startMinute,
            required int endHour,
            required int endMinute,
            required String weekdays,
            Value<bool> isEnabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SchedulesCompanion.insert(
            id: id,
            name: name,
            startHour: startHour,
            startMinute: startMinute,
            endHour: endHour,
            endMinute: endMinute,
            weekdays: weekdays,
            isEnabled: isEnabled,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SchedulesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SchedulesTable,
    Schedule,
    $$SchedulesTableFilterComposer,
    $$SchedulesTableOrderingComposer,
    $$SchedulesTableAnnotationComposer,
    $$SchedulesTableCreateCompanionBuilder,
    $$SchedulesTableUpdateCompanionBuilder,
    (Schedule, BaseReferences<_$AppDatabase, $SchedulesTable, Schedule>),
    Schedule,
    PrefetchHooks Function()>;
typedef $$UsageSessionsTableCreateCompanionBuilder = UsageSessionsCompanion
    Function({
  Value<int> id,
  required DateTime startTime,
  Value<DateTime?> endTime,
  Value<int?> durationSeconds,
  Value<String?> scheduleId,
});
typedef $$UsageSessionsTableUpdateCompanionBuilder = UsageSessionsCompanion
    Function({
  Value<int> id,
  Value<DateTime> startTime,
  Value<DateTime?> endTime,
  Value<int?> durationSeconds,
  Value<String?> scheduleId,
});

class $$UsageSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $UsageSessionsTable> {
  $$UsageSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scheduleId => $composableBuilder(
      column: $table.scheduleId, builder: (column) => ColumnFilters(column));
}

class $$UsageSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $UsageSessionsTable> {
  $$UsageSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scheduleId => $composableBuilder(
      column: $table.scheduleId, builder: (column) => ColumnOrderings(column));
}

class $$UsageSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsageSessionsTable> {
  $$UsageSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<String> get scheduleId => $composableBuilder(
      column: $table.scheduleId, builder: (column) => column);
}

class $$UsageSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsageSessionsTable,
    UsageSession,
    $$UsageSessionsTableFilterComposer,
    $$UsageSessionsTableOrderingComposer,
    $$UsageSessionsTableAnnotationComposer,
    $$UsageSessionsTableCreateCompanionBuilder,
    $$UsageSessionsTableUpdateCompanionBuilder,
    (
      UsageSession,
      BaseReferences<_$AppDatabase, $UsageSessionsTable, UsageSession>
    ),
    UsageSession,
    PrefetchHooks Function()> {
  $$UsageSessionsTableTableManager(_$AppDatabase db, $UsageSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsageSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsageSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsageSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> startTime = const Value.absent(),
            Value<DateTime?> endTime = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<String?> scheduleId = const Value.absent(),
          }) =>
              UsageSessionsCompanion(
            id: id,
            startTime: startTime,
            endTime: endTime,
            durationSeconds: durationSeconds,
            scheduleId: scheduleId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime startTime,
            Value<DateTime?> endTime = const Value.absent(),
            Value<int?> durationSeconds = const Value.absent(),
            Value<String?> scheduleId = const Value.absent(),
          }) =>
              UsageSessionsCompanion.insert(
            id: id,
            startTime: startTime,
            endTime: endTime,
            durationSeconds: durationSeconds,
            scheduleId: scheduleId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UsageSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsageSessionsTable,
    UsageSession,
    $$UsageSessionsTableFilterComposer,
    $$UsageSessionsTableOrderingComposer,
    $$UsageSessionsTableAnnotationComposer,
    $$UsageSessionsTableCreateCompanionBuilder,
    $$UsageSessionsTableUpdateCompanionBuilder,
    (
      UsageSession,
      BaseReferences<_$AppDatabase, $UsageSessionsTable, UsageSession>
    ),
    UsageSession,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SchedulesTableTableManager get schedules =>
      $$SchedulesTableTableManager(_db, _db.schedules);
  $$UsageSessionsTableTableManager get usageSessions =>
      $$UsageSessionsTableTableManager(_db, _db.usageSessions);
}
