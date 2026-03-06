import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:music/api/service.dart';
import 'package:music/common/data/theme.dart';
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

  Future<GDForecastWeather?> initForrcastWeather(String adCode) async {
    try {
      final res = await getForecastWeather(adCode);
      return res;
    } catch (e) {
      print("初始化天气出错$e");
    }
  }

  Future<GDWeather?> initLiveWeather(String adCode) async {
    try {
      final res = await getWeather(adCode);
      return res;
    } catch (e) {
      print("初始化天气出错$e");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = useState<LiveWeather?>(null);
    final forecastWeather = useState<Cast?>(null);
    final currentUser = ref.watch(userProvider);
    print(currentUser);
    useEffect(() {
      print(currentUser);
      if (currentUser.adCode == null) return;

      initLiveWeather(currentUser.adCode!).then((v) {
        weather.value = v?.getLiveWeather();
      });
      initForrcastWeather(currentUser.adCode!).then((v) {
        forecastWeather.value = v?.forecast.casts[0];
      });
    }, [currentUser]);
    return Container(
      child: currentUser?.adCode != null
          ? TimeBasedWeatherCard(
              daytemperature: forecastWeather.value != null
                  ? forecastWeather.value!.daytemp
                  : '',
              nighttemperature: forecastWeather.value != null
                  ? forecastWeather.value!.nighttemp
                  : '',
              weather: weather.value != null ? weather.value!.weather : '',
              temperature: weather.value != null
                  ? (weather.value!.temperature).toString() + '°'
                  : '',
              dayweather: forecastWeather.value != null
                  ? forecastWeather.value!.dayweather
                  : '',
              nightweather: forecastWeather.value != null
                  ? forecastWeather.value!.nightweather
                  : '',
              location:
                  currentUser.address?['district'] ??
                  currentUser.address?['city'] ??
                  currentUser.address?['province'] ??
                  '未知',
              reporttime: weather.value != null
                  ? weather.value!.reporttime!
                  : '',
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
            ),
    );
  }
}
