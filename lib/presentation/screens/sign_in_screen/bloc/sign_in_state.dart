part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {
  const SignInInitial();
}

class SignInLoading extends SignInState {
  const SignInLoading();
}

class SignInSuccess extends SignInState {
  final User user;
  const SignInSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SignInError extends SignInState {
  final String message;
  const SignInError(this.message);

  @override
  List<Object?> get props => [message];
}