import 'package:isar/isar.dart';
import 'package:music/common/models/common_enum.dart';
import 'package:music/common/models/label_type.dart';
import 'package:music/common/models/plan_type.dart';
part 'plan.g.dart';

@collection
class Plan {
  Id id = Isar.autoIncrement;
  late String name;
  late String description;
  late DateTime date;
  late int timeInMinutes;
  @enumerated
  late PlanLabel label;
  late int colorValue;
  @enumerated
  late IntervalEnum interval;
  late double intervalHour;
  late String? note;
  @enumerated
  late PlanStatus status;
  late int? finishCount;
  late DateTime createTime;
  late DateTime lastFinishedTime;
}
