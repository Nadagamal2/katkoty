// To parse this JSON data, do
//
//     final coursesDetails = coursesDetailsFromJson(jsonString);

import 'dart:convert';

CoursesDetails coursesDetailsFromJson(String str) => CoursesDetails.fromJson(json.decode(str));

String coursesDetailsToJson(CoursesDetails data) => json.encode(data.toJson());

class CoursesDetails {
  List<CoursesContent>? coursesContent;

  CoursesDetails({
    this.coursesContent,
  });

  factory CoursesDetails.fromJson(Map<String, dynamic> json) => CoursesDetails(
        coursesContent: json["courses_content"] == null
            ? []
            : List<CoursesContent>.from(json["courses_content"]!.map((x) => CoursesContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "courses_content": coursesContent == null ? [] : List<dynamic>.from(coursesContent!.map((x) => x.toJson())),
      };
}

class CoursesContent {
  int? id;
  String? title;
  String? description;
  String? url;
  String? image;
  int? categorie;
  DateTime? createdAt;

  CoursesContent({
    this.id,
    this.title,
    this.description,
    this.url,
    this.image,
    this.categorie,
    this.createdAt,
  });

  factory CoursesContent.fromJson(Map<String, dynamic> json) => CoursesContent(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        image: json["image"],
        categorie: json["categorie"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "image": image,
        "categorie": categorie,
        "created_at": createdAt?.toIso8601String(),
      };
}
