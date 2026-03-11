import 'package:music/common/models/plan_creator.dart';

class PlanService {
 Future<void> savePlan(PlanCreator plan) async {
    // 1. 数据校验
    if (plan.name.text.isEmpty) throw Exception("名称不能为空");

    // 2. 数据转换 (把 PlanCreator 转为数据库模型)
    // final data = plan.toDbMap();

    // // 3. 执行数据库操作
    // await db.insert('plans', data);
  }
}
