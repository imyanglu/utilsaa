import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan/pages/add_music_page.dart';

import 'package:plan/pages/home_page.dart';
import 'package:plan/pages/plan_creator/plan_creator_page.dart';
import 'package:plan/pages/plans_page.dart';

final appRouter = GoRouter(
  initialLocation: "/home",

  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        final location = state.uri.toString();
        final currentIndex = location.startsWith('/home') ? 0 : 1;
        // 这里是壳页面的布局
        return Scaffold(
          body: child, // 子路由的内容将会渲染在这里
          bottomNavigationBar: CupertinoTabBar(
            // iOS 风格的底部导航
            currentIndex: currentIndex,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('/home');
                  break;
                case 1:
                default:
                  context.go('/plans');
                  break;
              }
            },
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
