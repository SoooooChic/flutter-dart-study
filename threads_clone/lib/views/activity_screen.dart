import 'package:flutter/material.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/widgets/activity_users.dart';

final List<String> tabs = [
  "All",
  "Replies",
  "Mentions",
  "Quote",
  "Request",
  "Repost",
];

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  static const String routeURL = '/activity';
  static const String routeName = 'activity';

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  Widget _buildListView(int usersCount) {
    return ListView.separated(
      itemCount: usersCount,
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(left: 70, right: 10),
        child: Divider(height: 0, thickness: 1),
      ),
      itemBuilder: (context, index) {
        return const ActivityUsers();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: false,
          title: Text(
            'Activity',
            style: TextStyle(
              fontSize: Sizes.size28,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(25),
            child: SizedBox(
              height: 40,
              child: TabBar(
                isScrollable: true,
                splashFactory: NoSplash.splashFactory,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Sizes.size14,
                ),
                indicatorPadding: EdgeInsets.zero,
                padding: EdgeInsets.only(
                  left: 15,
                  bottom: 10,
                ),
                tabAlignment: TabAlignment.center,
                indicator: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
                labelColor: Theme.of(context).colorScheme.secondary,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelPadding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                tabs: [
                  for (var tab in tabs) Tab(text: tab),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildListView(20),
            _buildListView(5),
            _buildListView(6),
            _buildListView(7),
            _buildListView(3),
            _buildListView(1),
          ],
        ),
      ),
    );
  }
}
