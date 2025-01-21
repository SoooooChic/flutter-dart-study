import 'package:flutter/material.dart';
import 'package:onboarding_flow_part1/constants/sizes.dart';
import 'package:onboarding_flow_part1/screen/sign_up_screen.dart';

void main() {
  runApp(const OnboardingFlowPart1());
}

class OnboardingFlowPart1 extends StatelessWidget {
  const OnboardingFlowPart1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OnBoardingFlowPart1',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.blueAccent,
            size: 38,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size20,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const SignUpScreen(),
    );
  }
}
