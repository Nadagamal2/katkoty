import 'package:katkoty/db/model/comments/comment.dart';

class CommentsResponse {
  final int postId;
  final List<Comment> comments;

  CommentsResponse({
    required this.postId,
    required this.comments,
  });

  factory CommentsResponse.fromJson(Map<String, dynamic> json) {
    return CommentsResponse(
      postId: json['post_id'],
      comments: List<Comment>.from(json['comments'].map((x) => Comment.fromJson(x))),
    );
  }
}