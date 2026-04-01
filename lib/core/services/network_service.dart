import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// generic result wrapper for all api calls
class NetworkResult<T> {
  final T? data;
  final int? statusCode;
  final String? message;
  final bool isSuccess;

  NetworkResult._({
    this.data,
    this.statusCode,
    this.message,
    required this.isSuccess,
  });

  factory NetworkResult.success(T data, int? statusCode, String? message) {
    return NetworkResult._(
      data: data,
      statusCode: statusCode,
      message: message,
      isSuccess: true,
    );
  }

  factory NetworkResult.failure(int? statusCode, String? message) {
    return NetworkResult._(
      statusCode: statusCode,
      message: message,
      isSuccess: false,
    );
  }
}

// singleton network service using dio
class NetworkService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  static final NetworkService _instance = NetworkService._internal();

  NetworkService._internal();

  static NetworkService get instance => _instance;

  // get request
  Future<NetworkResult<dynamic>> get(String endpoint) async {
    try {
      final Response response = await _dio.get(endpoint);

      log(
        const JsonEncoder.withIndent('  ').convert(response.data),
        name:
            '\n🚨\n[STATUS CODE] ${response.statusCode}\n[GET][ENDPOINT] $endpoint\n[RESPONSE]\n',
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return NetworkResult.success(
          response.data,
          response.statusCode,
          response.statusMessage,
        );
      } else {
        return NetworkResult.failure(
          response.statusCode,
          response.statusMessage,
        );
      }
    } on DioException catch (e) {
      debugPrint(
        '🚨\n[ERROR]\n[STATUS CODE] ${e.response?.statusCode ?? 0}\n[GET][ENDPOINT] $endpoint\n[MESSAGE] $e',
      );

      return NetworkResult.failure(
        e.response?.statusCode ?? 0,
        e.response?.statusMessage ??
            e.message ??
            'Something went wrong on our side. Please try again.',
      );
    }
  }

  // post request
  Future<NetworkResult<dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final Response response = await _dio.post(endpoint, data: body);

      log(
        const JsonEncoder.withIndent('  ').convert(response.data),
        name:
            '\n🚨\n[STATUS CODE] ${response.statusCode}\n[POST][ENDPOINT] $endpoint\n[RESPONSE]\n',
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return NetworkResult.success(
          response.data,
          response.statusCode,
          response.statusMessage,
        );
      } else {
        return NetworkResult.failure(
          response.statusCode,
          response.statusMessage,
        );
      }
    } on DioException catch (e) {
      debugPrint(
        '🚨\n[ERROR]\n[STATUS CODE] ${e.response?.statusCode ?? 0}\n[POST][ENDPOINT] $endpoint\n[MESSAGE] $e',
      );

      return NetworkResult.failure(
        e.response?.statusCode ?? 0,
        e.response?.statusMessage ??
            e.message ??
            'Something went wrong on our side. Please try again.',
      );
    }
  }
}
