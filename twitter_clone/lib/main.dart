import 'package:flutter/material.dart';
import 'screen/confirm_code_screen.dart';

void main() {
  runApp(const TwitterClone());
}

class TwitterClone extends StatelessWidget {
  const TwitterClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter-Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          // centerTitle: true,
          // iconTheme: IconThemeData(
          //   color: Colors.blueAccent,
          //   size: 38,
          // ),
          // titleTextStyle: TextStyle(
          //   color: Colors.black,
          //   fontSize: Sizes.size20,
          //   fontWeight: FontWeight.w600,
          // ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      // Assignment 11
      // home: const SignUpScreen(),
      // Assignment 12 ConfirmCodeScreen / PasswordScreen / InterestsScreen / InterestsPartTwoScreen
      home: const ConfirmCodeScreen(),
    );
  }
}
