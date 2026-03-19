import 'dart:ui';

import 'package:plan/common/models/selector.dart';

enum PlanStatus {
  create("活跃", Color(0xFFFF6B35), Color(0xFFFFF0EB)),
  archived("废弃", Color(0xFF8B8FA8), Color(0xFFF0F1F5)), // 灰
  partial("部分完成", Color(0xFF007AFF), Color(0xFFE5F2FF)), // 经典蓝
  completed("完成", Color(0xFF00C48C), Color(0xFFE0FAF3)); // 绿

  final String label;
  final Color color; // 主色（文字、图标）
  final Color bgColor; // 背景色（标签底色）

  const PlanStatus(this.label, this.color, this.bgColor);

  bool get isCreate => this == PlanStatus.create;
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
