import 'package:flutter/material.dart';
import 'main_navigation/main_navigation_screen.dart';

void main() {
  runApp(const ThreadApp());
}

class ThreadApp extends StatelessWidget {
  const ThreadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thread Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          elevation: 0,
          // titleTextStyle: TextStyle(
          //   color: Colors.black,
          //   fontSize: Sizes.size16 + Sizes.size2,
          //   fontWeight: FontWeight.w600,
          // ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // 기본 본문 글자색 흰색
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white), // 제목 스타일도 흰색
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
        ),
      ),
      home: MainNavigationScreen(),
    );
  }
}
