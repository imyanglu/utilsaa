import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:music/common/data/const.dart';
import 'package:music/common/widgets/input.dart';
import 'package:music/common/widgets/selector.dart';
import 'package:music/pages/plan_creator/hooks/use_plan_data.dart';
import 'package:music/pages/plan_creator/widgets/plan_date_picker.dart';

class PlanForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final (:date, :nameTextController, :changeDate) = usePlanForm();
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
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
            SizedBox(height: 12),
            Input(controller: nameTextController),

            SizedBox(height: 16),
            PlanDatePicker(date: date, onDateChanged: changeDate),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
