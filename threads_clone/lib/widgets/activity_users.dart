import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads_clone/constants/gaps.dart';
import 'package:threads_clone/constants/sizes.dart';

final List<Map<String, dynamic>> avatarAddIcons = [
  {
    'icon': FontAwesomeIcons.threads,
    'background': Colors.green,
  },
  {
    'icon': FontAwesomeIcons.solidHeart,
    'background': Colors.purple,
  },
  {
    'icon': FontAwesomeIcons.solidUser,
    'background': Colors.pink,
  },
  {
    'icon': FontAwesomeIcons.share,
    'background': Colors.blue,
  },
  {
    'icon': FontAwesomeIcons.reply,
    'background': Colors.orange,
  },
  {
    'icon': FontAwesomeIcons.retweet,
    'background': Colors.yellow,
  },
];

class ActivityUsers extends StatelessWidget {
  const ActivityUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final faker = Faker();
    final random = RandomGenerator(seed: DateTime.now().millisecondsSinceEpoch);
    final userId = faker.internet.userName();
    final content = faker.lorem.sentences(3).join(" ");
    final contentBottom = faker.lorem.sentences(3).join(" ");
    final hours = random.integer(24);
    final avatarUrl = 'https://i.pravatar.cc/150?img=${random.integer(60)}';
    final avatarIndex = random.integer(5);

    return ListTile(
      leading: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            foregroundImage: NetworkImage(
              avatarUrl,
            ),
            radius: 20,
          ),
          Positioned(
            bottom: 0,
            right: -5,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: avatarAddIcons[avatarIndex]['background'],
                foregroundColor: Colors.white,
                radius: 8,
                child: Icon(
                  avatarAddIcons[avatarIndex]['icon'],
                  size: 10,
                ),
              ),
            ),
          ),
        ],
      ),
      title: RichText(
        text: TextSpan(
          text: userId,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 13,
          ),
          children: [
            TextSpan(
              text: " ${hours}h",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Sizes.size14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (avatarIndex % 2 == 0) ...[
            Gaps.v5,
            Text(
              contentBottom,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Sizes.size14,
                color: Colors.black,
              ),
              maxLines: 2,
            )
          ],
        ],
      ),
      trailing: avatarIndex == 2
          ? TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
                side: BorderSide(color: Colors.grey),
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
                "Following",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            )
          : null,
    );
  }
}
