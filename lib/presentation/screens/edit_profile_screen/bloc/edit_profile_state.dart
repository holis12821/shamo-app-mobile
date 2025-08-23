part of 'edit_profile_bloc.dart';

sealed class EditProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {
  final User user;

  EditProfileLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class EditProfileFormValidation extends EditProfileState {
  final String? nameError;
  final String? usernameError;
  final String? emailError;
  final String? phoneError;
  final bool isValid;

  EditProfileFormValidation({
    this.nameError,
    this.usernameError,
    this.emailError,
    this.phoneError,
    required this.isValid,
  });

  @override
  List<Object?> get props => [nameError, usernameError, emailError, phoneError, isValid];
}

class EditProfileSubmitSuccess extends EditProfileState {

  final String message;

  EditProfileSubmitSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class EditProfileFailed extends EditProfileState {
  final String message;

  EditProfileFailed({required this.message});

  @override
  List<Object?> get props => [message];
}