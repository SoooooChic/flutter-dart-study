import 'package:flutter/material.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/model/user_model.dart';
import 'package:threads_clone/util.dart';

class SearchUser extends StatelessWidget {
  final UserModel user;

  const SearchUser({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return ListTile(
      leading: CircleAvatar(
        foregroundImage: NetworkImage(user.avatarUrl),
        radius: 20,
      ),
      title: Row(
        children: [
          Text(
            user.userId,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 5),
          const Icon(
            Icons.verified,
            color: Colors.blue,
            size: Sizes.size16,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.userName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              if (user.followersAvatar.isNotEmpty)
                CircleAvatar(
                  foregroundImage: NetworkImage(user.followersAvatar),
                  radius: 9,
                ),
              Text(
                " ${user.followers}K followers",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.size14,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.grey),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 4,
          ),
          minimumSize: const Size(0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          "Follow",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
