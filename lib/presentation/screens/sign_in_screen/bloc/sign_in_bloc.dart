import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/domain/entity/user.dart';
import 'package:shamoapps/domain/usecase/login.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final Login login;

  SignInBloc(this.login) : super(const SignInInitial()) {
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(const SignInLoading());
    final result = await login(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(SignInError(failure.message)),
      (user) => emit(SignInSuccess(user)),
    );
  }
}