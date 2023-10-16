import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpUtil {
  static HttpUtil? _instance;

  final Dio _dio;

  HttpUtil._() : _dio = Dio() {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  factory HttpUtil() {
    _instance ??= HttpUtil._();
    return _instance!;
  }

  Future<String?> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    String contentType = "application/x-www-form-urlencoded",
    CancelToken? cancelToken,
  }) async {
    queryParameters = queryParameters;

    String json;
    String toPath = path;
    try {
      Response response = await _dio.get<String>(
        toPath,
        queryParameters: queryParameters,
        options: Options(
          contentType: contentType,
        ),
        cancelToken: cancelToken,
      );
      json = response.data;
      return json;
    } catch (e) {
      debugPrint("HttpUtilError  $toPath  ${e.toString()}");
    }
    return null;
  }

  Future<String?> post(
    String path, {
    Map<String, dynamic>? data,
    String contentType = "application/x-www-form-urlencoded",
    CancelToken? cancelToken,
  }) async {
    data = data ?? {};
    String json;
    String toPath = path;
    try {
      Response response = await _dio.post<String>(toPath,
          data: data,
          options: Options(
            contentType: contentType,
          ),
          cancelToken: cancelToken);
      json = response.data;
      return json;
    } catch (e) {
      debugPrint("HttpUtilError  $toPath  ${e.toString()}");
    }
    return null;
  }

  Future<String?> put(
    String path, {
    Map<String, dynamic>? data,
    String contentType = "application/x-www-form-urlencoded",
  }) async {
    data = data ?? {};
    String json;
    try {
      Response response = await _dio.put<String>(
        path,
        data: data,
        options: Options(
          contentType: contentType,
        ),
      );
      json = response.data;
      return json;
    } catch (e) {
      debugPrint("HttpUtilError  $path  ${e.toString()}");
    }
    return null;
  }
}
