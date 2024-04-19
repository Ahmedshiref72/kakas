import 'package:dio/dio.dart';

import 'api_constants.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {'Authorization': 'Bearer $token'};
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }



  static Future<Response> postDataFromFormData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }



  static Future<Response> postDataFromFormDataForImage({
    required String url,
    required FormData data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    required String token,
    Map<String, dynamic>? queryParameters,
  }) async {
    dio!.options.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await dio!.delete(
        url,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
