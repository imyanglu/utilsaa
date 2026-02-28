import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music/api/service.dart';
import 'package:music/common/models/index.dart';

import 'package:music/common/provider/user_provider.dart';
import 'package:music/common/utils/help.dart';

class Weather extends HookConsumerWidget {
  initUserLocation(WidgetRef ref) async {
    final res = await getLocation();
    if (res.cityCode != null) {
      ref.read(userProvider).update(UserField.cityCode, res.cityCode);
      ref.read(userProvider).update(UserField.district, res.district);
    }
  }

  @override
  Widget build(BuildContext contex, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);

    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // 阴影颜色
            blurRadius: 8, // 模糊程度
            spreadRadius: 2, // 扩散范围
            offset: Offset(0, 4), // x, y 偏移
          ),
        ],
      ),
      child: currentUser?.cityCode != null
          ? Text(currentUser.email ?? '未有效')
          : Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff007ACC),
                ),
                onPressed: initUserLocation,
                child: const Text(
                  style: TextStyle(color: Colors.white),
                  '获取城市信息',
                ),
              ),
            ),
    );
  }
}
