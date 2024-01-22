import 'package:katkoty/service/api_service.dart';

class GiftImageModel {
  List<WheelImage>? wheel;

  GiftImageModel({this.wheel});

  GiftImageModel.fromJson(Map<String, dynamic> json) {
    if (json['wheel'] != null) {
      wheel = <WheelImage>[];
      json['wheel'].forEach((v) {
        wheel!.add(new WheelImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wheel != null) {
      data['wheel'] = this.wheel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WheelImage {
  int? id;
  String? url;
  String? createdAt;

  WheelImage({this.id, this.url, this.createdAt});

  WheelImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = ApiService.BASE_IMAGES_URL + json['url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    return data;
  }
}
