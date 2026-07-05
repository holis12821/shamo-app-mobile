import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/user.dart';
import 'package:shamoapps/domain/repository/auth_repository.dart';

class Login implements UseCase<User, LoginParams> {
  final AuthRepository repository;
  Login(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) =>
      repository.login(email: params.email, password: params.password);
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}