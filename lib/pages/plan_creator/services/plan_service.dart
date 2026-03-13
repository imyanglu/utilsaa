import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'package:plan/common/models/plan_creator.dart';
import 'package:plan/common/models/plan_type.dart';
import 'package:plan/common/services/isar_service.dart';
import 'package:plan/local/model/plan.dart';

class PlanService {
  Future<List<Plan>> getAllPlans() async {
    final Isar isar = IsarService.instance;
    return await isar.plans.where().sortByDate().findAll();
  }

  Future<void> savePlan(PlanCreator plan) async {
    // 1. 数据校验

    if (plan.name.text.isEmpty) throw Exception("名称不能为空");
    if (plan.date == null) throw Exception("日期不能为空");

    // 2. 数据转换 (把 PlanCreator 转为数据库模型)
    final dateTime = DateTime(
      plan.date!.year,
      plan.date!.month,
      plan.date!.day,
      plan.time.hour,
      plan.time.minute,
    );

    final Color color = plan.color ?? const Color(0xff2469F5);

    final planEntity = Plan()
      ..name = plan.name.text
      ..description = plan.note ?? ''
      ..date = dateTime
      ..label = plan.label
      ..colorValue = color.toARGB32()
      ..interval = plan.interval
      ..intervalHour = plan.intervalHour
      ..note = plan.note
      ..status = PlanStatus.create
      ..finishDate = []
      ..createTime = DateTime.now();

    // 3. 执行数据库操作（写入 Isar）
    final isar = IsarService.instance; // 局部变量
    await isar.writeTxn(() async {
      await isar.plans.put(planEntity);
    });
  }
}
