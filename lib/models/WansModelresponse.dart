class WansModelresponse {
  List<Wans>? wans;

  WansModelresponse({this.wans});

  WansModelresponse.fromJson(Map<String, dynamic> json) {
    if (json['wans'] != null) {
      wans = <Wans>[];
      json['wans'].forEach((v) {
        wans!.add(new Wans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wans != null) {
      data['wans'] = this.wans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wans {
  int? id;
  String? text;
  String? createdAt;

  Wans({this.id, this.text, this.createdAt});

  Wans.fromJson(Map<String, dynamic> json) {
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