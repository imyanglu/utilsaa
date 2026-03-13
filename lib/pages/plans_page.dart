import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plan/common/widgets/add_plan_button.dart';

class PlansPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [AddPlanButton()]),
        ),
      ),
    );
  }
}
