import 'dart:ui';

enum AppThemeField { bgColor }

class AppTheme {
  final Color? bgColor;

  AppTheme({this.bgColor});
  AppTheme copyWith({Color? bgColor}) {
    return AppTheme(bgColor: bgColor ?? this.bgColor);
  }

  @override
  String toString() {
    return 'AppTheme{背景色: $bgColor}';
    // 或者更简洁的格式
    // return 'User(name: $name, age: $age)';
  }

  Map<String, dynamic> toJson() => {'bgColor': bgColor?.toString()};

  factory AppTheme.fromJson(Map<String, dynamic> json) {
    return AppTheme(bgColor: json['bgColor']);
  }
}
