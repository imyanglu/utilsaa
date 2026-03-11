import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:music/common/data/const.dart';
import 'package:music/common/models/label_type.dart';

class ColorSelector extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("🎨", style: TextStyle(fontSize: 16)),
            SizedBox(width: 4),
            Text(
              "颜色标记",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff4F5F73),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          spacing: 8,
          children: planColors
              .map(
                (l) => Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: l,
                    border: BoxBorder.all(color: Color(0xffF2F5F9)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
