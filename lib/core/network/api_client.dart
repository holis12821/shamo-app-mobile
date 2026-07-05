import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shamoapps/core/network/interceptors/auth_interceptor.dart';
import 'package:shamoapps/core/network/interceptors/cart_interceptor.dart';
import 'package:shamoapps/core/network/interceptors/host_interceptor.dart';
import 'package:shamoapps/core/storage/cart_storage.dart';
import 'package:shamoapps/core/storage/token_storage.dart';

/// Factory that creates the application's configured [Dio] instance.
///
/// A separate "refresh Dio" (no interceptors) is used internally by
/// [AuthInterceptor] for the refresh call and for retrying queued requests,
/// avoiding recursive interceptor invocation.
class ApiClient {
  static Dio create({
    required String baseUrl,
    required TokenStorage tokenStorage,
    required CartStorage cartStorage,
  }) {
    final baseOptions = BaseOptions(
      baseUrl: baseUrl,
      preserveHeaderCase: true,
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    );

    // Plain Dio used by AuthInterceptor for the refresh call and request retry.
    // Must NOT have the auth or cart interceptors to avoid recursive loops.
    final refreshDio = Dio(baseOptions);

    final dio = Dio(baseOptions);
    dio.interceptors.addAll([
      HostInterceptor(),
      CartInterceptor(cartStorage: cartStorage),
      AuthInterceptor(refreshDio: refreshDio, tokenStorage: tokenStorage),
      if (kDebugMode)
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
    ]);

    return dio;
  }
}