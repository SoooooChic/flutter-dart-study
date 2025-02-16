import 'package:flutter/material.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/util.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = isDarkMode(context);

    return ColoredBox(
      color: isDark ? Colors.black : Colors.white,
      child: Container(
        // color: Colors.white,
        // color: isDark ? Colors.black : Colors.white,
        margin: EdgeInsets.symmetric(
          // vertical: Sizes.size2,
          horizontal: Sizes.size10,
        ),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          // indicatorColor: Colors.black,
          indicatorColor: isDark ? Colors.white : Colors.black,
          labelPadding: EdgeInsets.symmetric(
            vertical: Sizes.size10,
          ),
          // labelColor: Colors.black,
          labelColor: isDark ? Colors.white : Colors.black,
          splashFactory: NoSplash.splashFactory,
          tabs: [
            Text(
              'Threads',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Replies',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 43;

  @override
  double get minExtent => 43;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
