class DeleteFadFdaa {
  final bool success;
  final String message;

  DeleteFadFdaa({required this.success, required this.message});

  factory DeleteFadFdaa.fromJson(Map<String, dynamic> json) {
    return DeleteFadFdaa(
      success: json['success'] == 'True',
      message: json['message'],
    );
  }
}
