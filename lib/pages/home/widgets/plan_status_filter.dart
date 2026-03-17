import 'package:flutter/material.dart';
import 'package:plan/common/models/plan_type.dart';

enum PlanFilterOption {
  // all("全部", null),
  create("活跃", PlanStatus.create),
  completed("完成", PlanStatus.completed);
  // archived("废弃", PlanStatus.archived);

  final String label;
  final PlanStatus? status;
  const PlanFilterOption(this.label, this.status);
}

class PlanStatusFilter extends StatelessWidget {
  final PlanFilterOption selected;
  final ValueChanged<PlanFilterOption> onChanged;

  const PlanStatusFilter({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6,
      children: PlanFilterOption.values.map((option) {
        final isSelected = option == selected;
        final color = option.status?.color ?? const Color(0xFF6B7280);
        final bgColor = option.status?.bgColor ?? const Color(0xFFF3F4F6);

        return GestureDetector(
          onTap: () => onChanged(option),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? bgColor : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isSelected ? color : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Text(
              option.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isSelected ? color : const Color(0xFF9CA3AF),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
