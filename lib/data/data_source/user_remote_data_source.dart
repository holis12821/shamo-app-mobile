import 'package:dio/dio.dart';
import 'package:shamoapps/data/model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser();
  Future<UserModel> updateUser({
    required String name,
    required String email,
    required String username,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;
  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> getUser() async {
    final response = await dio.get('/api/user');
    final data = response.data['data'] as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel> updateUser({
    required String name,
    required String email,
    required String username,
  }) async {
    final response = await dio.post('/api/user', data: {
      'name': name,
      'email': email,
      'username': username,
    });
    final data = response.data['data'] as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }
}