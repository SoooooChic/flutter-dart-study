class UserModel {
  final String uid;
  final String userId;
  final String userName;
  final double followers;
  final String? avatarUrl;
  final String? bio;

  UserModel({
    required this.uid,
    required this.userId,
    required this.userName,
    required this.followers,
    this.avatarUrl,
    this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        userId = json['userId'],
        userName = json['userName'],
        followers = json['followers'],
        avatarUrl = json['avatarUrl'],
        bio = json['bio'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userId': userId,
      'userName': userName,
      'followers': followers,
      'avatarUrl': avatarUrl,
      'bio': bio,
    };
  }
}
