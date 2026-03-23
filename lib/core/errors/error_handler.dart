import 'package:dio/dio.dart';
import 'api_error.dart';

class ErrorHandler {
  static ApiError handle(dynamic error) {
    if (error is DioException) {
      return ApiError(
        message: error.response?.data["message"] ?? "Network Error",
        code: error.response?.statusCode,
      );
    }
    return ApiError(message: error.toString());
  }
}