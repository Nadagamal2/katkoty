class EditFadFadaResponse {
  final bool success;
  final String message;

  EditFadFadaResponse({required this.success, required this.message});

  factory EditFadFadaResponse.fromJson(Map<String, dynamic> json) {
    return EditFadFadaResponse(
      success: json['success'].toString().toLowerCase() == 'true',
      message: json['message'],
    );
  }
}
