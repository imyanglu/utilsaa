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
  @override
  String toString() {
    return 'GDWeather{status: $status, 长度 ${lives.length} lives: $lives}';
  }

  String getSimpleWeather() {
    if (status == '0') return '获取失败';
    final live = lives.first;
    return " " +
        live.weather +
        ' 风力 ' +
        live.windpower.toString() +
        ' ' +
        getWindPowerEmoj(live.windpower);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'lives': lives.map((e) => e.toJson()).toList()};
  }
}
