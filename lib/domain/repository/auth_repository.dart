import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/domain/entity/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String username,
    required String password,
    required String phone,
  });

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();
}