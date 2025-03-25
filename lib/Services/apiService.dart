import 'package:dio/dio.dart';

class DioClient {
  // ✅ 1. Create a private static instance (only one copy)
  static final DioClient _instance = DioClient._internal();

  late final Dio dio;

  // ✅ 2. Factory constructor that returns the same instance
  factory DioClient() {
    return _instance;
  }

  // ✅ 3. Private named constructor (executed only once)
  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "x-internal-id": "1232",
        },
      ),
    );
  }
}
