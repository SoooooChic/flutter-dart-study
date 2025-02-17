import 'package:go_router/go_router.dart';
import 'package:threads_clone/views/activity_screen.dart';
import 'package:threads_clone/views/home_screen.dart';
import 'package:threads_clone/views/main_navigation_screen.dart';
import 'package:threads_clone/views/privacy_screen.dart';
import 'package:threads_clone/views/profile_screen.dart';
import 'package:threads_clone/views/search_screen.dart';
import 'package:threads_clone/views/setting_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return MainNavigationScreen(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: SearchScreen.routeURL,
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: ActivityScreen.routeURL,
          builder: (context, state) => const ActivityScreen(),
        ),
        GoRoute(
          path: ProfileScreen.routeURL,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: SettingScreen.routeURL,
          name: SettingScreen.routeName,
          builder: (context, state) => const SettingScreen(),
        ),
        GoRoute(
          path: PrivacyScreen.routeURL,
          name: PrivacyScreen.routeName,
          builder: (context, state) => const PrivacyScreen(),
        ),
      ],
    ),
  ],
);
