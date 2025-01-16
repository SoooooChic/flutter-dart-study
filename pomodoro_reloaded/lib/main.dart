import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home_screen.dart';

/**
 * color
 * 빨간   : e7626c
 * 베이지 : 232b55
 * 흰색  : fffffe
 */ ///
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffe64d3d),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Color(0xfff4a59f),
          ),
          displayLarge: TextStyle(
            color: Colors.white,
          ),
        ),
        cardColor: const Color(0xffF4EDDB),
      ),
      home: const HomeScreen(),
    );
  }
}
