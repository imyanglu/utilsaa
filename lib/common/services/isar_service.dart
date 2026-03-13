import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plan/local/model/plan.dart';

class IsarService {
  static Isar? _instance;

  static Isar get instance {
    return _instance!;
  }

  static Future<void> init() async {
    if (_instance != null) return;
    final dir = await getApplicationDocumentsDirectory();
    _instance = await Isar.open([PlanSchema], directory: dir.path);
  }
}
