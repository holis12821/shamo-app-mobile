part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditProfileNameChanged extends EditProfileEvent {
  final String name;

  EditProfileNameChanged({required this.name});

  @override
  List<Object?> get props => [name];
}

class EditProfileUsernameChanged extends EditProfileEvent {
  final String username;

  EditProfileUsernameChanged({required this.username});

  @override
  List<Object?> get props => [username];
}

class EditProfileEmailChanged extends EditProfileEvent {
  final String email;

  EditProfileEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class EditProfilePhoneChanged extends EditProfileEvent {
  final String phone;

  EditProfilePhoneChanged({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class EditProfileGetUser extends EditProfileEvent {
  final User user;
  EditProfileGetUser(this.user);

  @override
  List<Object?> get props => [user];
}

class EditProfileSubmitPressed extends EditProfileEvent {}
