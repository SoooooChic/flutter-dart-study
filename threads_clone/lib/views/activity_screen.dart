import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/sizes.dart';

final tabs = [
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
  final List<int> followerCounts = List.generate(20, (index) => index * 10);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          // toolbarHeight: 75,
          elevation: 1,
          title: Text(
            'Activity',
            style: TextStyle(
              fontSize: Sizes.size28,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(25), // AppBar 높이 조정
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
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
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
            ListView.separated(
              itemCount: followerCounts.length,
              separatorBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: 70,
                  right: 10,
                ),
                child: Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.users,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: 'User Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: "User Name",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "${followerCounts[index]}K followers",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 4,
                      ),
                      minimumSize: const Size(0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Follow",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
            Center(child: Text("Replies Content")),
            Center(child: Text("Mentions Content")),
            Center(child: Text("Quote Content")),
            Center(child: Text("Request Content")),
            Center(child: Text("Repost Content")),
          ],
        ),
      ),
    );
  }
}
