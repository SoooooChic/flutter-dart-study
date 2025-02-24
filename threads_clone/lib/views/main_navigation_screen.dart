import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/views/activity_screen.dart';
import 'package:threads_clone/views/privacy_screen.dart';
import 'package:threads_clone/views/profile_screen.dart';
import 'package:threads_clone/views/search_screen.dart';
import 'package:threads_clone/views/setting_screen.dart';
import 'package:threads_clone/widgets/nav_tab.dart';
import 'package:threads_clone/views/write_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  final Widget child;

  const MainNavigationScreen({super.key, required this.child});

  static const List<String> _routes = [
    '/',
    SearchScreen.routeURL,
    '',
    ActivityScreen.routeURL,
    ProfileScreen.routeURL,
  ];

  void _onTap(BuildContext context, int index) {
    if (_routes[index].isNotEmpty) {
      context.go(_routes[index]);
    }
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final normalizedLocation =
        {SettingScreen.routeURL, PrivacyScreen.routeURL}.contains(location)
            ? ProfileScreen.routeURL
            : location;
    return _routes.indexOf(normalizedLocation).clamp(0, _routes.length - 1);
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
    final selectedIndex = _getSelectedIndex(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: child,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + Sizes.size12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
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
                text: "Search",
                isSelected: selectedIndex == 1,
                icon: FontAwesomeIcons.magnifyingGlass,
                selectedIcon: FontAwesomeIcons.magnifyingGlass,
                onTap: () => _onTap(context, 1),
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
                text: "Activity",
                isSelected: selectedIndex == 3,
                icon: FontAwesomeIcons.heart,
                selectedIcon: FontAwesomeIcons.solidHeart,
                onTap: () => _onTap(context, 3),
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
