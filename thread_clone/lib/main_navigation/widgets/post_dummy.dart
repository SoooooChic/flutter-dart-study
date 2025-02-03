import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';

import '../../constants/gaps.dart';

class ThreadsHomeScreen extends StatelessWidget {
  const ThreadsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = List.generate(10, (index) => Post.fake());

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(post: post);
      },
    );
  }
}

class Post {
  final String username;
  final String avatarUrl;
  final String content;
  final String timeAgo;
  final List<String> imageUrls; // 여러 개의 이미지 저장

  Post({
    required this.username,
    required this.avatarUrl,
    required this.content,
    required this.timeAgo,
    required this.imageUrls,
  });

  factory Post.fake() {
    final fake = faker.Faker();
    final hasImage = fake.randomGenerator.boolean(); // 50% 확률로 이미지 포함
    final imageCount =
        fake.randomGenerator.integer(5, min: 1); // 최대 5장까지 랜덤 이미지

    return Post(
      username: fake.person.name(),
      avatarUrl:
          "https://i.pravatar.cc/150?img=${fake.randomGenerator.integer(60)}", // 랜덤 아바타 이미지
      content: fake.lorem.sentences(3).join(" "),
      timeAgo: "${fake.randomGenerator.integer(59)}m", // 랜덤 시간
      imageUrls: hasImage
          ? List.generate(
              imageCount,
              (index) =>
                  "https://picsum.photos/seed/${fake.randomGenerator.integer(100)}/500/300")
          : [],
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(post.avatarUrl),
                radius: 20,
              ),
              Gaps.h10,
              Text(
                post.username,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                post.timeAgo,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Gaps.v10,
          Text(
            post.content,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          // 🔹 여러 개의 이미지 슬라이드 (있을 경우만 표시)
          if (post.imageUrls.isNotEmpty) ...[
            Gaps.v10,
            SizedBox(
              height: 200, // 이미지 높이 지정
              child: PageView.builder(
                itemCount: post.imageUrls.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      post.imageUrls[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
              ),
            ),
          ],
          Gaps.v10,
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.favorite_border), onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () {}),
              IconButton(icon: const Icon(Icons.share), onPressed: () {}),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
