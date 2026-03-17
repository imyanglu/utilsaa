import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plan/common/widgets/back_button.dart';
import 'package:plan/pages/plan_creator/widgets/plan_form.dart';

class PlanCreatorPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Color(0x60ffffff),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 12),
                  BackBut(),
                  SizedBox(width: 12),
                  Text(
                    "创建计划",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(width: 16),
                  Text("清晰规划每一天", style: TextStyle(color: Colors.white)),
                ],
              ),
              PlanForm(),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
