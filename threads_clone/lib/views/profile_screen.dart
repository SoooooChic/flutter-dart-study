import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeURL = '/profile';
  static const String routeName = 'profile';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('profile'),
    );
  }
}
