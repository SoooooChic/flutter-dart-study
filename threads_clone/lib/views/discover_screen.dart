import 'package:flutter/widgets.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  static const String routeName = 'discover';
  static const String routeURL = '/discover';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('discover'),
    );
  }
}
