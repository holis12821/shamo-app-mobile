part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadUser extends ProfileEvent {
  const ProfileLoadUser();
}

class ProfileLogoutRequested extends ProfileEvent {
  const ProfileLogoutRequested();
}