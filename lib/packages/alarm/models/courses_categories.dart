// To parse this JSON data, do
//
//     final coursesCategories = coursesCategoriesFromJson(jsonString);

import 'dart:convert';

CoursesCategories coursesCategoriesFromJson(String str) => CoursesCategories.fromJson(json.decode(str));

String coursesCategoriesToJson(CoursesCategories data) => json.encode(data.toJson());

class CoursesCategories {
  List<CoursesCategory>? coursesCategories;

  CoursesCategories({
    this.coursesCategories,
  });

  factory CoursesCategories.fromJson(Map<String, dynamic> json) => CoursesCategories(
        coursesCategories: json["courses_categories"] == null
            ? []
            : List<CoursesCategory>.from(json["courses_categories"]!.map((x) => CoursesCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "courses_categories":
            coursesCategories == null ? [] : List<dynamic>.from(coursesCategories!.map((x) => x.toJson())),
      };
}

class CoursesCategory {
  int? id;
  String? title;
  String? description;
  int? categorie;
  String? image;
  DateTime? createdAt;

  CoursesCategory({
    this.id,
    this.title,
    this.description,
    this.categorie,
    this.image,
    this.createdAt,
  });

  factory CoursesCategory.fromJson(Map<String, dynamic> json) => CoursesCategory(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        categorie: json["categorie"],
        image: json["image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "categorie": categorie,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
      };
}
