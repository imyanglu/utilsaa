import 'package:isar/isar.dart';
import 'package:plan/common/models/common_enum.dart';
import 'package:plan/common/models/label_type.dart';
import 'package:plan/common/models/plan_type.dart';
part 'plan.g.dart';

@collection
class Plan {
  Id id = Isar.autoIncrement;
  late String name;
  late String description;
  late DateTime date;
  @enumerated
  late PlanLabel label;
  late int colorValue;
  @enumerated
  late IntervalEnum interval;
  late double? intervalHour;
  late String? note;
  @enumerated
  late PlanStatus status;
  late List<DateTime>? finishDate;
  late DateTime createTime;
}
