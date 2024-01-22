// To parse this JSON data, do
//
//     final getUserlike = getUserlikeFromJson(jsonString);

import 'dart:convert';

GetUserlike getUserlikeFromJson(String str) => GetUserlike.fromJson(json.decode(str));

String getUserlikeToJson(GetUserlike data) => json.encode(data.toJson());

class GetUserlike {
  List<UserLike> userLike;

  GetUserlike({
    required this.userLike,
  });

  factory GetUserlike.fromJson(Map<String, dynamic> json) => GetUserlike(
    userLike: List<UserLike>.from(json["user_like"].map((x) => UserLike.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_like": List<dynamic>.from(userLike.map((x) => x.toJson())),
  };
}

class UserLike {
  int id;
  int text;
  DateTime createdAt;

  UserLike({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  factory UserLike.fromJson(Map<String, dynamic> json) => UserLike(
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
