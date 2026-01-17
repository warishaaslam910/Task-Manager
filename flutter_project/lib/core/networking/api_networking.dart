import 'package:dio/dio.dart';

class ApiNetworking {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<Response> get(String path, {Map<String, dynamic>? query}) =>
      dio.get(path, queryParameters: query);

  Future<Response> post(String path, {dynamic data}) =>
      dio.post(path, data: data);

  Future<Response> put(String path, {dynamic data}) =>
      dio.put(path, data: data);

  Future<Response> delete(String path) => dio.delete(path);
}
