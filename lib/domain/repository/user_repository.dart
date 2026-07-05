import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/domain/entity/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, User>> updateUser({
    required String name,
    required String email,
    required String username,
  });
}