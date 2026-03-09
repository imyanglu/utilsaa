import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music/pages/add_music_page.dart';

import 'package:music/pages/home_page.dart';
import 'package:music/pages/plan_creator/plan_creator_page.dart';
import 'package:music/pages/plans_page.dart';

final appRouter = GoRouter(
  initialLocation: "/plans",

  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        // 这里是壳页面的布局
        return Scaffold(
          body: child, // 子路由的内容将会渲染在这里
          bottomNavigationBar: CupertinoTabBar(
            // iOS 风格的底部导航
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: '歌曲',
              ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(path: "/home", builder: (context, state) => HomePage()),
        GoRoute(path: "/plans", builder: (context, state) => PlansPage()),
      ],
    ),
    GoRoute(
      path: '/createPlan',
      builder: (context, state) => PlanCreatorPage(),
    ),
    GoRoute(path: "/add", builder: (context, state) => const AddMusicPage()),
  ],
);
