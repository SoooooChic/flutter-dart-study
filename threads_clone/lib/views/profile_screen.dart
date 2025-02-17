import 'package:faker/faker.dart' as fake;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/util.dart';
import 'package:threads_clone/widgets/persistent_tab_bar.dart';
import 'package:threads_clone/widgets/thread.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeURL = '/profile';
  static const String routeName = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final faker = fake.Faker();
  List<String> avatarUrls = [];

  @override
  void initState() {
    super.initState();
    avatarUrls = List.generate(
      10,
      (index) =>
          'https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(70, min: 1)}',
    );
  }

  void _onGearPressed(BuildContext context) {
    context.pushNamed('setting');
    // context.push('/setting');
    //context.push('/setting');
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const SettingScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.language,
                  size: Sizes.size20,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.instagram,
                    size: Sizes.size24,
                  ),
                ),
                IconButton(
                  onPressed: () => _onGearPressed(context),
                  icon: const Icon(
                    Icons.menu,
                    size: Sizes.size20,
                  ),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                color: isDark ? Colors.black : Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.size18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jane',
                                style: TextStyle(
                                  fontSize: Sizes.size18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gaps.v5,
                              Text('jane_mobbin threads.net'),
                            ],
                          ),
                          CircleAvatar(
                            radius: 30,
                            foregroundImage: NetworkImage(avatarUrls[0]),
                          ),
                        ],
                      ),
                      Gaps.v5,
                      Text('Plant enthusiast!'),
                      Gaps.v10,
                      Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                foregroundImage: NetworkImage(avatarUrls[1]),
                                radius: 9,
                              ),
                              Positioned(
                                right: -15,
                                child: CircleAvatar(
                                  foregroundImage: NetworkImage(avatarUrls[2]),
                                  radius: 9,
                                ),
                              ),
                            ],
                          ),
                          Gaps.h24,
                          Text(
                            '2 followers',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v14,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Edit profile",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Share profile",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.v10,
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: PersistentTabBar(),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: const [
                      Thread(),
                      Gaps.v16,
                      Divider(
                        height: 0,
                        thickness: 1,
                      ),
                      Gaps.v16,
                    ],
                  );
                },
              ),
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: const [
                      Thread(),
                      Gaps.v16,
                      Divider(
                        height: 0,
                        thickness: 1,
                      ),
                      Gaps.v16,
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
