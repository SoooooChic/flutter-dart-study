import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/views/home_screen.dart';
import 'package:mood_tracker/views/login_screen.dart';
import 'package:mood_tracker/views/main_navigation_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/',
    // redirect: (context, state) {
    //   final isLoggedIn = ref.read(authRepoProvider).isLoggedIn;
    //   if (!isLoggedIn) {
    //     if (state.matchedLocation != LoginScreen.routeURL) {
    //       return LoginScreen.routeURL;
    //     }
    //   }
    //   return null;
    // },
    routes: <RouteBase>[
      GoRoute(
        path: LoginScreen.routeURL,
        builder: (context, state) => LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigationScreen(child: child);
        },
        routes: <RouteBase>[
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          // GoRoute(
          //   path: ProfileScreen.routeURL,
          //   builder: (context, state) => const ProfileScreen(),
          // ),
          // GoRoute(
          //   path: SettingScreen.routeURL,
          //   name: SettingScreen.routeName,
          //   builder: (context, state) => const SettingScreen(),
          // ),
        ],
      ),
    ],
  );
});
