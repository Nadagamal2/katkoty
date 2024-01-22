class ShokModelresponse {
  List<Shok>? shok;

  ShokModelresponse({this.shok});

  ShokModelresponse.fromJson(Map<String, dynamic> json) {
    if (json['shok'] != null) {
      shok = <Shok>[];
      json['shok'].forEach((v) {
        shok!.add(new Shok.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shok != null) {
      data['shok'] = this.shok!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shok {
  int? id;
  String? text;
  String? createdAt;

  Shok({this.id, this.text, this.createdAt});

  Shok.fromJson(Map<String, dynamic> json) {
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