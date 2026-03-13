import 'package:flutter/material.dart';
import 'package:plan/common/models/label_type.dart';

class LabelSelector extends StatelessWidget {
  final PlanLabel label;
  final void Function(PlanLabel) onLabelChanged;
  const LabelSelector({
    Key? key,
    this.label = PlanLabel.personal,
    required this.onLabelChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("🏷️", style: TextStyle(fontSize: 16)),
            SizedBox(width: 4),
            Text(
              "标签",
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
          runSpacing: 6,
          children: PlanLabel.values.map((l) {
            bool isSelected = l == label;
            return GestureDetector(
              onTap: () {
                onLabelChanged(l);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200), // 动画持续时间

                alignment: Alignment.center,
                width: 100,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xff2469F5) : Color(0xffF8FAFD),
                  border: BoxBorder.all(
                    color: isSelected ? Color(0xff2469F5) : Color(0xffF2F5F9),
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l.icon + " "),
                    Text(
                      l.label,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
