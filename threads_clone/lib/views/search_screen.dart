import 'package:flutter/widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const String routeName = 'search';
  static const String routeURL = '/search';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('search'),
    );
  }
}
