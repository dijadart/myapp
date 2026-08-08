import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiError {
  final String message;
  ApiError(this.message);

  @override
  String toString() => message;
}

class ErrorHandler {
  static ApiError handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiError("Connection timed out. Please try again.");

        case DioExceptionType.connectionError:
          return ApiError(
            kIsWeb
                ? "Browser network error: check server availability and CORS configuration."
                : "No internet connection available.",
          );
          
        case DioExceptionType.badResponse:
          if (error.response?.data != null) {
            var data = error.response!.data;
            
            // Check if backend returned a plain string error description
            if (data is String && data.isNotEmpty) {
              return ApiError(data);
            }
            
            // Check if backend returned a map response format
            if (data is Map) {
              if (data.containsKey('description')) return ApiError(data['description'].toString());
              if (data.containsKey('message')) return ApiError(data['message'].toString());
              if (data.containsKey('error')) return ApiError(data['error'].toString());
            }
          }
          return ApiError("Server rejected request (Status: ${error.response?.statusCode})");

        case DioExceptionType.unknown:
        default:
          if (error.message != null && error.message!.contains('SocketException')) {
            return ApiError("No internet connection available.");
          }
          return ApiError(error.message ?? "Network connection error occurred.");
      }
    } else {
      return ApiError(error?.toString() ?? "Unexpected system exception");
    }
  }
}
