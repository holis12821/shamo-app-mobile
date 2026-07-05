import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/user.dart';
import 'package:shamoapps/domain/repository/user_repository.dart';

class UpdateUser implements UseCase<User, UpdateUserParams> {
  final UserRepository repository;
  UpdateUser(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateUserParams params) =>
      repository.updateUser(
        name: params.name,
        email: params.email,
        username: params.username,
      );
}

class UpdateUserParams extends Equatable {
  final String name;
  final String email;
  final String username;

  const UpdateUserParams({
    required this.name,
    required this.email,
    required this.username,
  });

  @override
  List<Object?> get props => [name, email, username];
}