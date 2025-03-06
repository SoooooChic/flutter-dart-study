import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_tracker/constants/sizes.dart';
import 'package:mood_tracker/views/write_screen.dart';
import 'package:mood_tracker/widgets/nav_tab.dart';

class MainNavigationScreen extends StatelessWidget {
  final Widget child;

  const MainNavigationScreen({super.key, required this.child});

  void _onTap(BuildContext context, int index) {
    // if (_routes[index].isNotEmpty) {
    // context.go(_routes[index]);
    // }
  }

  void _onWriteTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const WriteScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = 1;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.size20,
            bottom: Sizes.size24,
            left: Sizes.size10,
            right: Sizes.size10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                isSelected: selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(context, 0),
                selectedIndex: selectedIndex,
              ),
              NavTab(
                text: "Write",
                isSelected: false,
                icon: FontAwesomeIcons.penToSquare,
                selectedIcon: FontAwesomeIcons.solidPenToSquare,
                onTap: () => _onWriteTap(context),
                selectedIndex: selectedIndex,
              ),
              NavTab(
                text: "Profile",
                isSelected: selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(context, 4),
                selectedIndex: selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
