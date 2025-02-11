import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/views/privacy_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static const String routeURL = '/profile';
  static const String routeName = 'profile';

  void _onTapPrivacy(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PrivacyScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Divider(
            height: 0,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.userPlus),
            title: Text("Follow and invite friends"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.bell),
            title: Text("Notifications"),
          ),
          ListTile(
            onTap: () => _onTapPrivacy(context),
            leading: Icon(FontAwesomeIcons.lock),
            title: Text("Privacy"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.user),
            title: Text("Account"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.lifeRing),
            title: Text("Help"),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.circleInfo),
            title: Text("About"),
          ),
          Divider(
            height: 0,
            thickness: 1,
          ),
          ListTile(
            title: const Text("Log out (iOS)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Plx dont go"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("No"),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (Android)"),
            textColor: Colors.blue,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const FaIcon(FontAwesomeIcons.skull),
                  title: const Text("Are you sure?"),
                  content: const Text("Plx dont go"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
