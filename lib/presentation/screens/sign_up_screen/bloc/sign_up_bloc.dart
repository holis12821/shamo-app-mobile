import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/domain/entity/user.dart';
import 'package:shamoapps/domain/usecase/register.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final Register register;

  SignUpBloc(this.register) : super(const SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(const SignUpLoading());
    final result = await register(RegisterParams(
      name: event.name,
      email: event.email,
      username: event.username,
      password: event.password,
      phone: event.phone,
    ));
    result.fold(
      (failure) => emit(SignUpError(failure.message)),
      (user) => emit(SignUpSuccess(user)),
    );
  }
}