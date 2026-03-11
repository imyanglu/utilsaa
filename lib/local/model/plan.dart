import 'package:isar/isar.dart';
part 'plan.g.dart';

@collection
class Plan {
  Id id = Isar.autoIncrement;
  late String name;
  late String description;
  late DateTime date;
  late int timeInMinutes;
}
