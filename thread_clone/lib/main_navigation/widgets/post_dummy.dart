import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thread_clone/constants/sizes.dart';
import '../../constants/gaps.dart';

class PostDummy extends StatelessWidget {
  const PostDummy({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = List.generate(20, (index) => Post.fake());

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return PostCard(post: post);
          },
        ),
      ],
    );
  }
}

class Post {
  final String username;
  final String avatarUrl;
  final String content;
  final String timeAgo;
  final int replies;
  final int likes;
  final List<String> imageUrls;
  final List<String> topUsers;

  Post({
    required this.username,
    required this.avatarUrl,
    required this.content,
    required this.timeAgo,
    required this.replies,
    required this.likes,
    this.imageUrls = const [],
    this.topUsers = const [],
  });

  factory Post.fake() {
    final fake = faker.Faker();
    final hasImage = fake.randomGenerator.boolean();
    final imageCount = fake.randomGenerator.integer(5, min: 1);

    return Post(
      username: fake.person.name(),
      avatarUrl:
          "https://i.pravatar.cc/150?img=${fake.randomGenerator.integer(60)}",
      content: fake.lorem.sentences(3).join(" "),
      timeAgo: "${fake.randomGenerator.integer(59)}m",
      replies: fake.randomGenerator.integer(100),
      likes: fake.randomGenerator.integer(1000),
      imageUrls: hasImage
          ? List.generate(
              imageCount,
              (index) =>
                  "https://picsum.photos/seed/${fake.randomGenerator.integer(100)}/500/300")
          : [],
      topUsers: List.generate(
          3,
          (index) =>
              "https://i.pravatar.cc/150?img=${fake.randomGenerator.integer(60)}"),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size16,
        vertical: Sizes.size8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(post.avatarUrl),
                    radius: Sizes.size20,
                  ),
                  Positioned(
                    bottom: -5,
                    right: -10,
                    child: const Icon(
                      Icons.add_circle,
                      color: Colors.grey,
                      size: Sizes.size24,
                    ),
                  ),
                ],
              ),
              Gaps.h10,
              Text(
                post.username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Gaps.h5,
              const Icon(
                Icons.verified,
                color: Colors.blue,
                size: Sizes.size16,
              ),
              const Spacer(),
              Text(post.timeAgo),
              Gaps.h10,
              const FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.white,
                size: Sizes.size16,
              ),
            ],
          ),
          Gaps.v10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: post.imageUrls.isNotEmpty ? 280 : 70,
                child: VerticalDivider(
                  width: 40,
                  thickness: 2,
                  color: Colors.grey,
                ),
              ),
              Gaps.h10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      post.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (post.imageUrls.isNotEmpty) ...[
                      Gaps.v10,
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: post.imageUrls.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: Sizes.size10,
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size10),
                                child: Image.network(
                                  post.imageUrls[index],
                                  fit: BoxFit.cover,
                                  width: 300,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    Gaps.v10,
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size20,
                          color: Colors.grey,
                        ),
                        Gaps.h10,
                        const FaIcon(
                          FontAwesomeIcons.comment,
                          size: Sizes.size20,
                          color: Colors.grey,
                        ),
                        Gaps.h10,
                        const FaIcon(
                          FontAwesomeIcons.retweet,
                          size: Sizes.size20,
                          color: Colors.grey,
                        ),
                        Gaps.h10,
                        const FaIcon(
                          FontAwesomeIcons.paperPlane,
                          size: Sizes.size20,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gaps.v10,
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 30,
                    top: -20,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(post.topUsers[0]),
                      radius: 15,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(post.topUsers[1]),
                    radius: 12,
                  ),
                  Positioned(
                    left: 25,
                    bottom: -10,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(post.topUsers[2]),
                      radius: 10,
                    ),
                  ),
                ],
              ),
              Gaps.h44,
              Text(
                "${post.replies} replies • ${post.likes} likes",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Gaps.v20,
          Divider(
            thickness: 1,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
