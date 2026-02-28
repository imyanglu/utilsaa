import 'package:flutter/services.dart';
import 'package:music/api/service.dart';
import 'dart:convert';

Future<Map<String, dynamic>> loadCityCode() async {
  final str = await rootBundle.loadString('assets/data/citycode.json');
  return jsonDecode(str);
}

Future<({String? cityCode, String? district})> getLocation() async {
  final district = await getIpLocation();
  final cityCodeMap = await loadCityCode();
  final cityCode = cityCodeMap[district] as String?;

  return (cityCode: cityCode, district: district);
}
