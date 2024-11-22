import 'package:dio/dio.dart';

abstract class IBaseApiService {
  Future<Response> get(String url);
  Future<Response> post(String url, Map<String, dynamic> body);
  Future<Response> put(String url, Map<String, dynamic> body);
  Future<Response> delete(String url);
  Future<Response> formDataWithOptions(
      String path, FormData data, Options options);
}
