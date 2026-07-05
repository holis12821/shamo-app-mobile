import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/core/usecases/usecase.dart';
import 'package:shamoapps/domain/entity/user.dart';
import 'package:shamoapps/domain/usecase/get_user.dart';
import 'package:shamoapps/domain/usecase/logout.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUser getUser;
  final Logout logout;

  ProfileBloc({required this.getUser, required this.logout})
      : super(const ProfileInitial()) {
    on<ProfileLoadUser>(_onLoadUser);
    on<ProfileLogoutRequested>(_onLogout);
  }

  Future<void> _onLoadUser(
    ProfileLoadUser event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    final result = await getUser(const NoParams());
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(ProfileLoaded(user)),
    );
  }

  Future<void> _onLogout(
    ProfileLogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    final result = await logout(const NoParams());
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => emit(const ProfileLoggedOut()),
    );
  }
}