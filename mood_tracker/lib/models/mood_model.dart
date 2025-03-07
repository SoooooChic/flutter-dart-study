class MoodModel {
  final String uid;
  final String feel;
  final String emoji;
  final String comment;
  final int createdDate;
  final int createdAt;

  MoodModel({
    required this.uid,
    required this.feel,
    required this.emoji,
    required this.comment,
    required this.createdDate,
    required this.createdAt,
  });

  MoodModel.fromJson(Map<String, dynamic> json)
    : uid = json['uid'],
      feel = json['feel'],
      emoji = json['emoji'],
      comment = json['comment'],
      createdDate = json['createdDate'],
      createdAt = json['createdAt'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'feel': feel,
      'emoji': emoji,
      'comment': comment,
      'createdDate': createdDate,
      'createdAt': createdAt,
    };
  }
}
