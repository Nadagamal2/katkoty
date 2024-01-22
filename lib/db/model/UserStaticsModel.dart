class UserStaticsModel {
  final int id;
  final String fullName;
  final String email;
  final String photo;
  final int numPosts;

  UserStaticsModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.photo,
    required this.numPosts,
  });

  factory UserStaticsModel.fromJson(Map<String, dynamic> json) {
    return UserStaticsModel(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      photo: json['photo'],
      numPosts: json['num_posts'],
);}
}