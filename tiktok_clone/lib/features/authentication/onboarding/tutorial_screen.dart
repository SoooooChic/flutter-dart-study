import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

enum Direction { right, left }

enum Page { first, sceond }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showinPage = Page.first;
  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _direction = Direction.right;
      });
    } else {
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _showinPage = Page.sceond;
      });
    } else {
      setState(() {
        _showinPage = Page.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size24,
            ),
            child: AnimatedCrossFade(
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.v80,
                  Text(
                    'Watch cool videos!',
                    style: TextStyle(
                      fontSize: Sizes.size36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    'Videos are personalized for you based on what you watch, like and share.',
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.v80,
                  Text(
                    'Follow the rules',
                    style: TextStyle(
                      fontSize: Sizes.size36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    'Take care of one another! Plis!',
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              crossFadeState: _showinPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 300),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Padding(
              padding: EdgeInsets.symmetric(
                // vertical: Sizes.size12,
                horizontal: Sizes.size24,
              ),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: _showinPage == Page.first ? 0 : 1,
                child: CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {},
                  child: Text('Enter ther app!'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //     length: 3,
  //     child: Scaffold(
  //       body: SafeArea(
  //         child: TabBarView(
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: Sizes.size24,
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Gaps.v52,
  //                   Text(
  //                     'Watch cool videos!',
  //                     style: TextStyle(
  //                       fontSize: Sizes.size36,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   Gaps.v16,
  //                   Text(
  //                     'Videos are personalized for you based on what you watch, like and share.',
  //                     style: TextStyle(
  //                       fontSize: Sizes.size20,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: Sizes.size24,
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Gaps.v52,
  //                   Text(
  //                     'Follow the rules!',
  //                     style: TextStyle(
  //                       fontSize: Sizes.size36,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   Gaps.v16,
  //                   Text(
  //                     'Videos are personalized for you based on what you watch, like and share.',
  //                     style: TextStyle(
  //                       fontSize: Sizes.size20,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(
  //                 horizontal: Sizes.size24,
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Gaps.v52,
  //                   Text(
  //                     'Enjoy the Ride',
  //                     style: TextStyle(
  //                       fontSize: Sizes.size36,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   Gaps.v16,
  //                   Text(
  //                     'Videos are personalized for you based on what you watch, like and share.',
  //                     style: TextStyle(
  //                       fontSize: Sizes.size20,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       bottomNavigationBar: BottomAppBar(
  //         child: Container(
  //           padding: EdgeInsets.symmetric(
  //             vertical: Sizes.size16,
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               TabPageSelector(
  //                 color: Colors.white,
  //                 selectedColor: Colors.black38,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
// }
