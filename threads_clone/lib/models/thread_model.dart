class ThreadModel {
  final String author;
  final String comment;
  final List<String>? imageUrls;
  final int createdAt;

  ThreadModel({
    required this.author,
    required this.comment,
    this.imageUrls,
    required this.createdAt,
  });

  ThreadModel.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        comment = json['comment'],
        imageUrls = json['imageUrls'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'comment': comment,
      'imageUrls': imageUrls,
      'createdAt': createdAt,
    };
  }
}
