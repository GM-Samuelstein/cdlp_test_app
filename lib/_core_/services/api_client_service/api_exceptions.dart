import 'dart:io';

import 'package:dio/dio.dart';

import 'api_result.dart';

export 'no_internet_exception.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  factory ApiException.fromDioError(DioException error) {
    if (error.type == DioExceptionType.badResponse) {
      final data = error.response?.data;

      String message = 'Server error';

      if (data is Map<String, dynamic>) {
        message = data['message']?.toString() ?? message;
      } else if (data is String) {
        message = data;
      }

      return ApiException(message, statusCode: error.response?.statusCode);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException('Connection timeout');
      case DioExceptionType.sendTimeout:
        return ApiException('Request timeout');
      case DioExceptionType.receiveTimeout:
        return ApiException('Response timeout');
      case DioExceptionType.cancel:
        return ApiException('Request cancelled');
      default:
        return ApiException('Unexpected error occurred');
    }
  }
}

class ApiExceptionMapper {
  static ApiFailure<T> map<T>(DioException error) {
    if (error.error is SocketException) {
      return const ApiFailure(
        'No internet connection. Please check your network.',
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiFailure('Connection timeout');

      case DioExceptionType.sendTimeout:
        return const ApiFailure('Request timeout');

      case DioExceptionType.receiveTimeout:
        return const ApiFailure('Response timeout');

      case DioExceptionType.badResponse:
        final data = error.response?.data;

        String message = 'Server error';

        if (data is Map<String, dynamic>) {
          message = data['message']?.toString() ?? message;
        } else if (data is String) {
          message = data;
        }

        return ApiFailure(message, statusCode: error.response?.statusCode);

      case DioExceptionType.cancel:
        return const ApiFailure('Request cancelled');

      default:
        return const ApiFailure('Unexpected network error');
    }
  }
}
