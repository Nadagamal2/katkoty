// To parse this JSON data, do
//
//     final getUserpost = getUserpostFromJson(jsonString);

import 'dart:convert';

GetUserpost getUserpostFromJson(String str) => GetUserpost.fromJson(json.decode(str));

String getUserpostToJson(GetUserpost data) => json.encode(data.toJson());

class GetUserpost {
  List<UserPost> userPosts;

  GetUserpost({
    required this.userPosts,
  });

  factory GetUserpost.fromJson(Map<String, dynamic> json) => GetUserpost(
    userPosts: List<UserPost>.from(json["user_posts"].map((x) => UserPost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_posts": List<dynamic>.from(userPosts.map((x) => x.toJson())),
  };
}

class UserPost {
  int id;
  String text;
  DateTime createdAt;

  UserPost({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  factory UserPost.fromJson(Map<String, dynamic> json) => UserPost(
    id: json["id"],
    text: json["text"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "created_at": createdAt.toIso8601String(),
  };
}
