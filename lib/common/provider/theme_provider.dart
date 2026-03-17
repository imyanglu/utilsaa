import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plan/common/models/app_theme.dart';

import 'package:plan/common/utils/storage.dart';

final AppThemeProvider = StateNotifierProvider<AppThemeNotifier, AppTheme>((
  ref,
) {
  return AppThemeNotifier();
});

class AppThemeNotifier extends StateNotifier<AppTheme> {
  AppThemeNotifier() : super(_initAppTheme());

  static AppTheme _initAppTheme() {
    final map = Storage.getMap('AppTheme');

    if (map != null) {
      return AppTheme.fromJson(map);
    }
    return AppTheme(bgColor: Colors.white);
  }

  void update(AppThemeField field, dynamic value) {
    switch (field) {
      case AppThemeField.bgColor:
        state = state.copyWith(bgColor: value as Color);
        break;
    }
    // 更新 state
    Storage.setMap('AppTheme', state.toJson()); // 同步更新本地存储
  }
}
