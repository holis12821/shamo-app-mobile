import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/network/error_mapper.dart';
import 'package:shamoapps/data/data_source/user_remote_data_source.dart';
import 'package:shamoapps/domain/entity/user.dart';
import 'package:shamoapps/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;
  UserRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final model = await remote.getUser();
      return Right(model.map());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser({
    required String name,
    required String email,
    required String username,
  }) async {
    try {
      final model = await remote.updateUser(
        name: name,
        email: email,
        username: username,
      );
      return Right(model.map());
    } on DioException catch (e) {
      return Left(mapDioExceptionToFailure(e));
    } catch (_) {
      return const Left(ServerFailure('Unexpected error'));
    }
  }
}