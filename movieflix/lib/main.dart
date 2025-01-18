import 'package:flutter/material.dart';
import 'package:movieflix/screens/home_screen.dart';

//flutter pub add http
//flutter pub add url_launcher

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 화면에 디버그 표시 안함
      //debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
