import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plan/common/models/common_enum.dart';
import 'package:plan/common/models/label_type.dart';
import 'package:plan/common/models/plan_creator.dart';

({PlanCreator plan_data, Function(PlanCreator newPlan) updatePlan})
usePlanForm() {
  final planData = useState(
    PlanCreator(
      name: useTextEditingController(),
      time: TimeOfDay(hour: 8, minute: 0),
      label: PlanLabel.personal,
      interval: IntervalEnum.none,
      intervalHour: 8,
      extendParams: {
        'times': [TimeOfDay(hour: 8, minute: 0)],
      },
    ),
  );
  // 定义 update 方法
  void updatePlan(PlanCreator newPlan) {
    planData.value = newPlan;
  }

  return (plan_data: planData.value, updatePlan: updatePlan);
}
