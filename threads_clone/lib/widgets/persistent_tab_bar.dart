import 'package:flutter/material.dart';
import 'package:threads_clone/constants/sizes.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
        // vertical: Sizes.size2,
        horizontal: Sizes.size10,
      ),
      child: const TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.black,
        labelPadding: EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        labelColor: Colors.black,
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
