import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/common/models/user.dart';
import 'package:music/common/utils/storage.dart';

final userProvider = NotifierProvider<UserNotifier, User>(() {
  return UserNotifier();
});

class UserNotifier extends Notifier<User> {
  @override
  User build() {
    // 初始化从本地读取
    print("自动调用");
    final localUser = Storage.getMap('user');
    if (localUser != null) return User.fromJson(localUser);
    return User();
  }

  void update(UserField k, dynamic v) {
    state = state.update(k, v);
    Storage.setMap('user', state.toJson()); // 同步本地
  }
}
