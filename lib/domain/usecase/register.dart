import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shamoapps/core/error/failures.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/user.dart';
import 'package:shamoapps/domain/repository/auth_repository.dart';

class Register implements UseCase<User, RegisterParams> {
  final AuthRepository repository;
  Register(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) =>
      repository.register(
        name: params.name,
        email: params.email,
        username: params.username,
        password: params.password,
        phone: params.phone,
      );
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String username;
  final String password;
  final String phone;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
  });

  @override
  List<Object?> get props => [name, email, username, password, phone];
}