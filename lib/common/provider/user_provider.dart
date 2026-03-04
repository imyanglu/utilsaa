import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/common/models/user.dart';
import 'package:music/common/utils/storage.dart';

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(_initUser());

  static User _initUser() {
    final map = Storage.getMap('user');

    if (map != null) {
      return User.fromJson(map);
    }
    return User();
  }

  void update(UserField field, dynamic value) {
    state = state.update(field, value); // 更新 state
    Storage.setMap('user', state.toJson()); // 同步更新本地存储
  }
}
