import 'package:plan/common/models/selector.dart';

enum PlanStatus {
  create("创建"),
  active("活跃"),
  archived("废弃"),
  completed("完成");

  final String label;
  const PlanStatus(this.label);
  bool get isActive => this == PlanStatus.active;
  bool get isArchived => this == PlanStatus.archived;
  bool get isCompleted => this == PlanStatus.completed;
}

class PlanType extends Selector {
  final String type;
  // final String? description;
  // final String key;
  // final String label;
  final String? date;
  final String? time;

  final String? unit;
  final PlanStatus? status;
  final int times;
  PlanType({
    String? description,
    required String label,
    required String key,
    required this.type,
    this.unit,
    this.date,
    this.time,

    this.status = PlanStatus.create,
    this.times = 0,
  }) : super(key: key, description: description, label: label);
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'label': label,
      'type': type,
      'key': key,
      'date': date,
      'time': time,
      'unit': unit,
      'status': status?.label,
    };
  }
}
