import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class AddPlanButton extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double screenWidth = MediaQuery.of(context).size.width;
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xffF0F4FC)), // 浅蓝色背景
        foregroundColor: MaterialStateProperty.all(Colors.blue), // 蓝色文字/图标
        side: MaterialStateProperty.all(BorderSide(color: Colors.blue)), // 边框颜色
      ),
      onPressed: () {
        context.push("/createPlan");
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 24),
            SizedBox(width: 8),
            Text('制定新计划'),
          ],
        ),
      ),
    );
  }
}
