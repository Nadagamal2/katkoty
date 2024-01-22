class User {
  final int id;
  final String fullName;
  final String photo;

  User({
    required this.id,
    required this.fullName,
    required this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      photo: json['photo'],
    );
  }
}

class Post {
  final int id;
  final String text;
  final DateTime createdAt;
  final User user;
  final int likecount;
  final int commentsCount; 

  Post({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.user,
    required this.likecount,
    required this.commentsCount, 
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      likecount: json['likes_count'],
      id: json['id'],
      text: json['text'],
      createdAt: DateTime.parse(json['created_at']),
      user: User.fromJson(json['user']),
      commentsCount: json['comments_count'], 
    );
  }
}
