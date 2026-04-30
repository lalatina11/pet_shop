class ApiResponse {
  bool success;
  String message;
  dynamic data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  ApiResponse copyWith({bool? success, String? message, dynamic data}) {
    return ApiResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data};
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }

  @override
  String toString() =>
      '''ApiResponse(success: $success, message: $message, data: $data)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApiResponse &&
        other.success == success &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
