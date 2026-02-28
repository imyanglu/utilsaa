import 'package:flutter/material.dart';
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
    return MaterialApp.router(routerConfig: appRouter);
  }
}
