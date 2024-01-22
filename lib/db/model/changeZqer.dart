  class SibhaResponseModel {
    final List<SibhaHomeItemModel> sibha;

    SibhaResponseModel({required this.sibha});

    factory SibhaResponseModel.fromJson(Map<String, dynamic> json) {
      return SibhaResponseModel(
        sibha: (json['sibha'] as List)
            .map((item) => SibhaHomeItemModel.fromJson(item))
            .toList(),
      );
    }
  }

  class SibhaHomeItemModel {
  final String title;
  final String body;
  final int count;

  SibhaHomeItemModel({
    required this.title,
    required this.body,
    required this.count,
  });

  factory SibhaHomeItemModel.fromJson(Map<String, dynamic> json) {
    return SibhaHomeItemModel(
      title: json['title'],
      body: json['body'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'count': count,
    };
  }
}

  
