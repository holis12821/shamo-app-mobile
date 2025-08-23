import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/domain/entity/User.dart';
import 'package:shamoapps/helper/utils/id_generator.dart';
import 'package:shamoapps/presentation/screens/edit_profile_screen/bloc/edit_profile_bloc.dart';
import 'package:shamoapps/presentation/screens/edit_profile_screen/view/edit_profile_view.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileBloc()
        ..add(
          EditProfileGetUser(
            User(
              id: IdGenerator.generateUserId(),
              name: 'John Doe',
              email: 'johndoe@example.com',
              phone: '08123456789',
              username: 'johndoe',
            ),
          ),
        ),
      child: const EditProfileView(),
    );
  }
}
