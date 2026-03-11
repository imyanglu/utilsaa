import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:music/common/data/const.dart';
import 'package:music/common/widgets/input.dart';
import 'package:music/common/widgets/selector.dart';
import 'package:music/pages/plan_creator/hooks/use_plan_data.dart';
import 'package:music/pages/plan_creator/widgets/color_selector.dart';
import 'package:music/pages/plan_creator/widgets/interval_selector.dart';
import 'package:music/pages/plan_creator/widgets/label_selector.dart';
import 'package:music/pages/plan_creator/widgets/plan_date_picker.dart';
import 'package:music/pages/plan_creator/widgets/plan_remark.dart';

class PlanForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final (:date, :nameTextController, :changeDate) = usePlanForm();
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
                color: Colors.white,
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
                      Input(controller: nameTextController),

                      SizedBox(height: 12),
                      PlanDatePicker(date: date, onDateChanged: changeDate),
                      SizedBox(height: 12),
                      LabelSelector(),
                      SizedBox(height: 12),
                      ColorSelector(),
                      SizedBox(height: 12),
                      IntervalSelector(),
                      SizedBox(height: 12),
                      PlanRemark(remark: "", remarkTitle: ""),
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
                  flex: 2,
                  child: GestureDetector(
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
                            "取消",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
