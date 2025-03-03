import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/util.dart';
import 'package:threads_clone/views/ellipsis_screen.dart';
import 'package:threads_clone/widgets/reply_timeline.dart';
import 'package:threads_clone/widgets/image_carousel.dart';

class Thread extends StatelessWidget {
  const Thread({
    super.key,
  });

  void _onEllipsisTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => EllipsisScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final faker = Faker();
    final random = RandomGenerator(seed: DateTime.now().millisecondsSinceEpoch);
    final userName = faker.internet.userName();
    final sentence = faker.lorem.sentence();
    final since = random.integer(60);
    final replies = random.integer(4); // 0~3
    final likes = random.integer(1000);
    final hasImage = random.integer(3) != 0;
    final repliers = List.generate(replies, (index) => getImage());
    final images = List.generate(5, (index) => getImage());

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
                if (hasImage) ImageCarousel(imageUrls: images),
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
