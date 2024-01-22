class QoutesModelresponse {
  List<Quotes>? quotes;

  QoutesModelresponse({this.quotes});

  QoutesModelresponse.fromJson(Map<String, dynamic> json) {
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((v) {
        quotes!.add(new Quotes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quotes != null) {
      data['quotes'] = this.quotes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quotes {
  int? id;
  String? text;
  String? createdAt;

  Quotes({this.id, this.text, this.createdAt});

  Quotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    return data;
  }
}