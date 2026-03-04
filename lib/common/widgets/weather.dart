import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music/api/service.dart';
import 'package:music/common/models/api_response.dart';
import 'package:music/common/models/index.dart';

import 'package:music/common/provider/user_provider.dart';
import 'package:music/common/utils/help.dart';
import 'package:music/common/widgets/addressPicker.dart';

class Weather extends HookConsumerWidget {
  initUserLocation(BuildContext context, WidgetRef ref) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => Container(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Addresspicker(
          onCancel: () {
            Navigator.pop(context);
          },
          onConfirm: (address, adCode) {
            Navigator.pop(context);
            ref.read(userProvider.notifier).update(UserField.address, address);
            ref.read(userProvider.notifier).update(UserField.adCode, adCode);
          },
        ),
      ),
    );
    try {
      final res = await getLocation();
      print(res);
      if (res.adCode != null) {
        ref.read(userProvider.notifier).update(UserField.address, res.address);
        ref.read(userProvider.notifier).update(UserField.adCode, res.adCode);
      }
    } catch (e) {
      print("报错$e");
    }
  }

  Future<GDWeather?> initWeather(WidgetRef ref) async {
    try {
      final currentUser = ref.watch(userProvider);
      final res = await getWeather(currentUser.adCode!);
      return res;
    } catch (e) {
      print("初始化天气出错$e");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = useState<GDWeather?>(null);
    final currentUser = ref.watch(userProvider);
    print(currentUser);
    useEffect(() {
      print(currentUser);
      if (currentUser.adCode == null) return;

      initWeather(ref).then((v) {
        weather.value = v;
      });
    }, [currentUser]);
    return currentUser?.adCode != null
        ? Container(
            child: Row(
              children: [
                Text(
                  currentUser.address?['district'] ??
                      currentUser.address?['city'] ??
                      currentUser.address?['province'] ??
                      '未知',
                ),
                Text(":"),
                Text(
                  weather.value == null
                      ? '天气查询中🔍'
                      : weather.value!.getSimpleWeather(),
                ),
              ],
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff6B9D4F),
              ),
              onPressed: () {
                initUserLocation(context, ref);
              },
              child: const Text(
                style: TextStyle(color: Colors.white),
                '获取城市信息',
              ),
            ),
          );
  }
}
