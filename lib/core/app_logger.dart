import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  final Logger _logger;
  late final Logger _loggerNoStack;
  late final Logger _simpleLogger;
  AppLogger._internal()
      : _logger = Logger(
          printer: PrettyPrinter(),
          level: kDebugMode ? Level.debug : Level.off,
        ),
        _loggerNoStack = Logger(
          printer: PrettyPrinter(methodCount: 0),
          level: kDebugMode ? Level.debug : Level.off,
        ),
        _simpleLogger = Logger(
          printer: SimplePrinter(colors: true),
          level: kDebugMode ? Level.debug : Level.off,
        );

  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;

  /// Full debug log with stack trace
  void logDebug(String message, {String? tag}) {
    if (kDebugMode) _logger.d(_format(tag, message));
  }

  /// Info log without stack trace
  void logInfo(String message, {String? tag}) {
    if (kDebugMode) _loggerNoStack.i(_format(tag, message));
  }

  /// Warning log without stack trace
  void logWarning(String message, {String? tag}) {
    if (kDebugMode) _loggerNoStack.w(_format(tag, message));
  }

  /// Error log with optional error object
  void logError(String message,
      {dynamic error, StackTrace? stackTrace, String? tag}) {
    if (kDebugMode) {
      _logger.e(_format(tag, message), error: error, stackTrace: stackTrace);
    }
  }

  /// Trace log without stack trace
  void logTrace(dynamic message, {String? tag}) {
    if (kDebugMode) _loggerNoStack.t(_format(tag, message.toString()));
  }

  /// Minimal/simple trace
  void logSimpleTrace(String message, {String? tag}) {
    if (kDebugMode) _simpleLogger.t(_format(tag, message));
  }

  // Optional tag formatter
  String _format(String? tag, String message) {
    return tag != null ? "[$tag] $message" : message;
  }
}
