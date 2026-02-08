import 'package:flutter/material.dart';

class ScheduleModel {
  final String id;
  final String name;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<int> weekdays; // 1 = Monday, 7 = Sunday
  final bool isEnabled;

  const ScheduleModel({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.weekdays,
    this.isEnabled = true,
  });

  ScheduleModel copyWith({
    String? id,
    String? name,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    List<int>? weekdays,
    bool? isEnabled,
  }) {
    return ScheduleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      weekdays: weekdays ?? this.weekdays,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startHour': startTime.hour,
      'startMinute': startTime.minute,
      'endHour': endTime.hour,
      'endMinute': endTime.minute,
      'weekdays': weekdays,
      'isEnabled': isEnabled,
    };
  }

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] as String,
      name: json['name'] as String,
      startTime: TimeOfDay(
        hour: json['startHour'] as int,
        minute: json['startMinute'] as int,
      ),
      endTime: TimeOfDay(
        hour: json['endHour'] as int,
        minute: json['endMinute'] as int,
      ),
      weekdays: List<int>.from(json['weekdays'] as List),
      isEnabled: json['isEnabled'] as bool,
    );
  }
}
