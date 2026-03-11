import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

dateTimeFormat(DateTime date) {
  return '${date.year.toString()}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
}

timeFormat(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

class PlanDatePicker extends HookWidget {
  final DateTime? date;
  final TimeOfDay time;
  final Function(DateTime? date)? onDateChanged;
  final Function(TimeOfDay time)? onTimeChanged;
  PlanDatePicker({
    this.date,
    this.onDateChanged,
    required this.time,
    this.onTimeChanged,
  });
  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    // TODO: implement build
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Text("📅", style: TextStyle(fontSize: 16)),
                  SizedBox(width: 4),
                  Text(
                    "日期",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4F5F73),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  print("请求打开");
                  if (isLoading.value) return;
                  isLoading.value = true;
                  try {
                    final date = await showDatePicker(
                      locale: const Locale('zh', 'CH'),
                      // 还可以自定义按钮文字
                      confirmText: "确定",
                      cancelText: "取消",
                      helpText: "选择日期",
                      context: context,
                      initialDate: DateTime.now(), // 默认选中日期
                      firstDate: DateTime(2000), // 可选的最早日期
                      lastDate: DateTime(2100), // 可选的最晚日期
                      onDatePickerModeChange: (value) {
                        print(value);
                      },
                    );
                    if (date != null) onDateChanged?.call(date);
                  } catch (e) {
                    print(e);
                  } finally {
                    isLoading.value = false;
                  }
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: BoxBorder.all(color: Color(0xffE2EAF3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date != null ? dateTimeFormat(date!) : "选择日期",
                        style: TextStyle(
                          fontSize: 16,
                          color: date == null ? Colors.grey : Colors.black87,
                        ),
                      ),
                      Icon(Icons.date_range, size: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Text("⏰", style: TextStyle(fontSize: 16)),
                  SizedBox(width: 4),
                  Text(
                    "时间",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4F5F73),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  if (isLoading.value) return;
                  isLoading.value = true;
                  try {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (date != null) onTimeChanged?.call(time!);
                  } catch (e) {
                    print(e);
                  } finally {
                    isLoading.value = false;
                  }
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: BoxBorder.all(color: Color(0xffE2EAF3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        timeFormat(time),
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      Icon(Icons.access_time, size: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
