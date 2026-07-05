import 'package:dio/dio.dart';
import 'package:shamoapps/core/error/failures.dart';

/// Central mapper from a Dio error to a typed [Failure].
///
/// Handles the three Shamo response error shapes:
///   1. Standard envelope: { meta: { code, status, message }, data: null | object }
///   2. Nested auth error: data contains its own { message, error } strings (401 on register)
///   3. Bare string on 500: the body is a raw JSON string, not an object
Failure mapDioExceptionToFailure(DioException e) {
  // Transport-level errors
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.connectionError) {
    return const NetworkFailure('Network problem, please try again.');
  }

  // A Failure raised in an interceptor (e.g. CartSessionFailure) arrives as e.error.
  if (e.error is Failure) return e.error as Failure;

  final status = e.response?.statusCode;
  final body = e.response?.data;

  // Shape #3: bare string body (500)
  if (body is String) return const ServerFailure('Server error, please try again.');

  if (body is Map<String, dynamic>) {
    final meta = body['meta'] as Map<String, dynamic>?;
    final data = body['data'];

    // Shape #2: nested { message, error } (401 on register)
    if (data is Map<String, dynamic> && data['error'] != null) {
      return ValidationFailure(data['error'].toString());
    }

    final msg = (meta?['message'] as String?) ?? 'Request failed.';

    if (status == 401) return AuthFailure(msg);
    if (status == 422) return ValidationFailure(msg);
    return ServerFailure(msg);
  }

  return const ServerFailure('Unexpected server response.');
}