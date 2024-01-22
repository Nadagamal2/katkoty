class UserLike {
  final int id;
  final String text;
  final String createdAt;

  UserLike({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  factory UserLike.fromJson(Map<String, dynamic> json) {
    return UserLike(
      id: json['id'],
      text: json['text'],
      createdAt: json['created_at'],
    );
  }
}
