import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String username;
  final String phone;
  final String roles;
  final String profilePhotoUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.phone = '',
    this.roles = '',
    this.profilePhotoUrl = '',
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        username,
        phone,
        roles,
        profilePhotoUrl,
      ];
}