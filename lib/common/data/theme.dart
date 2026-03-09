import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:music/common/data/weather_icons.dart';

// 渐变方向：从上到下，模拟天空从深蓝到暖橙的过渡
const morningGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF1B3B4F), // 深蓝紫色 - 夜空残留
    Color(0xFF6B8C9F), // 灰蓝色 - 黎明薄雾
    Color(0xFFE6B89C), // 暖杏色 - 初升阳光
    Color(0xFFFAD5B5), // 淡橘色 - 地平线光芒
  ],
  stops: [0.0, 0.3, 0.7, 1.0],
);

// 清晨卡片背景
const morningCardBg = Color(0xFFE8D3C5); // 柔和的米杏色
const morningTextColor = Color(0xFF1E3B4A);
const morningAccent = Color(0xFFF9A26C); // 温暖的橙色

const morningLateGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF87CEEB), // 天空蓝
    Color(0xFFB0E0E6), // 粉蓝
    Color(0xFFFFF8E7), // 暖白
  ],
);

const morningLateBg = Color(0xFFF0F7FA); // 清新的淡蓝白
const morningLateText = Color(0xFF2C4E5E);
const morningLateAccent = Color(0xFFFFB347); // 鲜亮的橘黄

const noonGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF64B5F6), // 湛蓝
    Color(0xFF90CAF9), // 浅蓝
    Color(0xFFFFF9C4), // 淡黄
  ],
);

const noonBg = Color(0xFFFFF2D9); // 奶油黄
const noonText = Color(0xFF2C5530); // 深绿色（减少刺眼感）
const noonAccent = Color(0xFFFF8C42); // 活力的橙色

const afternoonGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF9BB7D4), // 灰蓝
    Color(0xFFFBE9D2), // 米黄
    Color(0xFFFFDAB9), // 桃色
  ],
);

const afternoonBg = Color(0xFFFCE5CD); // 暖杏色
const afternoonText = Color(0xFF3E5C4B);
const afternoonAccent = Color(0xFFE67E22); // 温暖橘

const duskGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF4A6FA5), // 深蓝紫
    Color(0xFFC05746), // 砖红
    Color(0xFFF9B572), // 橙黄
    Color(0xFFFEE3B8), // 浅杏
  ],
  stops: [0.0, 0.3, 0.7, 1.0],
);

const duskBg = Color(0xFFF7D6B3); // 暖杏粉
const duskText = Color(0xFF3B2E2A);
const duskAccent = Color(0xFFD94F3E); // 落日红

const nightGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF0B1A30), // 深靛蓝
    Color(0xFF1B2F44), // 午夜蓝
    Color(0xFF2C4059), // 灰蓝
  ],
);

const nightBg = Color(0xFF1E2F40); // 深蓝灰
const nightText = Color(0xFFF0E9D8); // 暖白（重要：夜晚文字用浅色）
const nightAccent = Color(0xFFF9D77E); // 月光黄

const midnightGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF030B17), // 近黑深蓝
    Color(0xFF142436), // 深靛蓝
    Color(0xFF1D3147), // 暗夜蓝
  ],
);

const midnightBg = Color(0xFF0A1926); // 深海军蓝
const midnightText = Color(0xFFD8D0B0); // 柔和米白
const midnightAccent = Color(0xFFF9E076); // 星芒黄

class TimeBasedWeatherCard extends HookWidget {
  final String weather;
  final String temperature;
  final String location;
  final String reporttime;
  final String? dayweather;
  final String? nightweather;
  final String? daytemperature;
  final String? nighttemperature;

  // 枚举类型，表示时间段
  // final TimePeriod period.value!; // 自定义枚举

  const TimeBasedWeatherCard({
    Key? key,
    required this.weather,
    required this.temperature,
    required this.location,
    required this.reporttime,
    this.daytemperature,
    this.dayweather,
    this.nighttemperature,
    this.nightweather,
  }) : super(key: key);

  _getPeriodByHour(int hour) {
    return TimePeriod.noon;
    // if (hour >= 4 && hour < 9) {
    //   return TimePeriod.morning;
    // } else if (hour >= 9 && hour < 14) {
    //   return TimePeriod.noon;
    // } else if (hour >= 14 && hour < 17) {
    //   return TimePeriod.afternoon;
    // } else if (hour >= 17 && hour < 19) {
    //   return TimePeriod.dusk;
    // } else if (hour >= 19 && hour < 22) {
    //   return TimePeriod.night;
    // } else {
    //   return TimePeriod.midnight;
    // }
  }

  _initPeriod() {
    DateTime now = DateTime.now();
    final hour = now.hour;
    return _getPeriodByHour(hour);
  }

  @override
  Widget build(BuildContext context) {
    final period = useState<TimePeriod?>(null);
    useEffect(() {
      period.value = _initPeriod();
    }, []);
    double screenWidth = MediaQuery.of(context).size.width;
    if (period.value == null)
      return Container(width: screenWidth - 24, height: 190, child: Text("xx"));

    return Container(
      height: 175,
      width: screenWidth - 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: _getGradient(period.value!),
        boxShadow: [
          BoxShadow(
            color: _getShadowColor(period.value!),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 时间段图标
              Row(
                children: [
                  Icon(
                    weatherIconMap[weather]?['icon'],
                    color: weatherIconMap[weather]?['color'],
                    size: 40,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 2,
                          bottom: 2,
                        ),
                        width: 70,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${daytemperature ?? ''}°${dayweather ?? ''}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),

                      Container(
                        width: 70,
                        padding: EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 2,
                          bottom: 2,
                        ),
                        decoration: BoxDecoration(
                          // color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${nighttemperature ?? ''}°${nightweather ?? ''}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  Text(
                    temperature,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w600,
                      color: _getTextColor(period.value!),
                      shadows: period.value! == TimePeriod.midnight
                          ? [
                              Shadow(
                                color: Colors.white.withOpacity(0.1),
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                  ),
                  SizedBox(width: 4),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _getAccentColor(period.value!).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _getAccentColor(
                            period.value!,
                          ).withOpacity(0.3),
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        weather,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: _getTextColor(period.value!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              // 地点和天气
              Text(
                location,
                style: TextStyle(
                  fontSize: 11,
                  color: _getTextColor(period.value!).withOpacity(0.8),
                ),
              ),
              // 时间段文字
              Text(
                '时间:$reporttime',
                style: TextStyle(
                  fontSize: 9,
                  color: _getTextColor(period.value!).withOpacity(0.6),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // Positioned(
    //   top: 10,
    //   right: 16,
    //   child: GestureDetector(
    //     child: Icon(Icons.refresh, color: Colors.white, size: 16),
    //   ),
    // ),
  }

  LinearGradient _getGradient(TimePeriod period) {
    switch (period) {
      case TimePeriod.morning:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1B3B4F),
            Color(0xFF6B8C9F),
            Color(0xFFE6B89C),
            Color(0xFFFAD5B5),
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        );
      case TimePeriod.noon:
        return const LinearGradient(
          colors: [Color(0xFF64B5F6), Color(0xFFFFF9C4)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case TimePeriod.afternoon:
        return const LinearGradient(
          colors: [Color(0xFF9BB7D4), Color(0xFFFFDAB9)],
        );
      case TimePeriod.dusk:
        return const LinearGradient(
          colors: [Color(0xFF4A6FA5), Color(0xFFF9B572), Color(0xFFFEE3B8)],
        );
      case TimePeriod.night:
        return const LinearGradient(
          colors: [Color(0xFF0B1A30), Color(0xFF2C4059)],
        );
      case TimePeriod.midnight:
        return const LinearGradient(
          colors: [Color(0xFF030B17), Color(0xFF1D3147)],
        );
    }
  }

  Color _getTextColor(TimePeriod period) {
    switch (period) {
      case TimePeriod.night:
      case TimePeriod.midnight:
        return const Color(0xFFF0E9D8); // 暖白
      default:
        return const Color(0xFF1F3B4A); // 深蓝灰
    }
  }

  Color _getAccentColor(TimePeriod period) {
    switch (period) {
      case TimePeriod.morning:
        return const Color(0xFFF9A26C);
      case TimePeriod.noon:
        return const Color(0xFFFF8C42);
      case TimePeriod.afternoon:
        return const Color(0xFFE67E22);
      case TimePeriod.dusk:
        return const Color(0xFFD94F3E);
      case TimePeriod.night:
        return const Color(0xFFF9D77E);
      case TimePeriod.midnight:
        return const Color(0xFFF9E076);
    }
  }

  Color _getShadowColor(TimePeriod period) {
    switch (period) {
      case TimePeriod.night:
      case TimePeriod.midnight:
        return Colors.blue.withOpacity(0.3);
      default:
        return Colors.orange.withOpacity(0.2);
    }
  }

  IconData _getTimeIcon(TimePeriod period) {
    switch (period) {
      case TimePeriod.morning:
        return Icons.wb_twilight;
      case TimePeriod.noon:
        return Icons.wb_sunny;
      case TimePeriod.afternoon:
        return Icons.wb_cloudy;
      case TimePeriod.dusk:
        return Icons.nights_stay;
      case TimePeriod.night:
        return Icons.nightlight_round;
      case TimePeriod.midnight:
        return Icons.dark_mode;
    }
  }
}

enum TimePeriod {
  morning, // 清晨
  noon, // 中午
  afternoon, // 下午
  dusk, // 黄昏
  night, // 夜晚
  midnight, // 深夜
}
