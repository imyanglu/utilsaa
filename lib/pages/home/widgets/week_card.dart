import 'package:flutter/material.dart';

class _WeekdayCell extends StatelessWidget {
  final String text;

  const _WeekdayCell({required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF9CA3AF),
          ),
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  // 本周开始（周一）
  DateTime get startOfWeek {
    return subtract(Duration(days: weekday - 1));
  }

  // 本周结束（周日）
  DateTime get endOfWeek {
    return add(Duration(days: 7 - weekday));
  }

  // 本周所有日期
  List<DateTime> get weekDays {
    final start = startOfWeek;
    return List.generate(7, (i) => start.add(Duration(days: i)));
  }
}

class WeekCard extends StatelessWidget {
  final DateTime? dateTime;
  const WeekCard({Key? key, this.dateTime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // 本周一到周日
    final days = now.weekDays;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0F000000),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              '周一',
              '周二',
              '周三',
              '周四',
              '周五',
              '周六',
              '周日',
            ].map((i) => _WeekdayCell(text: i)).toList(),
          ),
          SizedBox(height: 8),
          Row(
            children: days
                .map((i) => _WeekdayCell(text: i.day.toString()))
                .toList(),
          ),
        ],
      ),
    );
  }
}
