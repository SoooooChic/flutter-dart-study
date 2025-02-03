import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class ThreadsHomeScreen extends StatelessWidget {
  const ThreadsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = List.generate(10, (index) => Post.fake());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Threads Clone"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostCard(post: post);
        },
      ),
    );
  }
}

class Post {
  final String username;
  final String avatarUrl;
  final String content;
  final String timeAgo;

  Post({
    required this.username,
    required this.avatarUrl,
    required this.content,
    required this.timeAgo,
  });

  factory Post.fake() {
    final faker = Faker();
    return Post(
      username: faker.person.name(),
      avatarUrl:
          "https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(60)}", // 랜덤 아바타 이미지
      content: faker.lorem.sentences(3).join(" "),
      timeAgo: "${faker.randomGenerator.integer(59)}m", // 랜덤 시간
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
              const SizedBox(width: 10),
              Text(
                post.username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(post.timeAgo, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 8),
          Text(post.content),
          const SizedBox(height: 10),
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
