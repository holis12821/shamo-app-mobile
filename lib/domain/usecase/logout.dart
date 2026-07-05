import 'package:dartz/dartz.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/repository/auth_repository.dart';

class Logout implements UseCase<void, NoParams> {
  final AuthRepository repository;
  Logout(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) => repository.logout();
}