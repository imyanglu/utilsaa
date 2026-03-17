import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plan/pages/add_music_page.dart';

import 'package:plan/pages/home/home_page.dart';
import 'package:plan/pages/plan_creator/plan_creator_page.dart';

import 'package:plan/pages/profile/profile_page.dart';

final appRouter = GoRouter(
  initialLocation: "/home",

  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        final location = state.uri.toString();
        final currentIndex = location.startsWith('/home') ? 0 : 1;
        return Scaffold(
          body: child,
          bottomNavigationBar: CupertinoTabBar(
            currentIndex: currentIndex,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('/home');
                  break;
                case 1:
                default:
                  context.go('/profile');
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '抽奖'),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: '我的',
              ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(path: "/home", builder: (context, state) => HomePage()),
        GoRoute(path: "/profile", builder: (context, state) => ProfilePage()),
      ],
    ),
    GoRoute(
      path: '/createPlan',
      builder: (context, state) => PlanCreatorPage(),
    ),
  ],
);
