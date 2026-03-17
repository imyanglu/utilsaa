import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plan/common/models/common_enum.dart';
import 'package:plan/pages/plan_creator/widgets/time_selector.dart';

class IntervalSelector extends HookWidget {
  final IntervalEnum interval;
  final List<TimeOfDay>? times;
  final double? hour;
  final void Function(IntervalEnum, double?) onIntervalChanged;
  final void Function(List<TimeOfDay> times) onChangeTime;
  IntervalSelector({
    Key? key,
    required this.interval,
    required this.onIntervalChanged,
    required this.hour,
    this.times,
    required this.onChangeTime,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 强制
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
          spacing: 8,
          alignment: WrapAlignment.start,
          children: IntervalEnum.values.map((l) {
            bool isSelected = interval == l;
            return GestureDetector(
              onTap: () {
                onIntervalChanged(l, null);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
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
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      child: Text(l.label),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut, // 加上曲线更平滑
          // 使用 clipBehavior 保证高度缩小时，内部组件不会超出边界
          constraints: BoxConstraints(
            minHeight: interval == IntervalEnum.daily ? 100 : 0,
          ),
          // decoration: BoxDecoration(
          //   color: Color(0xffF8FAFD),
          //   border: BoxBorder.all(color: Color(0xffF2F5F9)),
          //   borderRadius: BorderRadius.circular(16),
          // ),
          child: TimeSelector(
            onChangeTime: onChangeTime,
            timeSelectorType: TimeSelectorType.time,

            times: IntervalEnum.daily == interval ? times ?? [] : null,
          ),
        ),
      ],
    );
  }
}
