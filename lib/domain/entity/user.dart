import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? username;

  const User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.username,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        username,
      ];
}
