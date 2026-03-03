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
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Addresspicker(),
      ),
    );
    // try {
    //   final res = await getLocation();
    //   print(res);
    //   if (res.adCode != null) {
    //     ref.read(userProvider.notifier).update(UserField.address, res.address);
    //     ref.read(userProvider.notifier).update(UserField.adCode, res.adCode);
    //   }
    // } catch (e) {
    //   print("报错$e");
    // }
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
    useEffect(() {
      print(currentUser);
      if (currentUser.adCode == null) return;

      initWeather(ref).then((v) {
        weather.value = v;
        print(weather.value);
      });
    }, [currentUser]);
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
      child: currentUser?.adCode != null
          ? Container(child: Column(children: [Text('未获取到具体城市'), Text('时间')]))
          : Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff007ACC),
                ),
                onPressed: () {
                  initUserLocation(context, ref);
                },
                child: const Text(
                  style: TextStyle(color: Colors.white),
                  '获取城市信息',
                ),
              ),
            ),
    );
  }
}
