import 'package:isar/isar.dart';

@collection
class Music {
  Id id = Isar.autoIncrement;
  String? name;
  String? path;
  String? image;
}
