import 'package:dio/dio.dart';
import 'package:shamoapps/data/model/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String username,
    required String password,
    required String phone,
  });

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String username,
    required String password,
    required String phone,
  }) async {
    final response = await dio.post('/api/auth/register', data: {
      'name': name,
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
    });
    final data = response.data['data'] as Map<String, dynamic>;
    return AuthResponseModel.fromJson(data);
  }

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post('/api/auth/login', data: {
      'email': email,
      'password': password,
    });
    final data = response.data['data'] as Map<String, dynamic>;
    return AuthResponseModel.fromJson(data);
  }

  @override
  Future<void> logout() async {
    await dio.post('/api/auth/logout');
  }
}