import 'package:katkoty/db/database_service.dart';
import 'package:katkoty/db/models/database_model.dart';

class FadfadaModel implements DatabaseModel {
  String? note;
  int? id = -1;

  FadfadaModel({this.note, this.id});

  FadfadaModel.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note'] = note;
    data['id'] = id;
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
    return AppDatabase.FADFADA_TABLE;
  }

  @override
  Map<String, dynamic>? toMap() {
    return toJson();
  }

  void updateFromMap(Map<String, dynamic> map) {
    note = map['note'];
    id = map['id'];
  }
}
