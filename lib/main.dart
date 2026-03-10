import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music/common/utils/storage.dart';
import 'package:music/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();

  runApp(
    ProviderScope(
      // ⚠️ 必须包裹根组件
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // Material 组件的翻译（如 DatePicker）
        GlobalWidgetsLocalizations.delegate, // 基础组件的文字方向等
        GlobalCupertinoLocalizations.delegate, // Cupertino 组件的翻译（解决你现在的报错）
      ],
      supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')],
      // 3. 强制设置为中文（可选）
      locale: const Locale('zh', 'CN'),
    );
  }
}
