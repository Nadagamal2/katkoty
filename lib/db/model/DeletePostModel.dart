class DeletePostResponse {
  final String message;
  final bool success;

  DeletePostResponse({
    required this.message,
    required this.success,
  });

  factory DeletePostResponse.fromJson(Map<String, dynamic> json) {
    return DeletePostResponse(
      message: json['message'],
      success: json['success'],
    );
  }
}