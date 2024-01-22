import 'dart:io';

class SoundsResponse {
  List<SoundsModel>? sounds;

  SoundsResponse({this.sounds});

  SoundsResponse.fromJson(Map<String, dynamic> json) {
    if (json['sounds'] != null) {
      sounds = <SoundsModel>[];
      json['sounds'].forEach((v) {
        sounds!.add(SoundsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sounds != null) {
      data['sounds'] = sounds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SoundsModel {
  int? id;
  String? name;
  String? url;
  String? createdAt;
  File? cashedFile;

  SoundsModel({this.id, this.name, this.url, this.createdAt});

  SoundsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    data['created_at'] = createdAt;
    return data;
  }
}
