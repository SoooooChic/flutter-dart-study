import 'package:flutter/material.dart';
import 'package:animations_code_challenge/screens/assignment28_implicit_animations.dart';
import 'package:animations_code_challenge/screens/assignment29_explicit_animations.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Animations')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const Assignment28ImplicitAnimations());
              },
              child: const Text('Assignment28 Implicit Animations'),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const Assignment29ExplicitAnimations());
              },
              child: const Text('Assignment29 Explicit Animations'),
            ),
          ],
        ),
      ),
    );
  }
}
