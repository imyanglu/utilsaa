import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plan/common/models/user.dart';
import 'package:plan/common/utils/storage.dart';

({User user, VoidCallback init, Function(UserField, dynamic) updateUser})
useUser() {
  final user = useState(User());
  final isLoaded = useState(false);
  void initUser() {
    final localUser = Storage.getMap("user");
    if (localUser != null) {
      user.value = User.fromJson(localUser);
    }
    isLoaded.value = true;
  }

  updateUser(UserField k, dynamic v) {
    user.value = user.value.update(k, v);
    Storage.setMap("user", user.value.toJson());
  }

  return (user: user.value, init: initUser, updateUser: updateUser);
}
