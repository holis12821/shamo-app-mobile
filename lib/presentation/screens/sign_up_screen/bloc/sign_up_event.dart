part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpSubmitted extends SignUpEvent {
  final String name;
  final String email;
  final String username;
  final String password;
  final String phone;

  const SignUpSubmitted({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
  });

  @override
  List<Object?> get props => [name, email, username, password, phone];
}