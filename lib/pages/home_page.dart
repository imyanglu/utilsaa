import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthCursor = useState<DateTime>(DateTime(now.year, now.month, 1));
    final selectedDate = useState<DateTime>(DateTime(now.year, now.month, now.day));

    final plans = useMemoized(
      () => <_PlanUiModel>[
        _PlanUiModel(
          day: 16,
          month: 3,
          title: '产品设计评审',
          timeText: '14:30',
          tagText: '工作',
          tagBg: const Color(0xFFE9EFFA),
          isDone: false,
        ),
        _PlanUiModel(
          day: 18,
          month: 3,
          title: '健身房：背部训练',
          timeText: '18:45',
          tagText: '健康',
          tagBg: const Color(0xFFEAF6EE),
          isDone: false,
        ),
        _PlanUiModel(
          day: 11,
          month: 3,
          title: '撰写季度汇报PPT',
          timeText: '10:00',
          tagText: '工作',
          tagBg: const Color(0xFFE9EFFA),
          isDone: true,
        ),
        _PlanUiModel(
          day: 21,
          month: 3,
          title: '朋友聚餐·南山店',
          timeText: '19:30',
          tagText: '个人',
          tagBg: const Color(0xFFEFF1F4),
          isDone: false,
        ),
      ],
      const [],
    );

    final dotDays = useMemoized(() {
      return plans
          .where((p) => p.month == monthCursor.value.month)
          .map((p) => p.day)
          .toSet();
    }, [plans, monthCursor.value.month]);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '你好, 一晨',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                            height: 1.05,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.waving_hand_rounded, size: 18, color: Color(0xFFFFA64D)),
                            SizedBox(width: 8),
                            Text(
                              '周二 · 宜专注',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const _AvatarButton(),
                ],
              ),

              const SizedBox(height: 14),
              _CalendarCard(
                monthCursor: monthCursor.value,
                selectedDate: selectedDate.value,
                dotDays: dotDays,
                onPrevMonth: () {
                  final m = monthCursor.value;
                  monthCursor.value = DateTime(m.year, m.month - 1, 1);
                },
                onNextMonth: () {
                  final m = monthCursor.value;
                  monthCursor.value = DateTime(m.year, m.month + 1, 1);
                },
                onPickDay: (day) {
                  selectedDate.value = DateTime(
                    monthCursor.value.year,
                    monthCursor.value.month,
                    day,
                  );
                },
              ),

              const SizedBox(height: 18),
              Row(
                children: [
                  const Icon(Icons.event_note_outlined, size: 18, color: Color(0xFF9CA3AF)),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      '近期计划',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ),
                  _AllButton(onTap: () {}),
                ],
              ),

              const SizedBox(height: 10),
              ...plans.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _PlanItem(model: p),
                  )),

              const SizedBox(height: 10),
              _BottomActionButton(
                text: '设置自定义小时',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  '今日完成 1/4 个计划',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarButton extends StatelessWidget {
  const _AvatarButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: const Color(0x0F000000),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: const Icon(Icons.person, color: Color(0xFF6B7280)),
        ),
      ),
    );
  }
}

class _CalendarCard extends StatelessWidget {
  final DateTime monthCursor;
  final DateTime selectedDate;
  final Set<int> dotDays;
  final VoidCallback onPrevMonth;
  final VoidCallback onNextMonth;
  final ValueChanged<int> onPickDay;

  const _CalendarCard({
    required this.monthCursor,
    required this.selectedDate,
    required this.dotDays,
    required this.onPrevMonth,
    required this.onNextMonth,
    required this.onPickDay,
  });

  @override
  Widget build(BuildContext context) {
    final monthText = '${monthCursor.month}月 ${monthCursor.year}';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                monthText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),
              const Spacer(),
              _MonthNavButton(icon: Icons.chevron_left, onTap: onPrevMonth),
              const SizedBox(width: 8),
              _MonthNavButton(icon: Icons.chevron_right, onTap: onNextMonth),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              _WeekdayCell(text: '一'),
              _WeekdayCell(text: '二'),
              _WeekdayCell(text: '三'),
              _WeekdayCell(text: '四'),
              _WeekdayCell(text: '五'),
              _WeekdayCell(text: '六'),
              _WeekdayCell(text: '日'),
            ],
          ),
          const SizedBox(height: 6),
          ..._buildWeeks(context),
        ],
      ),
    );
  }

  List<Widget> _buildWeeks(BuildContext context) {
    final firstDay = DateTime(monthCursor.year, monthCursor.month, 1);
    final nextMonth = DateTime(monthCursor.year, monthCursor.month + 1, 1);
    final daysInMonth = nextMonth.difference(firstDay).inDays;
    final startOffset = (firstDay.weekday - DateTime.monday) % 7; // 0..6

    final totalCells = ((startOffset + daysInMonth + 6) ~/ 7) * 7; // full weeks
    final rows = totalCells ~/ 7;

    final List<Widget> weekRows = [];
    int cellIndex = 0;
    for (int r = 0; r < rows; r++) {
      final dayCells = <Widget>[];
      for (int c = 0; c < 7; c++) {
        final dayNumber = cellIndex - startOffset + 1; // 1..daysInMonth
        final inMonth = dayNumber >= 1 && dayNumber <= daysInMonth;

        final isSelected = inMonth &&
            selectedDate.year == monthCursor.year &&
            selectedDate.month == monthCursor.month &&
            selectedDate.day == dayNumber;

        dayCells.add(
          Expanded(
            child: _DayCell(
              day: inMonth ? dayNumber : null,
              isSelected: isSelected,
              hasDot: inMonth ? dotDays.contains(dayNumber) : false,
              onTap: inMonth ? () => onPickDay(dayNumber) : null,
            ),
          ),
        );
        cellIndex++;
      }
      weekRows.add(Row(children: dayCells));
      if (r != rows - 1) weekRows.add(const SizedBox(height: 6));
    }
    return weekRows;
  }
}

class _MonthNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _MonthNavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 30,
          height: 28,
          child: Icon(icon, size: 18, color: const Color(0xFF6B7280)),
        ),
      ),
    );
  }
}

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
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF9CA3AF),
          ),
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  final int? day;
  final bool isSelected;
  final bool hasDot;
  final VoidCallback? onTap;

  const _DayCell({
    required this.day,
    required this.isSelected,
    required this.hasDot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (day == null) {
      return const SizedBox(height: 38);
    }

    final baseText = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      color: isSelected ? Colors.white : const Color(0xFF111827),
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: 38,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF2F6CF6) : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Center(child: Text('$day', style: baseText)),
              ),
              const SizedBox(height: 3),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: hasDot ? const Color(0xFF2F6CF6) : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AllButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AllButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF3F4F6),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            '全部',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _PlanUiModel {
  final int day;
  final int month;
  final String title;
  final String timeText;
  final String tagText;
  final Color tagBg;
  final bool isDone;

  const _PlanUiModel({
    required this.day,
    required this.month,
    required this.title,
    required this.timeText,
    required this.tagText,
    required this.tagBg,
    required this.isDone,
  });
}

class _PlanItem extends StatelessWidget {
  final _PlanUiModel model;
  const _PlanItem({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFF2F6)),
      ),
      child: Row(
        children: [
          _DateBadge(day: model.day, month: model.month),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Color(0xFF9CA3AF)),
                    const SizedBox(width: 6),
                    Text(
                      model.timeText,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: model.tagBg,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        model.tagText,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _CheckMark(isChecked: model.isDone),
        ],
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  final int day;
  final int month;
  const _DateBadge({required this.day, required this.month});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFF2F6)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$day',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF111827),
              height: 1.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '$month月',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFF9CA3AF),
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckMark extends StatelessWidget {
  final bool isChecked;
  const _CheckMark({required this.isChecked});

  @override
  Widget build(BuildContext context) {
    if (isChecked) {
      return Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: const Color(0xFF2E8B57),
          borderRadius: BorderRadius.circular(999),
        ),
        child: const Icon(Icons.check, size: 16, color: Colors.white),
      );
    }

    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1.6),
      ),
    );
  }
}

class _BottomActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _BottomActionButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: const Color(0xFFEFF3F8),
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.alarm, size: 18, color: Color(0xFF6B7280)),
                SizedBox(width: 10),
                Text(
                  '设置自定义小时',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
