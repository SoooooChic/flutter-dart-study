class UserModel {
  final String userId;
  final String userName;
  final double followers;
  final String avatarUrl;
  final String followersAvatar;

  UserModel({
    required this.userId,
    required this.userName,
    required this.followers,
    required this.avatarUrl,
    required this.followersAvatar,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : avatarUrl = json['avatarUrl'],
        userId = json['userId'],
        userName = json['userName'],
        followers = json['followers'],
        followersAvatar = json['followersAvatar'];

  Map<String, dynamic> toJson() {
    return {
      'avatarUrl': avatarUrl,
      'userId': userId,
      'userName': userName,
      'followers': followers,
      'followersAvatar': followersAvatar,
    };
  }
}
