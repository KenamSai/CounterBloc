import 'dart:convert';

import 'package:counterappblocpackg/core/app_logger.dart';
import 'package:dio/dio.dart';

class BaseApiClient {
  //Type1
  //._ is just a name not method or flutter keyword
  // Step 1: Private named constructor
  // BaseApiClient._privateConstructor();
  // // Step 2: Single static instance
  // static final BaseApiClient _instance = BaseApiClient._privateConstructor();
  // //Public factory constructor that returns the same instance
  // factory BaseApiClient() => _instance;
  //Type 2
  //
  static BaseApiClient? _instance;
  //internal constructor mean create a object and store it
  BaseApiClient._internal();
  factory BaseApiClient() {
    // Lazy initialization: Create instance only when needed
    return _instance ??= BaseApiClient._internal();
  }
  final Dio _dioClient = Dio(
    BaseOptions(
      baseUrl: "https://uat4.cgg.gov.in/WDSC/wdscapi/",
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      headers: {'Content-Type': "application/json"},
    ),
  )..interceptors.add(
      LoggingInterceptor(),
    );

  Future<dynamic> postCall({
    required String endURL,
    required Map<String, dynamic> body,
  }) async {
    try {
      Response<dynamic> response = await _dioClient.post(
        endURL,
        data: body,
      );
      if (response.statusCode != 200) {
        throw Exception("Something went wrong. Please try again later.");
      }
      return response.data;
    } on DioException catch (e) {
      throw Exception(
        _handleDioError(e),
      );
    } catch (_) {
      throw Exception("Something went wrong. Please try again later.");
    }
  }

  /// Handles Dio exception types and returns user-friendly messages
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        // ⏱ Happens when app takes too long to connect to the server
        // Example: user is on slow 2G, or server DNS is unreachable
        return "Connection timed out. Please check your internet connection.";

      case DioExceptionType.sendTimeout:
        // 📤 Happens when request body (like form-data or JSON) takes too long to send
        // Example: large image upload on bad network
        return "Request timed out while sending data.";

      case DioExceptionType.receiveTimeout:
        // 📥 Happens when server took too long to send response
        // Example: server is slow or busy
        return "Server took too long to respond. Try again later.";

      case DioExceptionType.badResponse:
        // ⚠️ Happens when server returns an error HTTP status (4xx or 5xx)
        // Example: 404 Not Found, 500 Internal Server Error, etc.
        final statusCode = e.response?.statusCode ?? 0;
        String message = "Unknown error";

        if (e.response?.data is Map<String, dynamic>) {
          message = e.response?.data['message'] ?? e.message ?? message;
        } else if (e.response?.data is String) {
          final dataStr = e.response?.data as String;
          if (dataStr.trim().startsWith('<')) {
            // Likely HTML, show generic message
            message = "Something went wrong. Please try again later.";
          } else {
            message = dataStr;
          }
        } else {
          message = e.message ?? message;
        }
        return "Server error ($statusCode): $message";
      case DioExceptionType.cancel:
        // ❌ Happens when you manually cancel a request
        // Example: user navigated away before request finished
        return "Request was cancelled.";

      case DioExceptionType.connectionError:
        // 🌐 Happens when there's no internet connection or DNS fails
        // Example: airplane mode, weak WiFi, invalid SSL
        return "No internet connection. Please check your network.";

      case DioExceptionType.unknown:
        // 🤔 Catch-all for anything not matched above
        // Example: JSON parsing issue, unexpected internal Dio behavior
        return "Unexpected error occurred. Please try again.";

      default:
        return "Something went wrong. Please try again later.";
    }
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Boxed log with PrettyPrinter
    AppLogger().logDebug("Sending URL: ${options.uri}", tag: "API");
    AppLogger()
        .logDebug("Sending payload: ${jsonEncode(options.data)}", tag: "API");
    AppLogger().logDebug("Sending headers: ${jsonEncode(options.headers)}",
        tag: "API");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger().logDebug("Received response: ${jsonEncode(response.data)}",
        tag: "API");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger().logError(
      "Error response: ${err.message}",
      error: err,
    );
    super.onError(err, handler);
  }
}
