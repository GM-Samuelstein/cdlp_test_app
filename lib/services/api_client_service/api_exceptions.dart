import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException('Connection timeout');
      case DioExceptionType.sendTimeout:
        return ApiException('Request timeout');
      case DioExceptionType.receiveTimeout:
        return ApiException('Response timeout');
      case DioExceptionType.badResponse:
        return ApiException(
          error.response?.data['message'] ?? 'Server error',
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ApiException('Request cancelled');

      default:
        return ApiException('Unexpected error occurred');
    }
  }
}
