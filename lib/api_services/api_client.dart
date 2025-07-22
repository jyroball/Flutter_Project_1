import 'package:dio/dio.dart';

class ApiClient {
  static final Dio dio = Dio(BaseOptions(
      baseUrl: 'https://us-central1-bootcamp-dev-8f3ed.cloudfunctions.net',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    )
  )..interceptors.add(
    LogInterceptor(
      requestBody: true, 
      responseBody: true
      )
    );
}
