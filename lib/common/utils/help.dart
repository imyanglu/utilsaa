import 'package:flutter/services.dart';
import 'package:music/api/service.dart';
import 'dart:convert';

Future<Map<String, dynamic>> loadCityCode() async {
  final str = await rootBundle.loadString('assets/data/adCode.json');
  return jsonDecode(str);
}

String getWindPowerEmoj(double power) {
  if (power < 3) {
    return "🍃";
  } else if (power < 6) {
    return "🌬️";
  } else if (power < 9) {
    return "💨";
  } else if (power < 12) {
    return '🌀';
  }
  return '🌪️';
}

bool isPositiveNumber(String input) {
  // 先尝试解析为数字
  final number = num.tryParse(input);
  // 如果不是数字或者 <= 0，返回 false
  return number != null && number > 0;
}

Future<({String? adCode, List<String>? address})> getLocation() async {
  final address = await getIpLocation();

  var cityCodeMap = await loadCityCode();
  String? adCode = null;
  int idx = 0;
  String? key = address[idx];

  print("省份 ${cityCodeMap.containsKey(key)} 地址 $key");
  while (cityCodeMap.containsKey(key) &&
      cityCodeMap[key].children.length > 0 &&
      key != null) {
    print("地址 $key");
    adCode = cityCodeMap[key].adCode;
    cityCodeMap = cityCodeMap[key].children;
    idx++;
    key = idx < address.length ? address[idx] : null;
  }

  return (adCode: adCode, address: address);
}
