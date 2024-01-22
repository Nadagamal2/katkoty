class SibhaItemModel {
  final String title;
  final String body;
  final int count;

  SibhaItemModel({
    required this.title,
    required this.body,
    required this.count,
  });

  factory SibhaItemModel.fromJson(Map<String, dynamic> json) {
    return SibhaItemModel(
      title: json['title'] as String,
      body: json['body'] as String,
      count: json['count'] as int,
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

class SibhaModel {
  final List<SibhaItemModel> sibha;

  SibhaModel({required this.sibha});

  factory SibhaModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> sibhaJson = json['sibha'] as List<dynamic>;
    List<SibhaItemModel> sibhaItems = sibhaJson
        .map((itemJson) =>
            SibhaItemModel.fromJson(itemJson as Map<String, dynamic>))
        .toList();

    return SibhaModel(sibha: sibhaItems);
  }

  Map<String, dynamic> toJson() {
    return {
      'sibha': sibha.map((item) => item.toJson()).toList(),
    };
  }
}
