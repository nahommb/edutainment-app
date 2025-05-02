import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String> getAuthToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future setAuthToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  Future deltetAuthToken() async {
    return await storage.delete(key: 'token');
  }

  static final DioClient _instance = DioClient._internal();
  late Map<String, dynamic> header = {
    'Accept': 'application/json',
  };
  late String token = '';
  late Dio dio;

  DioClient._internal() {
    dio = Dio(BaseOptions(
        // baseUrl: endpoint, // Replace with your base URL
        ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('Dio Error Interceptor: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future getToken() async {
    token = await getAuthToken();
    print('###### token $token');

    header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    return header;
  }

  factory DioClient() {
    return _instance;
  }

  // Handle DioException properly inside requests
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: await getToken()),
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
  }) async {
    try {
      return await dio.post(
        path,
        data: data,
        options: Options(headers: await getToken()),
      );
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await dio.put(path, data: data);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await dio.delete(path, data: data);
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  // Function to handle Dio errors and return meaningful messages
  Exception handleDioError(DioException e) {
    print(e.toString());
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception(throw "Connection timed out. Please try again.");
      case DioExceptionType.sendTimeout:
        return Exception(throw "Request timed out. Please try again.");
      case DioExceptionType.receiveTimeout:
        return Exception(
            throw "Server response took too long. Please try again.");
      case DioExceptionType.badResponse:
        if (e.response?.data is Map &&
            e.response!.data.containsKey('message')) {
          //return throw e..response!.data['message'];

          return Exception(throw e.response!.data['message']);
        }
        return Exception(throw "Unexpected error occurred");
      case DioExceptionType.cancel:
        return Exception(throw "Request was cancelled.");
      case DioExceptionType.connectionError:
        return Exception(
            throw "No internet connection. Please check your network.");
      case DioExceptionType.unknown:
      default:
        return Exception(throw "Unexpected error occurred:");
    }
  }
}
