import 'package:dio/dio.dart';
import 'app_logger.dart';

class HttpLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.i('🌐 ${options.method} ${options.path}');
    AppLogger.d('Headers: ${options.headers}');
    if (options.data != null) {
      AppLogger.d('Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.i(
      '✅ ${response.requestOptions.method} ${response.requestOptions.path} - ${response.statusCode}',
    );
    if (response.data != null) {
      AppLogger.d('Response: ${response.data}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e('❌ ${err.requestOptions.method} ${err.requestOptions.path}');
    AppLogger.e('Error: ${err.message}');
    if (err.response?.data != null) {
      AppLogger.e('Response: ${err.response?.data}');
    }
    handler.next(err);
  }
}
