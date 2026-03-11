import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:music/common/models/common_enum.dart';
import 'package:music/common/utils/help.dart';

class IntervalSelector extends HookWidget {
  final IntervalEnum interval;
  final double? hour;
  final void Function(IntervalEnum, double?) onIntervalChanged;
  IntervalSelector({
    Key? key,
    required this.interval,
    required this.onIntervalChanged,
    required this.hour,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hourController = useTextEditingController();
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
          children: IntervalEnum.values.map((l) {
            bool isSelected = interval == l;
            return GestureDetector(
              onTap: () {
                if (l == IntervalEnum.other) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        titleTextStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                        title: const Text('⏱️ 自定义小时'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "设置小时数",
                              style: TextStyle(color: Color(0xff4F5F73)),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.only(right: 12),
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color(0xffF8FAFD),
                                border: BoxBorder.all(color: Color(0xffD5E2F5)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextField(
                                      controller: hourController,
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        hintText: "请输入小时数",

                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      left: 4,
                                      right: 12,
                                      bottom: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xffEEF2F7),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text("小时"),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffF8FAFD),
                                border: BoxBorder.all(color: Color(0xffD5E2F5)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Text("💡你可以直接输入任意小时数，支持一位小数,范围0-1000小时"),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              '取消',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              bool isPositiveNum = isPositiveNumber(
                                hourController.text,
                              );
                              if (!isPositiveNum) return;
                              double l = double.parse(hourController.text);
                              if (l > 1000) {
                                return;
                              }
                              double hour = double.parse(l.toStringAsFixed(1));
                              onIntervalChanged(IntervalEnum.other, hour);
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              '确定',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  onIntervalChanged(l, null);
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
                      child: Text(
                        (l == IntervalEnum.other && isSelected && hour != null)
                            ? '${hour}小时'
                            : l.label,
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
