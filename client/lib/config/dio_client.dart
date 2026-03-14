import 'package:client/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  static Dio build() {
    // 1. Set up BaseOptions for global settings
    final baseOptions = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
      headers: {
        'Accept': 'application/json',
      },
    );

    final dio = Dio(baseOptions);

    // 2. Add Interceptors
    // Built-in logger (great for debugging in the console)
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
    ));

    // Custom Interceptor (e.g., for adding Auth Tokens globally)
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // TODO: Fetch your token from secure storage here
        // final token = await secureStorage.getToken();
        // if (token != null) {
        //   options.headers['Authorization'] = 'Bearer $token';
        // }
        
        return handler.next(options); // Continue the request
      },
      onError: (DioException e, handler) {
        // Global error handling (e.g., token expired -> logout user)
        if (e.response?.statusCode == 401) {
          // Trigger logout logic
        }
        return handler.next(e); // Continue the error
      },
    ));

    return dio;
  }
}