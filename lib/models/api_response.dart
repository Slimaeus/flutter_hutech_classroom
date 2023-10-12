import 'package:flutter_hutech_classroom/models/api_error.dart';

class ApiResponse<T> {
  final bool isSucceed;
  final T? data;
  final List<ApiError>? errors;

  ApiResponse({
    required this.isSucceed,
    this.data,
    this.errors,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse(isSucceed: true, data: data);
  }

  factory ApiResponse.failed(Map<String, dynamic> errorData) {
    var errorsList = errorData.entries
        .map((entry) =>
            ApiError(field: entry.key, message: entry.value.toString()))
        .toList();

    return ApiResponse(isSucceed: false, errors: errorsList);
  }
}
