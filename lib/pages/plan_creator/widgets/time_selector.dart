import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plan/common/utils/help.dart';

enum TimeSelectorType { time, interval }

class TimeSelector extends HookWidget {
  final TimeSelectorType timeSelectorType;
  final List<TimeOfDay>? times;

  final void Function(List<TimeOfDay> times) onChangeTime;
  TimeSelector({
    required this.timeSelectorType,
    required this.times,
    required this.onChangeTime,
  });
  _addTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (time != null) {
      final List<TimeOfDay> newTimes = [...(times ?? []), time];

      onChangeTime(newTimes);
    }
  }

  Widget _buildEmptyContent(BuildContext context) {
    final isLoading = useState(false);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "当前没有任何设置",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 6),
          GestureDetector(
            onTap: () async {
              if (isLoading.value) return;
              isLoading.value = true;
              try {
                await _addTime(context);
              } catch (e) {
                print(e);
              } finally {
                isLoading.value = false;
              }
            },

            child: Text(
              "添加",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff45D7F9),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xff45D7F9),
                // decorationStyle: TextDecorationStyle.wavy,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Wrap(
      spacing: 6,
      runSpacing: 8,
      alignment: WrapAlignment.spaceBetween,
      children: times!.map((time) {
        return GestureDetector(
          onTap: () {
            // onTimeChanged(time);
          },
          child: Stack(
            children: [
              Container(
                width: 88,
                height: 48,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Color(0xffF8FAFD),
                  border: BoxBorder.all(color: Color(0xffD5E2F5)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  timeFormat(time),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                right: 8,
                top: 6,
                child: GestureDetector(
                  onTap: () {
                    final newTimes = times!.where((t) => t != time).toList();
                    onChangeTime(newTimes);
                    print(newTimes);
                  },
                  child: Icon(Icons.close, size: 18, color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    if (times == null) return SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Color(0xffF8FAFD),
        border: BoxBorder.all(color: Color(0xffD5E2F5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Row(
            children: [
              Text("🕒"),
              Text(
                " 每日计划重复时间",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4F5F73),
                ),
              ),
              Spacer(),

              IconButton(
                onPressed: () async {
                  if (isLoading.value) return;
                  isLoading.value = true;
                  try {
                    await _addTime(context);
                  } catch (e) {
                    print(e);
                  } finally {
                    isLoading.value = false;
                  }
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 4),
          times!.isEmpty ? _buildEmptyContent(context) : _buildTimeSelector(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
