import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/storage/token_storage.dart';

/// Attaches `Authorization: Bearer <access_token>` to every authenticated
/// request and handles the token refresh-and-retry flow.
///
/// Single-flight lock: when a 401 triggers a refresh, concurrent 401s queue
/// behind it and share the result rather than firing independent refreshes.
///
/// Rules:
/// - register and login routes do not carry the access token.
/// - POST /api/refresh carries the refresh token (attached here in onError,
///   not in onRequest) and is never itself retried.
/// - A retried request that returns 401 again → AuthFailure (no second retry).
class AuthInterceptor extends Interceptor {
  final Dio _refreshDio;
  final TokenStorage _tokenStorage;

  bool _isRefreshing = false;
  final List<Completer<String>> _waiters = [];

  static const _skipPaths = ['/api/auth/register', '/api/auth/login'];

  AuthInterceptor({
    required Dio refreshDio,
    required TokenStorage tokenStorage,
  })  : _refreshDio = refreshDio,
        _tokenStorage = tokenStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final path = options.path;

    // These endpoints do not need an access token
    if (_skipPaths.any(path.endsWith) || path.endsWith('/api/refresh')) {
      return handler.next(options);
    }

    final token = await _tokenStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) return handler.next(err);

    // If /api/refresh itself returned 401, clear session and surface AuthFailure
    if (err.requestOptions.path.endsWith('/api/refresh')) {
      await _tokenStorage.clear();
      return handler.next(err);
    }

    // Prevent infinite retry loop — a request is retried at most once
    if (err.requestOptions.extra['retried'] == true) {
      return handler.next(err);
    }

    try {
      final newToken = await _acquireNewToken();

      err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
      err.requestOptions.extra['retried'] = true;

      final response = await _refreshDio.fetch(err.requestOptions);
      handler.resolve(response);
    } catch (_) {
      handler.next(err);
    }
  }

  /// Ensures only one refresh call is in flight at a time.
  /// Concurrent callers wait on a [Completer] and share the result.
  Future<String> _acquireNewToken() async {
    if (_isRefreshing) {
      final completer = Completer<String>();
      _waiters.add(completer);
      return completer.future;
    }

    _isRefreshing = true;
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken == null) {
        throw const AuthFailure('No refresh token stored.');
      }

      final response = await _refreshDio.post(
        '/api/refresh',
        options: Options(
          headers: {'Authorization': 'Bearer $refreshToken'},
        ),
      );

      // Confirmed against live API: POST /api/refresh returns
      // { access_token, token_type } only — no refresh_token (not rotated),
      // no user. Keep the existing refresh token as-is.
      final data = response.data['data'] as Map<String, dynamic>;
      final newAccessToken = data['access_token'] as String;

      await _tokenStorage.saveTokens(
        accessToken: newAccessToken,
      );

      for (final w in _waiters) {
        w.complete(newAccessToken);
      }
      _waiters.clear();

      return newAccessToken;
    } catch (e) {
      await _tokenStorage.clear();
      for (final w in _waiters) {
        w.completeError(e);
      }
      _waiters.clear();
      rethrow;
    } finally {
      _isRefreshing = false;
    }
  }
}