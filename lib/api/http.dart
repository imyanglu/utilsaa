import 'package:dio/dio.dart';
import 'package:music/common/utils/storage.dart';

class Http {
  static final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: 'https://api.example.com',
            connectTimeout: Duration(seconds: 10),
            receiveTimeout: Duration(seconds: 10),
            headers: {'Content-Type': 'application/json;charset=UTF-8'},
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            // 请求拦截（加 token）
            onRequest: (options, handler) {
              // final token = Storage.getString('token');
              // if (token != null) {
              //   options.headers['Authorization'] = 'Bearer $token';
              // }
              handler.next(options);
            },
            // 响应拦截
            onResponse: (response, handler) {
              handler.next(response);
            },
            // 错误拦截
            onError: (error, handler) {
              handler.next(error);
            },
          ),
        );

  static Future<T> get<T>(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    final res = await _dio.get(
      path,
      queryParameters: params,
      options: Options(headers: headers),
    );
    return res.data;
  }

  static Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    final res = await _dio.post(
      path,
      data: data,
      options: Options(headers: headers),
    );
    return res.data;
  }
}
