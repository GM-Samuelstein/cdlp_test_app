import 'package:dio/dio.dart';

import '../connectivity_service/connectivity_service.dart';
import 'api_exceptions.dart';
import 'api_result.dart';

export 'api_endpoints.dart';

class ApiClientService {
  late final Dio _dio;
  final ConnectivityService _connectivityService;

  ApiClientService({
    required ConnectivityService connectivityService,
    String? baseUrl,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
  }) : _connectivityService = connectivityService {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? '',
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _addInterceptors();
  }

  // ------------------------------------------------------
  // Interceptors
  // ------------------------------------------------------
  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final isConnected = await _connectivityService.isConnected();

          if (!isConnected) {
            return handler.reject(
              DioException(
                requestOptions: options,
                error: NoInternetException(),
                type: DioExceptionType.unknown,
              ),
            );
          }

          final token = await _getAuthToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );

    /*
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
    */
  }

  // ------------------------------------------------------
  // HTTP METHODS
  // ------------------------------------------------------
  Future<ApiResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      return ApiSuccess(response.data as T);
    } on DioException catch (e) {
      return ApiExceptionMapper.map<T>(e);
    }
  }

  Future<ApiResult<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return ApiSuccess(response.data as T);
    } on DioException catch (e) {
      return ApiExceptionMapper.map<T>(e);
    }
  }

  Future<ApiResult<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return ApiSuccess(response.data as T);
    } on DioException catch (e) {
      return ApiExceptionMapper.map<T>(e);
    }
  }

  Future<ApiResult<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return ApiSuccess(response.data as T);
    } on DioException catch (e) {
      return ApiExceptionMapper.map<T>(e);
    }
  }

  // ------------------------------------------------------
  // Helpers
  // ------------------------------------------------------
  Future<String?> _getAuthToken() async {
    // TODO: integrate secure storage
    return null;
  }
}
