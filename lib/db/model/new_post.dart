class Post {
  String? id;
  String? text;
  String? userId;
  DateTime? createdAt;

  Post({
    required this.id,
    required this.text,
    required this.userId,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      text: json['text'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
