import 'package:music/api/http.dart';
import 'package:html/parser.dart' as htmlParser;

String extractDistrict(String address) {
  final parts = address.trim().split(RegExp(r'\s*·\s*|\s+'));
  return parts.last; // 闽侯县
}

Future<String> getIpLocation() async {
  final res = await Http.get(
    "https://www.xbgjw.com/ipinfo",
    headers: {'User-Agent': 'Mozilla/5.0'}, // 模拟浏览器
  );

  final document = htmlParser.parse(res);
  final statsElements = document.querySelectorAll('.stats.ads p');
  String address = '';
  double lat = 0;
  double lon = 0;
  for (final el in statsElements) {
    final text = el.text.trim();

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
