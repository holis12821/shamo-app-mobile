import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/network/error_mapper.dart';
import 'package:shamoapps/core/storage/cart_storage.dart';
import 'package:shamoapps/core/storage/token_storage.dart';
import 'package:shamoapps/data/data_source/auth_remote_data_source.dart';
import 'package:shamoapps/domain/entity/user.dart';
import 'package:shamoapps/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final TokenStorage tokenStorage;
  final CartStorage cartStorage;

  AuthRepositoryImpl({
    required this.remote,
    required this.tokenStorage,
    required this.cartStorage,
  });

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String username,
    required String password,
    required String phone,
  }) async {
    try {
      final model = await remote.register(
        name: name,
        email: email,
        username: username,
        password: password,
        phone: phone,
      );
      await tokenStorage.saveTokens(
        accessToken: model.accessToken,
        refreshToken: model.refreshToken,
      );
      return Right(model.user.map());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final model = await remote.login(email: email, password: password);
      await tokenStorage.saveTokens(
        accessToken: model.accessToken,
        refreshToken: model.refreshToken,
      );
      return Right(model.user.map());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remote.logout();
      await tokenStorage.clear();
      await cartStorage.clear();
      return const Right(null);
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }
}