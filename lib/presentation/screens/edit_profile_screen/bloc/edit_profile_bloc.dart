import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shamoapps/domain/entity/user.dart';
import 'package:shamoapps/domain/usecase/update_user.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UpdateUser updateUser;

  var _name = '';
  var _username = '';
  var _email = '';
  var _phone = '';

  EditProfileBloc({required this.updateUser}) : super(EditProfileInitial()) {
    on<EditProfileNameChanged>(_onEditProfileNameChanged);

    on<EditProfileUsernameChanged>(_onEditProfileUsernameChanged);

    on<EditProfileEmailChanged>(_onEditProfileEmailChanged);

    on<EditProfilePhoneChanged>(_onEditProfilePhoneChanged);

    on<EditProfileGetUser>(_onEditProfileGetUUser);

    on<EditProfileSubmitPressed>(_onEditProfileSubmitPressed,
        transformer: droppable());
  }

  Future<void> _onEditProfileNameChanged(
    EditProfileNameChanged event,
    Emitter<EditProfileState> emit,
  ) async {
    _name = event.name;
    _validateForm(emit);
  }

  Future<void> _onEditProfileUsernameChanged(
    EditProfileUsernameChanged event,
    Emitter<EditProfileState> emit,
  ) async {
    _username = event.username;
    _validateForm(emit);
  }

  Future<void> _onEditProfileEmailChanged(
    EditProfileEmailChanged event,
    Emitter<EditProfileState> emit,
  ) async {
    _email = event.email;
    _validateForm(emit);
  }

  Future<void> _onEditProfilePhoneChanged(
    EditProfilePhoneChanged event,
    Emitter<EditProfileState> emit,
  ) async {
    _phone = event.phone;
    _validateForm(emit);
  }

  FutureOr<void> _onEditProfileGetUUser(
    EditProfileGetUser event,
    Emitter<EditProfileState> emit,
  ) async {
    _name = event.user.name;
    _username = event.user.username;
    _email = event.user.email;
    _phone = event.user.phone;

    emit(EditProfileLoading());

    await Future.delayed(const Duration(seconds: 1));

    emit(EditProfileLoaded(
      user: User(
        id: event.user.id,
        name: _name,
        email: _email,
        username: _username,
        phone: _phone,
      ),
    ));
  }

  Future<void> _onEditProfileSubmitPressed(
    EditProfileSubmitPressed event,
    Emitter<EditProfileState> emit,
  ) async {
    final validation = _getValidationErrors();

    if (!validation.isValid) {
      emit(EditProfileFormValidation(
        nameError: validation.nameError,
        usernameError: validation.usernameError,
        emailError: validation.emailError,
        phoneError: validation.phoneError,
        isValid: false,
      ));
      return;
    }

    emit(EditProfileLoading());

    final result = await updateUser(UpdateUserParams(
      name: _name,
      email: _email,
      username: _username,
    ));

    result.fold(
      (failure) => emit(EditProfileFailed(message: failure.message)),
      (user) => emit(EditProfileSubmitSuccess(message: 'Profile updated successfully')),
    );
  }

  void _validateForm(Emitter<EditProfileState> emit) {
    final validation = _getValidationErrors();

    emit(EditProfileFormValidation(
      nameError: validation.nameError,
      usernameError: validation.usernameError,
      emailError: validation.emailError,
      phoneError: validation.phoneError,
      isValid: validation.isValid,
    ));
  }

  _ValidationResult _getValidationErrors() {
    String? nameError;
    String? usernameError;
    String? emailError;
    String? phoneError;

    if (_name.isEmpty) nameError = 'error_name_required';

    if (_username.isEmpty) usernameError = 'error_username_invalid';

    if (!_isValidEmail(_email)) emailError = 'error_email_invalid';

    if (!_isValidPhone(_phone)) phoneError = 'error_phone_invalid';

    return _ValidationResult(
      nameError: nameError,
      usernameError: usernameError,
      emailError: emailError,
      phoneError: phoneError,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email);
  }

  bool _isValidPhone(String phone) {
    return RegExp(r'^[0-9]{9,12}$').hasMatch(phone);
  }
}

class _ValidationResult {
  final String? nameError;
  final String? usernameError;
  final String? emailError;
  final String? phoneError;

  bool get isValid =>
      nameError == null &&
      usernameError == null &&
      emailError == null &&
      phoneError == null;

  _ValidationResult({
    this.nameError,
    this.usernameError,
    this.emailError,
    this.phoneError,
  });
}