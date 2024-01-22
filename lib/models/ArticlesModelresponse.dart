import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/db/models/database_model.dart';

class ArticlesModelResponse {
  List<Article>? article = [];

  ArticlesModelResponse({this.article});

  ArticlesModelResponse.fromJson(Map<String, dynamic> json) {
    if (json['article'] != null) {
      article = <Article>[];
      json['article'].forEach((v) {
        article!.add(new Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.article != null) {
      data['article'] = this.article!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Article implements DatabaseModel {
  int? id;
  String? title;
  String? body;
  String? createdAt;

  Article({this.id, this.title, this.body, this.createdAt});

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    return data;
  }

  @override
  String? database() {
    return AppDatabase.DATABASE_NAME;
  }

  @override
  int? getId() {
    return id;
  }

  @override
  String? table() {
    return AppDatabase.ARTICLES_TABLE;
  }

  @override
  Map<String, dynamic>? toMap() {
    return toJson();
  }
}
