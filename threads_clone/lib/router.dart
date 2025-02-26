import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/repos/authentication_repo.dart';
import 'package:threads_clone/views/activity_screen.dart';
import 'package:threads_clone/views/home_screen.dart';
import 'package:threads_clone/views/login_screen.dart';
import 'package:threads_clone/views/main_navigation_screen.dart';
import 'package:threads_clone/views/privacy_screen.dart';
import 'package:threads_clone/views/profile_screen.dart';
import 'package:threads_clone/views/search_screen.dart';
import 'package:threads_clone/views/setting_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepoProvider).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != LoginScreen.routeURL) {
          return LoginScreen.routeURL;
        }
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
      ),
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
});
