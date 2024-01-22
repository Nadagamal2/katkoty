import 'dart:convert';

class TaskModel {
  final String name;
  final String subject;
  final String text;

  TaskModel({
    required this.name,
    required this.subject,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'subject': subject,
      'text': text,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      name: map['name'] ?? '',
      subject: map['subject'] ?? 'Untitled',
      text: map['text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));
}
