import 'package:flutter/widgets.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  static const String routeURL = '/activity';
  static const String routeName = 'activity';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('activity'),
    );
  }
}
