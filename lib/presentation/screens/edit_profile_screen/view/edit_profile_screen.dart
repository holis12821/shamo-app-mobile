import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/core/di/service_locator.dart';
import 'package:shamoapps/domain/entity/user.dart';
import 'package:shamoapps/domain/usecase/update_user.dart';
import 'package:shamoapps/presentation/screens/edit_profile_screen/bloc/edit_profile_bloc.dart';
import 'package:shamoapps/presentation/screens/edit_profile_screen/view/edit_profile_view.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc(updateUser: sl<UpdateUser>())
        ..add(
          EditProfileGetUser(
            const User(
              id: 0,
              name: 'John Doe',
              email: 'johndoe@example.com',
              username: 'johndoe',
              phone: '08123456789',
            ),
          ),
        ),
      child: const EditProfileView(),
    );
  }
}