import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
    filter: DevelopmentFilter(),
    output: CustomOutput(),
  );

  static void init() {
    if (kDebugMode) {
      _logger.i('📱 AppLogger initialized');

      // Capture all uncaught errors
      FlutterError.onError = (FlutterErrorDetails details) {
        _logger.e(
          'Flutter Error: ${details.exception}',
          error: details.exception,
          stackTrace: details.stack,
        );
        // Forward to original handler
        if (kDebugMode) {
          FlutterError.dumpErrorToConsole(details);
        }
      };

      // Capture all platform errors
      PlatformDispatcher.instance.onError = (error, stack) {
        _logger.e('Platform Error: $error', error: error, stackTrace: stack);
        return true;
      };
    }
  }

  // Direct logging methods (for when you need to log manually)
  static void d(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void i(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void e(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void f(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  static void json(dynamic message) {
    _logger.d(message);
  }
}

// Custom output to capture all console logs
class CustomOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      // Print to console
      developer.log(line, name: 'FLIGHT_APP');

      // Optional: Write to file
      // _writeToFile(line);
    }
  }
}
