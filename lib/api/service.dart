import 'package:plan/api/http.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:plan/common/models/api_response.dart';

List<String> extractDistrict(String address) {
  final parts = address.trim().split(RegExp(r'\s*·\s*|\s+'));
  return parts;
}

Future<List<String>> getIpLocation() async {
  final res = await Http.get(
    "https://www.xbgjw.com/ipinfo",
    headers: {'User-Agent': 'Mozilla/5.0'}, // 模拟浏览器
  );
  print(res);
  final document = htmlParser.parse(res);
  final statsElements = document.querySelectorAll('.stats.ads p');
  String address = '';
  double lat = 0;
  double lon = 0;
  for (final el in statsElements) {
    final text = el.text.trim();
    print(text);
    // 解析位置
    if (text.contains('位置信息')) {
      address = text.replaceAll('位置信息：', '').trim();
    }

    // 解析经纬度 "26.15, 119.13"
    if (text.contains('经纬度')) {
      final coords = text
          .replaceAll(RegExp(r'.*经纬度（坐标）：\s*'), '')
          .trim()
          .split(',');
      if (coords.length == 2) {
        lat = double.tryParse(coords[0].trim()) ?? 0;
        lon = double.tryParse(coords[1].trim()) ?? 0;
      }
    }
  }

  return extractDistrict(address);
}

Future<GDWeather> getWeather(String adCode) async {
  final weather = await Http.get(
    "https://restapi.amap.com/v3/weather/weatherInfo",
    params: {'key': "a26fef3858f1cee8c09d24a01f2f79ff", 'city': adCode},
  );
  final we = GDWeather.fromJson(weather);

  return GDWeather.fromJson(weather);
}

Future<GDForecastWeather> getForecastWeather(String adCode) async {
  final weather = await Http.get(
    "https://restapi.amap.com/v3/weather/weatherInfo",
    params: {
      'key': "a26fef3858f1cee8c09d24a01f2f79ff",
      'city': adCode,
      'extensions': 'all',
    },
  );
  final we = GDForecastWeather.fromJson(weather);
  print(we);
  return we;
}
