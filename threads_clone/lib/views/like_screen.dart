import 'package:flutter/widgets.dart';

class LikeScreen extends StatelessWidget {
  const LikeScreen({super.key});

  static const String routeURL = '/like';
  static const String routeName = 'like';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('like'),
    );
  }
}
