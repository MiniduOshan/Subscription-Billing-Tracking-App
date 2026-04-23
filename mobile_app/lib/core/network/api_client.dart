import 'package:dio/dio.dart';

import '../config/app_config.dart';

class ApiClient {
  ApiClient({String? token})
    : _dio = Dio(
        BaseOptions(
          baseUrl: AppConfig.apiBaseUrl,
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

  final Dio _dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response<dynamic>> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response<dynamic>> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<Response<dynamic>> patch(String path, {dynamic data}) {
    return _dio.patch(path, data: data);
  }

  Future<Response<dynamic>> delete(String path) {
    return _dio.delete(path);
  }
}
