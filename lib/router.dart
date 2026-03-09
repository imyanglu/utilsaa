import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music/pages/add_music_page.dart';

import 'package:music/pages/home_page.dart';
import 'package:music/pages/plans_page.dart';

final appRouter = GoRouter(
  initialLocation: "/home",

  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        // 这里是壳页面的布局
        return Scaffold(
          appBar: AppBar(title: Text('App Shell')),
          body: child, // 子路由的内容将会渲染在这里
          bottomNavigationBar: Text("hellop"),
        );
      },
      routes: [
        GoRoute(path: "/home", builder: (context, state) => HomePage()),
        GoRoute(path: "/plans", builder: (context, state) => PlansPage()),
      ],
    ),

    GoRoute(path: "/add", builder: (context, state) => const AddMusicPage()),
  ],
);
