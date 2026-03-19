import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plan/common/models/common_enum.dart';

class IntervalSelector extends HookWidget {
  final IntervalEnum interval;
  final int times;
  final double? hour;
  final void Function(IntervalEnum, double?) onIntervalChanged;
  final void Function(int times) onChangeTimes;
  IntervalSelector({
    Key? key,
    required this.interval,
    required this.onIntervalChanged,
    required this.hour,
    required this.times,
    required this.onChangeTimes,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 强制
      children: [
        Row(
          children: [
            Icon(Icons.repeat, size: 22, color: Color(0xffC2E7FF)),

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
          runSpacing: 4,
          alignment: WrapAlignment.start,
          children: IntervalEnum.values.map((l) {
            bool isSelected = interval == l;
            return GestureDetector(
              onTap: () {
                onIntervalChanged(l, null);
                if (l != IntervalEnum.none) {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      backgroundColor: Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min, // 高度自适应
                          children: [
                            TextField(controller: controller),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('关闭'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('保存'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
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
      ],
    );
  }
}
