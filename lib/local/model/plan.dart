import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:plan/common/models/common_enum.dart';

import 'package:plan/common/models/plan_type.dart';
part 'plan.g.dart';

@collection
class Plan {
  Id id = Isar.autoIncrement;
  @Index(type: IndexType.value) // 对名称建立索引，方便搜索
  late String name; // 计划名称
  @Index()
  late DateTime date; // 启动日期
  late int colorValue; // 颜色标记

  @enumerated
  @Index()
  late IntervalEnum interval; //重复类型
  List<int>? alertTimeMinutes; //提醒时间
  late String? note; //备注
  @enumerated
  @Index()
  late PlanStatus status; // 计划状态
  late List<DateTime>? finishDate; //完成日期
  late DateTime createTime = DateTime.now();
  @ignore
  Color get color => Color(colorValue);
  @ignore
  set color(Color color) => colorValue = color.toARGB32();
  set alertTimes(List<TimeOfDay> times) {
    alertTimeMinutes = times.map((t) => t.hour * 60 + t.minute).toList();
  }

  /// 将存储的分钟数转换为 UI 可用的 TimeOfDay 列表
  @ignore
  List<TimeOfDay>? get alertTimes {
    return alertTimeMinutes
        ?.map((m) => TimeOfDay(hour: m ~/ 60, minute: m % 60))
        .toList();
  }

  /// 更新提醒时间
  void updateAlertTimes(List<TimeOfDay> times) {
    alertTimeMinutes = times.map((t) => t.hour * 60 + t.minute).toList();
  }

  /// 快捷判断今日是否已完成
  bool isFinishedToday() {
    if (finishDate == null || finishDate!.isEmpty) return false;
    final now = DateTime.now();
    return finishDate!.any(
      (d) => d.year == now.year && d.month == now.month && d.day == now.day,
    );
  }
}
