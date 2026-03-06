import 'package:isar/isar.dart';
import 'package:music/common/utils/help.dart';

class LiveWeather {
  final String province; // 省份
  final String city; // 城市
  final String weather; // 天气现象
  final int temperature; // 温度
  final float temperature_float; // 温度
  final String winddirection; // 风向
  final double windpower; // 风力
  final String? humidity; // 湿度
  final String? reporttime; // 数据更新时间

  LiveWeather({
    this.reporttime,
    required this.temperature_float,
    this.humidity,
    required this.windpower,
    required this.province,
    required this.city,
    required this.weather,
    required this.temperature,
    required this.winddirection,
  });
  factory LiveWeather.fromJson(Map<String, dynamic> json) {
    RegExp regExp = RegExp(r'\d+');
    return LiveWeather(
      reporttime: json['reporttime'],
      temperature_float: float.parse(json['temperature_float']),
      humidity: json['humidity'],
      windpower: double.parse(regExp.firstMatch(json['windpower'])?[0] ?? '0'),
      province: json['province'],
      city: json['city'],
      weather: json['weather'],
      temperature: int.parse(json['temperature']),
      winddirection: json['winddirection'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'province': province,
      'city': city,
      'weather': weather,
      'temperature': temperature,
      'temperature_float': temperature_float,
      'winddirection': winddirection,
      'windpower': windpower,
      'humidity': humidity,
      'reporttime': reporttime,
    };
  }
}

class Cast {
  final String week; // 城市
  final String dayweather;
  final String nightweather;
  final String daytemp;
  final String nighttemp;
  final String daywind;
  final String daypower;
  final String nightwind;
  final String nightpower;
  Cast({
    required this.week,
    required this.dayweather,
    required this.nightweather,
    required this.daytemp,
    required this.nighttemp,
    required this.daywind,
    required this.daypower,
    required this.nightwind,
    required this.nightpower,
  });
  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      week: json['week'],
      dayweather: json['dayweather'],
      nightweather: json['nightweather'],
      daytemp: json['daytemp'],
      nighttemp: json['nighttemp'],
      daywind: json['daywind'],
      daypower: json['daypower'],
      nightwind: json['nightwind'],
      nightpower: json['nightpower'],
    );
  }
}

class ForecastWeather {
  final String reporttime; // 城市
  final List<Cast> casts;
  ForecastWeather(this.reporttime, this.casts);
  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    var list = json['casts'] as List? ?? [];
    return ForecastWeather(
      json['reporttime'],
      list.map((i) => Cast.fromJson(i)).toList(),
    );
  }
  Cast getTodayWeather() {
    return casts[0];
  }
}

class GDForecastWeather {
  final String status; //0 失败,1 成功
  final ForecastWeather forecast;
  GDForecastWeather({required this.status, required this.forecast});

  factory GDForecastWeather.fromJson(Map<String, dynamic> json) {
    return GDForecastWeather(
      status: json['status'],
      forecast: ForecastWeather.fromJson(json['forecasts'][0]),
    );
  }
}

class GDWeather {
  final String status; //0 失败,1 成功
  final List<LiveWeather> lives;
  GDWeather({required this.status, required this.lives});

  factory GDWeather.fromJson(Map<String, dynamic> json) {
    var list = json['lives'] as List? ?? [];

    return GDWeather(
      status: json['status'],
      lives: list.map((i) => LiveWeather.fromJson(i)).toList(),
    );
  }
  String getTemperature() {
    if (lives.isEmpty) return '';
    return '${lives[0].temperature_float}°';
  }

  LiveWeather getLiveWeather() {
    return lives[0];
  }

  String getWeather() {
    if (lives.isEmpty) return '';
    return lives[0].weather;
  }

  @override
  String toString() {
    return 'GDWeather{status: $status, 长度 ${lives.length} lives: $lives}';
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'lives': lives.map((e) => e.toJson()).toList()};
  }
}
