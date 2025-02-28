import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/models/thread_model.dart';
import 'package:threads_clone/util.dart';
import 'package:threads_clone/views/ellipsis_screen.dart';
import 'package:threads_clone/widgets/reply_timeline.dart';
import 'package:threads_clone/widgets/image_carousel.dart';

class Threads extends StatelessWidget {
  final ThreadModel threads;

  const Threads({
    super.key,
    required this.threads,
  });

  void _onEllipsisTap(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => EllipsisScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final random = RandomGenerator(seed: DateTime.now().millisecondsSinceEpoch);
    final userName = threads.author;
    final sentence = threads.comment;
    final since = random.integer(60);
    final replies = random.integer(4);
    final likes = random.integer(1000);
    final repliers = List.generate(replies, (index) => getImage());
    final images = threads.imageUrls;

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: ReplyTimeline(
              replies: replies,
              repliers: repliers,
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Text("${since}m"),
                          Gaps.h12,
                          GestureDetector(
                            onTap: () => _onEllipsisTap(context),
                            child:
                                const Icon(FontAwesomeIcons.ellipsis, size: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  sentence,
                  style: const TextStyle(fontSize: 16),
                ),
                Gaps.v8,
                if (images != null && images.isNotEmpty)
                  ImageCarousel(imageUrls: images),
                Gaps.v12,
                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(FontAwesomeIcons.heart),
                      Icon(FontAwesomeIcons.comment),
                      Icon(FontAwesomeIcons.arrowsRotate),
                      Icon(FontAwesomeIcons.paperPlane),
                    ],
                  ),
                ),
                Gaps.v12,
                Text("$replies replies﹒$likes likes"),
              ],
            ),
          ),
          Gaps.h8,
        ],
      ),
    );
  }
}
