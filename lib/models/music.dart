import 'package:isar/isar.dart';

@collection
class Music {
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的
  String? name;
  String? path;
  String? artist;
  String? avatar;
  String? lyrics;
}
