import 'package:flutter/widgets.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({super.key});

  static const String routeURL = '/write';
  static const String routeName = 'write';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('write'),
    );
  }
}
