class UserFadfda {
  final int id;
  final String text;
  final String createdAt;

  UserFadfda({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  factory UserFadfda.fromJson(Map<String, dynamic> json) {
    return UserFadfda(
      id: json['id'],
      text: json['text'],
      createdAt: json['created_at'],
    );
  }
}
