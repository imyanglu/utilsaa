import 'package:flutter/material.dart';
import 'package:plan/common/models/common_enum.dart';
import 'package:plan/common/models/label_type.dart';
import 'package:plan/pages/plan_creator/widgets/interval_selector.dart';

enum PlanCreatorKey {
  name,
  date,
  time,
  label,
  color,
  interval,
  intervalHour,
  note,
}

class PlanCreator {
  final TextEditingController name;
  final DateTime? date;
  final TimeOfDay time;
  final PlanLabel label;
  final Color? color;
  final IntervalEnum interval;
  final String? note;
  final double intervalHour;

  PlanCreator copyWith({
    TextEditingController? name,
    DateTime? date,
    TimeOfDay? time,
    PlanLabel? label,
    Color? color,
    IntervalEnum? interval,
    String? note,
    double? intervalHour,
  }) {
    return PlanCreator(
      name: name ?? this.name,
      date: date ?? this.date,
      time: time ?? this.time,
      label: label ?? this.label,
      color: color ?? this.color,
      interval: interval ?? this.interval,
      note: note ?? this.note,
      intervalHour: intervalHour ?? this.intervalHour,
    );
  }

  PlanCreator({
    required this.name,
    this.date,
    required this.time,
    required this.label,
    this.color = const Color(0xff2469F5),
    required this.interval,
    required this.intervalHour,
    this.note,
  });
}
