import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/views/setting_screen.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  static const String routeURL = '${SettingScreen.routeURL}/privacy';
  static const String routeName = '${SettingScreen.routeName}/privacy';

  @override
  State<PrivacyScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<PrivacyScreen> {
  bool _isPrivateProfile = false;
  void _onPrivateProfileChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _isPrivateProfile = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text('Privacy'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            activeTrackColor: Colors.black,
            title: const Text("Private profile"),
            secondary: const Icon(FontAwesomeIcons.lock),
            value: _isPrivateProfile,
            onChanged: _onPrivateProfileChanged,
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.at),
            title: const Text("Mentions"),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Everyone",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.grey,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: Sizes.size16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.solidBellSlash),
            title: const Text("Muted"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: Sizes.size16,
              color: Colors.grey,
            ),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.eyeSlash),
            title: const Text("Hidden Words"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: Sizes.size16,
              color: Colors.grey,
            ),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.userGroup),
            title: const Text("Profiles you follow"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: Sizes.size16,
              color: Colors.grey,
            ),
          ),
          Divider(),
          ListTile(
            title: const Text("Other privacy settings"),
            subtitle: const Text(
              'Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            trailing: const Icon(
              FontAwesomeIcons.upRightFromSquare,
              size: Sizes.size16,
              color: Colors.grey,
            ),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.circleXmark),
            title: const Text("Blocked profiles"),
            trailing: const Icon(
              FontAwesomeIcons.upRightFromSquare,
              size: Sizes.size16,
              color: Colors.grey,
            ),
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.heartCrack),
            title: const Text("Hide likes"),
            trailing: const Icon(
              FontAwesomeIcons.upRightFromSquare,
              size: Sizes.size16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
