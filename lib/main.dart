import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plan/common/services/isar_service.dart';
import 'package:plan/common/utils/storage.dart';
import 'package:plan/local/model/plan.dart';
import 'package:plan/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  await IsarService.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: child,
        );
      },
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
