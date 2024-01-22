class UserComments {
  final int id;
  final String fullName;
  final String photo;

  UserComments({required this.id, required this.fullName, required this.photo});

  factory UserComments.fromJson(Map<String, dynamic> json) {
    return UserComments(
      id: json['id'],
      fullName: json['full_name'],
      photo: json['photo'],
    );
  }
}


class Comment {
  final int commentId;
  final String commentText;
  final UserComments userComments;
  final String createdAt;

  Comment({required this.commentId, required this.commentText, required this.userComments, required this.createdAt});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['comment_id'],
      commentText: json['comment_text'],
      userComments: UserComments.fromJson(json['user']),
      createdAt: json['created_at'],
    );
  }
}