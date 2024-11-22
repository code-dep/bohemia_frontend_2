import 'dart:io';

import 'package:bohemia/controllers/user_data_controller.dart';
import 'package:bohemia/services/api/interfaces/i_base_api_service.dart';
import 'package:dio/dio.dart';
// ignore: library_prefixes
import 'package:get/get.dart' as Get;

class BaseApiService implements IBaseApiService {
  final UserDataController _userDataController = Get.Get.find();

  late Dio _handler;
  BaseApiService(String baseUrl) {
    final opts = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 5000),
        followRedirects: true,
        maxRedirects: 5,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
    _handler = Dio(opts);

    _handler.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_userDataController.userToken.value != null) {
            options.headers['Authorization'] =
                'Bearer ${_userDataController.userToken.value!}';

            return handler.next(options);
          }
          return handler.next(options);
        },
      ),
    );
  }

  @override
  Future<Response> delete(String url) async {
    return await _handler.delete(url);
  }

  @override
  Future<Response> get(String url) async {
    return await _handler.get(url);
  }

  @override
  Future<Response> post(String url, Map<String, dynamic> body) async {
    return await _handler.post(url, data: body);
  }

  @override
  Future<Response> put(String url, Map<String, dynamic> body) async {
    return await _handler.put(url, data: body);
  }

  @override
  Future<Response> formDataWithOptions(
      String url, FormData formData, Options options) async {
    try {
      if (!url.endsWith('/')) {
        url = '$url/';
      }

      final response = await _handler.post(
        url,
        data: formData,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 307) {
        final redirectUrl = e.response?.headers.value('location');
        if (redirectUrl != null) {
          // Create new FormData for redirect
          final newFormData = FormData();
          newFormData.fields.addAll(formData.fields);

          // Re-add the files as they are
          if (formData.files.isNotEmpty) {
            newFormData.files.addAll(formData.files);
          }

          return await _handler.post(
            redirectUrl,
            data: newFormData,
            options: options,
          );
        }
      }
      rethrow;
    }
  }
}
