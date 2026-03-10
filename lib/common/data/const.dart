import 'package:music/common/models/plan_type.dart';

List<PlanType> planTypes = [
  PlanType(
    type: "fixed",
    key: "daily",
    label: "日期时间",
    description: "制定一个计划开始时间.",
  ),
  PlanType(
    type: "interval",
    key: "setInterval",
    label: "指定时间间隔",
    description: "固定时间间隔生成计划.",
  ),
  PlanType(type: "interval", key: "daily", label: "每天", description: "每日一计."),
  PlanType(type: "interval", key: "weekly", label: "每周", description: "每周一计."),
  PlanType(type: "interval", key: "monthly", label: "每月", description: "每月一计."),
  PlanType(type: "interval", key: "yearly", label: "每年", description: "每年一计."),
];
