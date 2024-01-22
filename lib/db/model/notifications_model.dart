class Notification {
  final int id;
  final String title;
  late final String body;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  
  String get formattedCreatedAt {
    return '${createdAt.day.toString().padLeft(2, '0')} / ${createdAt.month.toString().padLeft(2, '0')} / ${createdAt.year}';
  }
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'created_at': createdAt.toIso8601String(),
    };
  }
}