import 'package:plan/pages/home/widgets/plan_status_filter.dart';

class PlanHomeFilter {
  final PlanFilterOption planStatus;
  final DateTime? dateTime;
  PlanHomeFilter({required this.planStatus, this.dateTime});
  PlanHomeFilter copyWith({PlanFilterOption? planStatus, DateTime? dateTime}) {
    return PlanHomeFilter(
      planStatus: planStatus ?? this.planStatus,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
