import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:plan/common/widgets/input.dart';
import 'package:plan/pages/plan_creator/hooks/use_plan_data.dart';
import 'package:plan/pages/plan_creator/services/plan_service.dart';
import 'package:plan/pages/plan_creator/widgets/color_selector.dart';
import 'package:plan/pages/plan_creator/widgets/interval_selector.dart';

import 'package:plan/pages/plan_creator/widgets/plan_date_picker.dart';
import 'package:plan/pages/plan_creator/widgets/plan_remark.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PlanForm extends HookWidget {
  const PlanForm({super.key});
  @override
  Widget build(BuildContext context) {
    final (:plan_data, :updatePlan) = usePlanForm();
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 4,
                  bottom: 0,
                ),
                margin: EdgeInsets.all(12),

                child: Form(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("📋", style: TextStyle(fontSize: 16)),
                          SizedBox(width: 4),
                          Text(
                            "计划名称",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff4F5F73),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Input(controller: plan_data.name),
                      SizedBox(height: 12),
                      PlanDatePicker(
                        time: plan_data.time,
                        date: plan_data.date,
                        onTimeChanged: (time) {
                          updatePlan(plan_data.copyWith(time: time));
                        },
                        onDateChanged: (n) {
                          updatePlan(plan_data.copyWith(date: n));
                        },
                      ),
                      SizedBox(height: 12),
                      ColorSelector(
                        color: plan_data.color,
                        onColorChange: (c) {
                          updatePlan(plan_data.copyWith(color: c));
                        },
                      ),
                      SizedBox(height: 12),
                      IntervalSelector(
                        onChangeTimes: (times) {
                          updatePlan(plan_data.copyWith(count: times));
                        },
                        times: plan_data.count,
                        interval: plan_data.interval,
                        hour: plan_data.intervalHour,
                        onIntervalChanged: (i, d) {
                          updatePlan(
                            plan_data.copyWith(
                              interval: i,
                              intervalHour: plan_data.intervalHour,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 12),
                      PlanRemark(remark: "", remarkTitle: ""),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Color(0xffF2F5F9), // 颜色
            thickness: 1, // 线条粗细
            indent: 12, // 左侧缩进
            endIndent: 12, // 右侧缩进
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xffEEF2F7),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.close, size: 24, color: Color(0xff7D44D6)),
                          Text(
                            "返回",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xff333333),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () async {
                      final planService = PlanService();

                      try {
                        await planService.savePlan(plan_data);
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.info(message: "创建成功!"),
                        );
                      } catch (e) {
                        print(e);
                        String error = e.toString().split(': ').last;
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(message: error),
                        );
                      }
                    },
                    child: Container(
                      height: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xff2469F5),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.done, size: 24, color: Color(0xff7D44D6)),
                          Text(
                            "创建计划",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
