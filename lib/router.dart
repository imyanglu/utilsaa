import 'package:go_router/go_router.dart';
import 'package:music/pages/add_music_page.dart';

import 'package:music/pages/home_page.dart';

final appRouter = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(path: "/home", builder: (context, state) => HomePage()),
    GoRoute(path: "/add", builder: (context, state) => const AddMusicPage()),
  ],
);
