import 'package:flutter/material.dart';

Map<String, Map<String, dynamic>> weatherIconMap = {
  // 晴天系列
  '晴': {'icon': Icons.wb_sunny, 'color': const Color(0xFFF9A26C)},
  '少云': {'icon': Icons.wb_cloudy, 'color': const Color(0xFFF9D76C)},
  '晴间多云': {'icon': Icons.wb_cloudy, 'color': const Color(0xFFF9A26C)},
  '多云': {'icon': Icons.cloud, 'color': const Color(0xFF9E9E9E)},
  '阴': {'icon': Icons.cloud, 'color': const Color(0xFF757575)},

  // 风系列
  '有风': {'icon': Icons.air, 'color': const Color(0xFF64B5F6)},
  '平静': {'icon': Icons.air, 'color': const Color(0xFFB0BEC5)},
  '微风': {'icon': Icons.air, 'color': const Color(0xFF81D4FA)},
  '和风': {'icon': Icons.air, 'color': const Color(0xFF4FC3F7)},
  '清风': {'icon': Icons.air, 'color': const Color(0xFF29B6F6)},
  '强风/劲风': {'icon': Icons.air, 'color': const Color(0xFF039BE5)},
  '疾风': {'icon': Icons.air, 'color': const Color(0xFF0288D1)},
  '大风': {'icon': Icons.air, 'color': const Color(0xFF0277BD)},
  '烈风': {'icon': Icons.air, 'color': const Color(0xFF01579B)},
  '风暴': {'icon': Icons.thunderstorm, 'color': const Color(0xFF37474F)},
  '狂爆风': {'icon': Icons.tornado, 'color': const Color(0xFF263238)},
  '飓风': {'icon': Icons.tornado, 'color': const Color(0xFF1A237E)},
  '热带风暴': {'icon': Icons.thunderstorm, 'color': const Color(0xFF283593)},

  // 霾/雾系列
  '霾': {'icon': Icons.blur_on, 'color': const Color(0xFFB0BEC5)},
  '中度霾': {'icon': Icons.blur_on, 'color': const Color(0xFF9E9E9E)},
  '重度霾': {'icon': Icons.blur_on, 'color': const Color(0xFF757575)},
  '严重霾': {'icon': Icons.blur_on, 'color': const Color(0xFF616161)},
  '雾': {'icon': Icons.blur_on, 'color': const Color(0xFFE0E0E0)},
  '浓雾': {'icon': Icons.blur_on, 'color': const Color(0xFFBDBDBD)},
  '强浓雾': {'icon': Icons.blur_on, 'color': const Color(0xFF9E9E9E)},
  '轻雾': {'icon': Icons.blur_on, 'color': const Color(0xFFF5F5F5)},
  '大雾': {'icon': Icons.blur_on, 'color': const Color(0xFF757575)},
  '特强浓雾': {'icon': Icons.blur_on, 'color': const Color(0xFF616161)},

  // 雨系列
  '阵雨': {'icon': Icons.grain, 'color': const Color(0xFF42A5F5)},
  '雷阵雨': {'icon': Icons.thunderstorm, 'color': const Color(0xFF7E57C2)},
  '雷阵雨并伴有冰雹': {'icon': Icons.thunderstorm, 'color': const Color(0xFF5E35B1)},
  '小雨': {'icon': Icons.grain, 'color': const Color(0xFF90CAF9)},
  '中雨': {'icon': Icons.grain, 'color': const Color(0xFF64B5F6)},
  '大雨': {'icon': Icons.grain, 'color': const Color(0xFF42A5F5)},
  '暴雨': {'icon': Icons.grain, 'color': const Color(0xFF1E88E5)},
  '大暴雨': {'icon': Icons.grain, 'color': const Color(0xFF1565C0)},
  '特大暴雨': {'icon': Icons.grain, 'color': const Color(0xFF0D47A1)},
  '强阵雨': {'icon': Icons.grain, 'color': const Color(0xFF1976D2)},
  '强雷阵雨': {'icon': Icons.thunderstorm, 'color': const Color(0xFF512DA8)},
  '极端降雨': {'icon': Icons.grain, 'color': const Color(0xFF311B92)},
  '毛毛雨/细雨': {'icon': Icons.grain, 'color': const Color(0xFFBBDEFB)},
  '雨': {'icon': Icons.grain, 'color': const Color(0xFF42A5F5)},
  '小雨-中雨': {'icon': Icons.grain, 'color': const Color(0xFF64B5F6)},
  '中雨-大雨': {'icon': Icons.grain, 'color': const Color(0xFF42A5F5)},
  '大雨-暴雨': {'icon': Icons.grain, 'color': const Color(0xFF1E88E5)},
  '暴雨-大暴雨': {'icon': Icons.grain, 'color': const Color(0xFF1565C0)},
  '大暴雨-特大暴雨': {'icon': Icons.grain, 'color': const Color(0xFF0D47A1)},

  // 雨雪混合系列
  '雨雪天气': {'icon': Icons.ac_unit, 'color': const Color(0xFF4FC3F7)},
  '雨夹雪': {'icon': Icons.ac_unit, 'color': const Color(0xFF29B6F6)},
  '阵雨夹雪': {'icon': Icons.ac_unit, 'color': const Color(0xFF03A9F4)},
  '冻雨': {'icon': Icons.ac_unit, 'color': const Color(0xFF039BE5)},

  // 雪系列
  '雪': {'icon': Icons.ac_unit, 'color': const Color(0xFFE0E0E0)},
  '阵雪': {'icon': Icons.ac_unit, 'color': const Color(0xFFF5F5F5)},
  '小雪': {'icon': Icons.ac_unit, 'color': const Color(0xFFFFFFFF)},
  '中雪': {'icon': Icons.ac_unit, 'color': const Color(0xFFE0E0E0)},
  '大雪': {'icon': Icons.ac_unit, 'color': const Color(0xFFBDBDBD)},
  '暴雪': {'icon': Icons.ac_unit, 'color': const Color(0xFF9E9E9E)},
  '小雪-中雪': {'icon': Icons.ac_unit, 'color': const Color(0xFFF5F5F5)},
  '中雪-大雪': {'icon': Icons.ac_unit, 'color': const Color(0xFFE0E0E0)},
  '大雪-暴雪': {'icon': Icons.ac_unit, 'color': const Color(0xFFBDBDBD)},

  // 沙尘系列
  '浮尘': {'icon': Icons.blur_circular, 'color': const Color(0xFFBCAAA4)},
  '扬沙': {'icon': Icons.blur_circular, 'color': const Color(0xFFA1887F)},
  '沙尘暴': {'icon': Icons.blur_circular, 'color': const Color(0xFF8D6E63)},
  '强沙尘暴': {'icon': Icons.blur_circular, 'color': const Color(0xFF795548)},
  '龙卷风': {'icon': Icons.tornado, 'color': const Color(0xFF5D4037)},

  // 温度极端
  '热': {'icon': Icons.whatshot, 'color': const Color(0xFFF44336)},
  '冷': {'icon': Icons.ac_unit, 'color': const Color(0xFF2196F3)},

  // 未知
  '未知': {'icon': Icons.help_outline, 'color': const Color(0xFF9E9E9E)},
};
