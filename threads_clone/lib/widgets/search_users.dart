import 'package:flutter/material.dart';
import 'package:threads_clone/constants/sizes.dart';
import 'package:threads_clone/models/user_model.dart';

class SearchUser extends StatelessWidget {
  final UserModel user;

  const SearchUser({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.yellow.shade700,
        radius: 20,
        child: Text(
          user.userName,
          style: TextStyle(fontSize: Sizes.size12),
          textAlign: TextAlign.center,
        ),
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
              CircleAvatar(
                backgroundColor: Colors.orange.shade700,
                radius: 9,
                child: Text(
                  user.userName,
                  style: TextStyle(fontSize: Sizes.size10),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                " ${user.followers}K followers",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.size14,
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
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
