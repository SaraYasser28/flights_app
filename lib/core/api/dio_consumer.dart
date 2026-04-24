import 'package:dio/dio.dart';

import '../errors/error_model.dart';
import '../errors/exceptions.dart';
import 'api_consumer.dart';

class DioConsumer extends ApiConsumer {
  final Dio _dio;
  DioConsumer({required Dio dio}) : _dio = dio;

  @override
  Future<dynamic> get(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      return _handleDioException(e);
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      return _handleDioException(e);
    }
  }

  @override
  Future<dynamic> patch(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      return _handleDioException(e);
    }
  }

  @override
  Future<dynamic> put(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      return _handleDioException(e);
    }
  }

  @override
  Future<dynamic> delete(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      return _handleDioException(e);
    }
  }
}

Never _handleDioException(DioException e) {
  final defaultMessages = {
    DioExceptionType.connectionTimeout:
        'Connection timeout. Please check your internet connection.',
    DioExceptionType.sendTimeout:
        'Send timeout. Please check your internet connection.',
    DioExceptionType.receiveTimeout:
        'Receive timeout. Please check your internet connection.',
    DioExceptionType.badCertificate: 'Bad certificate error.',
    DioExceptionType.cancel: 'Request canceled.',
    DioExceptionType.connectionError:
        'Connection error. Please check your internet connection.',
    DioExceptionType.unknown: 'Unknown error occurred.',
    DioExceptionType.badResponse: 'Bad response error.',
  };

  final message =
      e.response?.data ?? {'error': defaultMessages[e.type] ?? 'Unknown error'};

  throw ServerException(errorModel: ErrorModel.fromJson(message));
}
