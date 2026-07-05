import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/user.dart';
import 'package:shamoapps/domain/repository/user_repository.dart';

class GetUser implements UseCase<User, NoParams> {
  final UserRepository repository;
  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) => repository.getUser();
}