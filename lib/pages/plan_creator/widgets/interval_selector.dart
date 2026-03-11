import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:music/common/data/const.dart';
import 'package:music/common/models/commen_enum.dart';
import 'package:music/common/models/label_type.dart';

class IntervalSelector extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("🔄", style: TextStyle(fontSize: 16)),
            SizedBox(width: 4),
            Text(
              "重复",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff4F5F73),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Wrap(
          direction: Axis.horizontal,
          spacing: 8,
          runSpacing: 8,
          children: IntervalEnum.values
              .map(
                (l) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xffF8FAFD),
                    border: BoxBorder.all(color: Color(0xffF2F5F9)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text(l.label)],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
