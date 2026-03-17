import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plan/common/utils/help.dart';
import 'package:plan/local/model/plan.dart';
import 'package:plan/pages/home/model/plan_home_filter.dart';
import 'package:plan/pages/home/widgets/plan_status_filter.dart';
import 'package:plan/pages/home/widgets/week_card.dart';
import 'package:plan/pages/plan_creator/services/plan_service.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthCursor = useState<DateTime>(DateTime(now.year, now.month, 1));
    final selectedDate = useState<DateTime>(
      DateTime(now.year, now.month, now.day),
    );
    final filter = useState<PlanHomeFilter>(
      PlanHomeFilter(planStatus: PlanFilterOption.create),
    );
    final plans = useState<List<Plan>>([]);

    Future<void> loadPlans() async {
      try {
        final service = PlanService();
        final List<Plan> dbPlans = await service.getAllPlans();
        plans.value = dbPlans;
      } catch (e) {
        debugPrint('加载计划失败: $e');
      }
    }

    useEffect(() {
      Future.microtask(() async {
        try {
          loadPlans();
        } catch (_) {}
      });
      return null;
    }, const []);

    final processPlans = useMemoized(() {
      return plans.value.where(
        (p) => filter.value.planStatus.status == p.status,
      );
    }, [plans.value, filter.value]);
    final dotDays = useMemoized(() {
      return plans.value
          .where((p) => p.date.month == monthCursor.value.month)
          .map((p) => p.date.day)
          .toSet();
    }, [plans.value, monthCursor.value.month]);
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _AddPlanFab(
        onTap: () async {
          await context.push('/createPlan');
          await loadPlans();
        },
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: statusBarHeight + 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset('assets/images/relaxing.svg'),
              WeekCard(),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Icon(
                    Icons.event_note_outlined,
                    size: 18,
                    color: Color(0xFF9CA3AF),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      '今日计划',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ),
                  PlanStatusFilter(
                    selected: filter.value.planStatus,
                    onChanged: (option) {
                      filter.value = filter.value.copyWith(planStatus: option);
                      // 按 option.status 过滤列表
                    },
                  ),
                ],
              ),

              const SizedBox(height: 6),
              ...processPlans.map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: _PlanItem(model: p),
                ),
              ),

              const SizedBox(height: 10),

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

class _AddPlanFab extends StatelessWidget {
  final VoidCallback onTap;
  const _AddPlanFab({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            borderRadius: BorderRadius.circular(999),
            boxShadow: const [
              BoxShadow(
                color: Color(0x80000000),
                blurRadius: 18,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
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
        height: 40,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2F6CF6)
                      : Colors.transparent,
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

class _PlanItem extends StatelessWidget {
  final Plan model;
  const _PlanItem({required this.model});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEFF2F6)),
        ),
        child: Row(
          children: [
            _DateBadge(day: model.date.day, month: model.date.month),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Color(0xFF9CA3AF),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        dateFormat(model.date),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 10,
                      //     vertical: 4,
                      //   ),
                      //   // decoration: BoxDecoration(
                      //   //   color: model.,
                      //   //   borderRadius: BorderRadius.circular(999),
                      //   // ),
                      //   child: Text(
                      //     model.label.label,
                      //     style: const TextStyle(
                      //       fontSize: 11,
                      //       fontWeight: FontWeight.w800,
                      //       color: Color(0xFF6B7280),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            _CheckMark(isChecked: false),
          ],
        ),
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(999)),
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
